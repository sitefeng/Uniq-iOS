//
//  JPCoreDataHelper.m
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPCoreDataHelper.h"
#import "UserFavItem.h"
#import "Featured.h"
#import "JPCloudFavoritesHelper.h"
#import "JPGlobal.h"
#import "JPLocation.h"
#import "User.h"
#import "Program.h"
#import "Faculty.h"
#import "School.h"
#import "ManagedObjects+JPConvenience.h"


@implementation JPCoreDataHelper


- (instancetype)init
{
    self = [super init];
    if(self)
    {
        UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        context = [delegate managedObjectContext];
        
        _connectivity = [JPConnectivityManager sharedManager];
        
        _cloudFav = [[JPCloudFavoritesHelper alloc] init];
        _cloudFav.delegate = self;
        
        _dataRequest = [JPDataRequest request];
        _dataRequest.delegate = self;
        
    }
    
    return self;
}

#pragma mark - Retrieving User Location Info

- (CGFloat)distanceToUserLocationWithLocation: (JPLocation*)location
{
    NSFetchRequest* userRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSArray* userArray = [context executeFetchRequest:userRequest error:nil];
    User* user = nil;
    if([userArray count] >0)
    {
        user = [userArray firstObject];
        if([user.latitude floatValue] == 0 || [user.longitude floatValue] == 0)
        {
            return -1;
        }
        
        CGFloat distanceToHome = [location distanceToCoordinate:CGPointMake([user.latitude doubleValue], [user.longitude doubleValue])];
        return distanceToHome;
    }
    else
    {
        return -1;
    }
}



#pragma mark - Favoriting Items
- (void)removeFavoriteWithItemId:(NSString *)itemId
{
    NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
    favReq.predicate = [NSPredicate predicateWithFormat:@"favItemId = %@", itemId];
    NSArray* results = [context executeFetchRequest:favReq error:nil];
    
    for(UserFavItem* item in results)
    {
        [context deleteObject:item];
    }
    [context save:nil];
}


- (void)addFavoriteWithItemId:(NSString *)itemId andType:(JPDashletType)type
{
    NSEntityDescription* newFavItemDes = [NSEntityDescription entityForName:@"UserFavItem" inManagedObjectContext:context];
    _userFav = (UserFavItem*)[[NSManagedObject alloc] initWithEntity:newFavItemDes insertIntoManagedObjectContext:context];

    _userFav.favItemId = itemId;
    _userFav.type = [NSNumber numberWithInteger:type];
    _userFav.gotOffer = @false;
    _userFav.researched = @false;
    _userFav.response = @false;
    _userFav.applied = @false;

    NSFetchRequest* userFetch = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSArray* userArray = [context executeFetchRequest:userFetch error:nil];
    _userFav.user = [userArray firstObject];
    [context insertObject:_userFav];
    [context save:nil];
    
    ////////////////////////////////
    //Send Favorites To Server
    [_cloudFav uploadItemFavoritedWithUid:itemId];
    
    //Download Item To Device
    [self downloadItemToCoreDataWithItemId:itemId itemType:type];
    
}


- (BOOL)isFavoritedWithItemId:(NSString *)itemId
{
    NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
    favReq.predicate = [NSPredicate predicateWithFormat:@"favItemId = %@", itemId];
    NSArray* results = [context executeFetchRequest:favReq error:nil];
    
    if([results count] > 1)
    {
        NSLog(@"TOO Many Favorite Results: [%lu Results]", (unsigned long)[results count]);
        return YES;
    }
    else if([results count] == 1)
        return YES;
    else
        return NO;
}


#pragma mark - Retrieving from Core Data

- (NSDictionary*)retrieveItemDictionaryFromCoreDataWithItemId:(NSString*)itemId withType: (JPDashletType)type
{
    NSArray* objectNames = @[@"School", @"Faculty", @"Program"];
    NSArray* predicates = @[[NSPredicate predicateWithFormat:@"schoolId = %@", itemId]
                            , [NSPredicate predicateWithFormat:@"facultyId = %@", itemId]
                            , [NSPredicate predicateWithFormat:@"programId = %@", itemId]];

    NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:objectNames[type]];
    favReq.predicate = predicates[type];
    NSArray* results = [context executeFetchRequest:favReq error:nil];
    
    if(!results || [results count]==0)
    {
        return nil;
    }
    
    NSDictionary* resultsDict = @{};
    if(type == JPDashletTypeSchool)
    {
        School* school = (School*)[results firstObject];
        resultsDict = [school dictionaryRepresentation];
    }
    else if(type == JPDashletTypeSchool)
    {
        Faculty* faculty = (Faculty*)[results firstObject];
        resultsDict = [faculty dictionaryRepresentation];
    }
    else
    {
        Program* program = (Program*)[results firstObject];
        resultsDict = [program dictionaryRepresentation];
    }
    
    
    return resultsDict;
    
}


#pragma mark - Downloading Contents from Server

- (void)downloadItemToCoreDataWithItemId:(NSString*)itemId itemType:(JPDashletType)type
{
    [_dataRequest requestItemDetailsWithId:itemId ofType:type];
    [context save:nil];
}


- (void)dataRequest:(JPDataRequest *)request didLoadItemDetailsWithId:(NSString *)itemId ofType:(JPDashletType)type dataDict:(NSDictionary *)dict isSuccessful:(BOOL)success
{
    if(type == JPDashletTypeSchool)
    {
        School* school = [[School alloc] initWithDictionary:dict];
        school.toDelete = @NO;
        
        if(_downloadItemFacultyToBeLinked)
        {
            school.faculties = [[NSSet alloc] initWithObjects:_downloadItemFacultyToBeLinked, nil];
            _downloadItemFacultyToBeLinked = nil;
        }
        [context insertObject:school];
        
        NSLog(@"School Downloaded and Linked");
    }
    else if(type == JPDashletTypeFaculty)
    {
        Faculty* faculty = [[Faculty alloc] initWithDictionary:dict];
        faculty.toDelete = @NO;
        _downloadItemFacultyToBeLinked = faculty;
        
        if(_downloadItemProgramToBeLinked)
        {
            faculty.programs = [[NSSet alloc] initWithObjects:_downloadItemProgramToBeLinked, nil];
            _downloadItemProgramToBeLinked = nil;
        }
        [context insertObject:faculty];
        
        NSLog(@"Faculty Downloaded and Linked");
        [self downloadItemToCoreDataWithItemId:faculty.schoolId itemType:JPDashletTypeSchool];
    }
    else //program
    {
        Program* program = [[Program alloc] initWithDictionary:dict];
        program.toDelete = @NO;
        _downloadItemProgramToBeLinked = program;
        [context insertObject:program];
        
        NSLog(@"Program Downloaded and Linked");
        [self downloadItemToCoreDataWithItemId:program.facultyId itemType:JPDashletTypeFaculty];
    }
    
    
}



#pragma mark - Cloud Favorites Helper Delegate

- (void)cloudFavHelper:(JPCloudFavoritesHelper *)helper didFinishUploadItemFavoritedWithUid:(NSString *)uid itemExistsAlready:(BOOL)exists success:(BOOL)success
{
    if(success && !exists)
        NSLog(@"Firebase Favorites successfully updated");
}



#pragma mark - Featured Dashlets
- (NSArray*)retrieveFeaturedItems
{
//    //Delete Everything from before first
//    NSFetchRequest* req = [[NSFetchRequest alloc] initWithEntityName:@"Featured"];
//    NSArray* results = [context executeFetchRequest:req error:nil];
//    for(Featured* object in results)
//    {
//        [context deleteObject:object];
//    }
//    
//    NSURL* fileUrl = [[NSBundle mainBundle] URLForResource:@"getAllFeaturedInfo" withExtension:@"json"];
//    NSData* featuredData = [NSData dataWithContentsOfURL:fileUrl];
//    NSError* error = nil;
//    NSArray* jsonObject = [NSJSONSerialization JSONObjectWithData:featuredData options:NSJSONReadingAllowFragments error:&error];
//    
//    if(error)
//        NSLog(@"Error: %@", error);
//    
//    NSMutableArray* featuredArray = [NSMutableArray array];
//    
//    for(NSDictionary* featuredDict in jsonObject)
//    {
//        NSEntityDescription* featuredDesc = [NSEntityDescription entityForName:@"Featured" inManagedObjectContext:context];
//        NSManagedObject* featured = [[NSManagedObject alloc] initWithEntity:featuredDesc insertIntoManagedObjectContext:context];
//        
//        [featured setValue:[featuredDict valueForKey:@"id"] forKey:@"featuredId"];
//        if([featuredDict valueForKey:@"linkedUrl"]!=[NSNull null])
//            [featured setValue:[featuredDict valueForKey:@"linkedUrl"] forKey:@"linkedUrl"];
//        
//        [featured setValue:[featuredDict valueForKey:@"linkedUid"] forKey:@"linkedUid"];
//        [featured setValue:[featuredDict valueForKey:@"title"] forKey:@"title"];
//        [featured setValue:[featuredDict valueForKey:@"imageLink"] forKey:@"imageLink"];
//        
//        [featuredArray addObject:featured];
//        [context insertObject:featured];
//    }
//    
//    [context save:nil];
//
//    return featuredArray;

    return nil;

}




@end
