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

#import "Uniq-Swift.h"


@interface JPCoreDataHelper()

@property (nonatomic, strong) JPDataRequest *dataRequest;
@property (nonatomic, strong) JPOfflineDataRequest *offlineDataRequest;

@end

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
- (void)removeFavoriteWithItemId:(NSString *)itemId withType:(JPDashletType)type
{
    //Deleting Favorite Item
    NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
    favReq.predicate = [NSPredicate predicateWithFormat:@"favItemId = %@", itemId];
    NSArray* results = [context executeFetchRequest:favReq error:nil];
    
    for(UserFavItem* item in results)
    {
        [context deleteObject:item];
    }
    
    //Deleting actual data from Core Data
    /* First mark the item itself as toDelete, then check if parent item has anymore children, if not, check if parent is favorited, if still not, mark the parent as toDelete, cascading up.*/
    
    if(type == JPDashletTypeProgram)
    {
        NSString* facultyId = nil;
        NSString* schoolId = nil;
        
        NSFetchRequest* programReq = [[NSFetchRequest alloc] initWithEntityName:@"Program"];
        programReq.predicate = [NSPredicate predicateWithFormat:@"programId = %@ && toDelete = %@", itemId, @NO]; //toDelete param because we want to cascade delete up if neccessary
        NSArray* programs = [context executeFetchRequest:programReq error:nil];
        
        for(Program* program in programs) {
            facultyId = [program.facultyId copy];
            schoolId = [program.schoolId copy];
            [context deleteObject:program];
        }
        
        //check if faculty is favorited
        NSFetchRequest* facultyReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
        facultyReq.predicate = [NSPredicate predicateWithFormat:@"favItemId = %@", facultyId];
        NSArray* facultyResults = [context executeFetchRequest:favReq error:nil];
        
        if(!facultyResults || [facultyResults count] == 0) //faculty not favorited, could delete
        {
            NSFetchRequest* deleteFacReq = [[NSFetchRequest alloc] initWithEntityName:@"Faculty"];
            deleteFacReq.predicate = [NSPredicate predicateWithFormat:@"facultyId = %@ && toDelete = %@",facultyId, @NO];
            NSArray* faculties = [context executeFetchRequest:deleteFacReq error:nil];
            
            Faculty* theFaculty = [faculties firstObject];
            
            //check if faculty has anymore children
            NSArray* children = [theFaculty.programs allObjects];
            
            if(!children || [children count]==0) //no other fav children, delete faculty
            {
                for(Faculty* deleteFaculty in faculties)
                {
                    [context deleteObject:deleteFaculty];
                }
                
                //check if school is favorited
                NSFetchRequest* schoolReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
                schoolReq.predicate = [NSPredicate predicateWithFormat:@"favItemId = %@", schoolId];
                NSArray* schoolResults = [context executeFetchRequest:schoolReq error:nil];
                
                if(!schoolResults || [schoolResults count]==0)//school not faved
                {
                    //check for any more children under school
                    NSFetchRequest* otherFacultyReq = [[NSFetchRequest alloc] initWithEntityName:@"Faculty"];
                    otherFacultyReq.predicate = [NSPredicate predicateWithFormat:@"schoolId = %@ && toDelete= %@",schoolId, @NO];
                    NSArray* otherFaculties = [context executeFetchRequest:otherFacultyReq error:nil];
                    
                    if(!otherFaculties || [otherFaculties count]==0)
                    {
                        //No other faculties, delete school
                        NSFetchRequest* deleteSchoolReq = [[NSFetchRequest alloc] initWithEntityName:@"School"];
                        deleteSchoolReq.predicate = [NSPredicate predicateWithFormat:@"schoolId = %@",schoolId];
                        NSArray* deleteSchools = [context executeFetchRequest:deleteSchoolReq error:nil];
                        for(School* deleteSchool in deleteSchools)
                        {
                            [context deleteObject:deleteSchool];
                        }
                    }
                }
            }
        }
    }
    else if(type == JPDashletTypeFaculty)
    {
        NSString* schoolId = nil;
        NSFetchRequest* facultyReq = [[NSFetchRequest alloc] initWithEntityName:@"Faculty"];
        facultyReq.predicate = [NSPredicate predicateWithFormat:@"facultyId = %@ && toDelete = %@", itemId, @NO];
        NSArray* faculties = [context executeFetchRequest:facultyReq error:nil];
        
        for(Faculty* faculty in faculties)
        {
            schoolId = faculty.schoolId;
            [context deleteObject:faculty];
        }
        
        //check if school is favorited
        NSFetchRequest* schoolFavItemRequest = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
        schoolFavItemRequest.predicate = [NSPredicate predicateWithFormat:@"favItemId = %@", schoolId];
        NSArray* schoolObjects = [context executeFetchRequest:schoolFavItemRequest error:nil];
        
        if(!schoolObjects || [schoolObjects count] == 0) //school not favorited, could delete
        {
            NSFetchRequest* schoolReq = [[NSFetchRequest alloc] initWithEntityName:@"School"];
            schoolReq.predicate = [NSPredicate predicateWithFormat:@"schoolId = %@ && toDelete = %@",schoolId, @NO];
            NSArray* schools = [context executeFetchRequest:schoolReq error:nil];
            
            School* theSchool = [schools firstObject];
            
            //check if school has anymore children
            NSArray* children = [theSchool.faculties allObjects];
            
            if(!children || [children count]==0) //no other fav children, delete school
            {
                for(School* school in schools)
                {
                    [context deleteObject:school];
                }
            }
        }
        
    }
    else if(type == JPDashletTypeSchool)
    {
        NSFetchRequest* req = [[NSFetchRequest alloc] initWithEntityName:@"School"];
        req.predicate = [NSPredicate predicateWithFormat:@"schoolId = %@", itemId];
        NSArray* schools = [context executeFetchRequest:req error:nil];
        
        for(School* school in schools) {
            [context deleteObject:school];
        }
    }
    
    [context save:nil];
}


- (void)addFavoriteWithItemId:(NSString *)itemId andType:(JPDashletType)type schoolSlug: (NSString *)schoolSlug facultySlug: (NSString *)facultySlug programSlug: (NSString *)programSlug {
    
    NSEntityDescription* newFavItemDes = [NSEntityDescription entityForName:@"UserFavItem" inManagedObjectContext:context];
    _userFav = (UserFavItem*)[[NSManagedObject alloc] initWithEntity:newFavItemDes insertIntoManagedObjectContext:context];

    _userFav.favItemId = itemId;
    _userFav.type = [NSNumber numberWithInteger:type];
    _userFav.gotOffer = @false;
    _userFav.researched = @false;
    _userFav.response = @false;
    _userFav.applied = @false;
    _userFav.schoolSlug = schoolSlug;
    _userFav.facultySlug = facultySlug;
    _userFav.programSlug = programSlug;

    NSFetchRequest* userFetch = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSArray* userArray = [context executeFetchRequest:userFetch error:nil];
    _userFav.user = [userArray firstObject];
    [context insertObject:_userFav];
    [context save:nil];
    
    ////////////////////////////////
    //Send Favorites To Server
    [_cloudFav uploadItemFavoritedWithUid:itemId];
    
    //Download Item To Device
    [self downloadItemToCoreDataWithItemId:itemId itemType:type schoolSlug:schoolSlug facultySlug:facultySlug programSlug:programSlug];
    
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

- (NSManagedObject*)retrieveItemFromCoreDataWithItemId: (NSString*)itemId withType: (JPDashletType)type
{
    NSArray* objectNames = @[@"School", @"Faculty", @"Program"];
    NSArray* predicates = @[[NSPredicate predicateWithFormat:@"schoolId = %@ && toDelete= %@", itemId, @NO]
                            , [NSPredicate predicateWithFormat:@"facultyId = %@ && toDelete= %@", itemId, @NO]
                            , [NSPredicate predicateWithFormat:@"programId = %@ && toDelete= %@", itemId, @NO]];
    
    NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:objectNames[type]];
    favReq.predicate = predicates[type];
    NSArray* results = [context executeFetchRequest:favReq error:nil];
    
    if(!results || [results count]==0)
    {
        return nil;
    }
    
    return [results firstObject];
}


- (NSDictionary*)retrieveItemDictionaryFromCoreDataWithItemId:(NSString*)itemId withType: (JPDashletType)type
{
    NSManagedObject* managedObject = [self retrieveItemFromCoreDataWithItemId:itemId withType:type];
    
    if(!managedObject)
        return nil;
    
    NSDictionary* resultsDict = @{};
    if(type == JPDashletTypeSchool)
    {
        School* school = (School*)managedObject;
        resultsDict = [school dictionaryRepresentation];
    }
    else if(type == JPDashletTypeSchool)
    {
        Faculty* faculty = (Faculty*)managedObject;
        resultsDict = [faculty dictionaryRepresentation];
    }
    else
    {
        Program* program = (Program*)managedObject;
        resultsDict = [program dictionaryRepresentation];
    }
    
    return resultsDict;
}



- (NSArray*)retrieveItemsArrayFromCoreDataWithParentItemId:(NSString*)itemId withChildType:(JPDashletType)type
{
    NSPredicate* predicate = nil;
    NSArray* managedObjects = nil;
    
    if(type == JPDashletTypeSchool)
    {
        predicate = [NSPredicate predicateWithFormat:@"toDelete = %@", @NO];
        NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"School"];
        fetchRequest.predicate = predicate;
        managedObjects = [context executeFetchRequest:fetchRequest error:nil];
    }
    else if(type == JPDashletTypeFaculty)
    {
        predicate = [NSPredicate predicateWithFormat:@"schoolId = %@ && toDelete = %@", itemId, @NO];
        NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Faculty"];
        fetchRequest.predicate = predicate;
        managedObjects = [context executeFetchRequest:fetchRequest error:nil];
    }
    else if(type == JPDashletTypeProgram)
    {
        predicate = [NSPredicate predicateWithFormat:@"facultyId = %@ && toDelete= %@", itemId, @NO];
        NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Program"];
        fetchRequest.predicate = predicate;
        managedObjects = [context executeFetchRequest:fetchRequest error:nil];
    }
    
    NSMutableArray* objectDictArray = [NSMutableArray array];
    
    if(type == JPDashletTypeSchool)
    {
        for(School* school in managedObjects)
        {
            NSDictionary* schoolDict = [school dictionaryRepresentation];
            [objectDictArray addObject:schoolDict];
        }
    }
    else if(type == JPDashletTypeFaculty)
    {
        for(Faculty* faculty in managedObjects)
        {
            NSDictionary* facultyDict = [faculty dictionaryRepresentation];
            [objectDictArray addObject:facultyDict];
        }
    }
    else if(type == JPDashletTypeProgram)
    {
        for(Program* program in managedObjects)
        {
            NSDictionary* programDict = [program dictionaryRepresentation];
            [objectDictArray addObject:programDict];
        }
    }
    
    return objectDictArray;
}



#pragma mark - Deleting Items

- (void)deleteAllTemporaryItemsFromCoreData
{
    NSFetchRequest* programReq = [[NSFetchRequest alloc] initWithEntityName:@"Program"];
    programReq.predicate = [NSPredicate predicateWithFormat:@"toDelete = %@", @YES];
    NSArray* programs = [context executeFetchRequest:programReq error:nil];
    
    for(Program* deleteProgram in programs)
    {
        [context deleteObject:deleteProgram];
    }
    
    NSFetchRequest* facultyReq = [[NSFetchRequest alloc] initWithEntityName:@"Faculty"];
    facultyReq.predicate = [NSPredicate predicateWithFormat:@"toDelete = %@", @YES];
    NSArray* faculties = [context executeFetchRequest:facultyReq error:nil];
    
    for(Program* deleteFaculty in faculties)
    {
        [context deleteObject:deleteFaculty];
    }
    
    NSFetchRequest* schoolReq = [[NSFetchRequest alloc] initWithEntityName:@"School"];
    schoolReq.predicate = [NSPredicate predicateWithFormat:@"toDelete = %@", @YES];
    NSArray* schools = [context executeFetchRequest:schoolReq error:nil];
    
    for(Program* deleteSchool in schools)
    {
        [context deleteObject:deleteSchool];
    }
    
    [context save:nil];
}



#pragma mark - Downloading Contents from Server

- (void)downloadItemToCoreDataWithItemId:(NSString*)itemId itemType:(JPDashletType)type schoolSlug: (NSString *)schoolSlug facultySlug: (NSString *)facultySlug programSlug: (NSString *)programSlug {
    
    if (JPUtility.isOfflineMode) {
        _offlineDataRequest = [[JPOfflineDataRequest alloc] init];
        
        NSDictionary *dataDict = @{};
        if (type == JPDashletTypeSchool) {
            dataDict = [_offlineDataRequest requestSchoolDetails:schoolSlug];
        } else if (type == JPDashletTypeFaculty) {
            dataDict = [_offlineDataRequest requestFacultyDetails:schoolSlug facultySlug:facultySlug];
        } else if (type == JPDashletTypeProgram) {
            dataDict = [_offlineDataRequest requestProgramDetails:schoolSlug facultySlug:facultySlug programSlug:programSlug];
        }
        [self finishedLoadingDetailsOfType:type itemId:itemId dataDict:dataDict isSuccessful:true];
        
    } else {
        [_dataRequest requestItemDetailsWithId:itemId ofType:type];
    }
    
}


- (void)dataRequest:(JPDataRequest *)request didLoadItemDetailsWithId:(NSString *)itemId ofType:(JPDashletType)type dataDict:(NSDictionary *)dict isSuccessful:(BOOL)success {
    [self finishedLoadingDetailsOfType:type itemId:itemId dataDict:dict isSuccessful:success];
}

- (void)finishedLoadingDetailsOfType: (JPDashletType)type itemId:(NSString*)itemId dataDict: (NSDictionary *)dict isSuccessful: (BOOL)success {
    
    if (!success) {
        return;
    }
    
    if(type == JPDashletTypeSchool)
    {
        //See if the school is already there
        School* school = (School*)[self retrieveItemFromCoreDataWithItemId:itemId withType:type];
        if(!school)
        {
            school = [[School alloc] initWithDictionary:dict];
            school.toDelete = @NO;
            [context insertObject:school];
        }
        
        if(_downloadItemFacultyToBeLinked)
        {
            [school addFacultiesObject: _downloadItemFacultyToBeLinked];
            _downloadItemFacultyToBeLinked = nil;
        }
        
        NSLog(@"School Downloaded and Linked");
    }
    else if(type == JPDashletTypeFaculty)
    {
        //See if the faculty is already there
        Faculty* faculty = (Faculty*)[self retrieveItemFromCoreDataWithItemId:itemId withType:type];
        if(!faculty)
        {
            faculty = [[Faculty alloc] initWithDictionary:dict];
            faculty.toDelete = @NO;
            [context insertObject:faculty];
        }
        
        _downloadItemFacultyToBeLinked = faculty;
        
        if(_downloadItemProgramToBeLinked)
        {
            [faculty addProgramsObject:_downloadItemProgramToBeLinked];
            _downloadItemProgramToBeLinked = nil;
        }
        
        NSLog(@"Faculty Downloaded and Linked");
        [self downloadItemToCoreDataWithItemId:faculty.schoolId itemType:JPDashletTypeSchool schoolSlug:faculty.schoolSlug facultySlug:faculty.slug programSlug:nil];
    }
    else //program
    {
        Program* program = (Program*)[self retrieveItemFromCoreDataWithItemId:itemId withType:type];
        if(!program)
        {
            program = [[Program alloc] initWithDictionary:dict];
            program.toDelete = @NO;
            [context insertObject:program];
        }
        
        _downloadItemProgramToBeLinked = program;
        
        NSLog(@"Program Downloaded and Linked");
        [self downloadItemToCoreDataWithItemId:program.facultyId itemType:JPDashletTypeFaculty schoolSlug:program.schoolSlug facultySlug:program.faculty programSlug:program.slug];
    }
    [context save:nil];

}


#pragma mark - Cloud Favorites Helper Delegate

- (void)cloudFavHelper:(JPCloudFavoritesHelper *)helper didFinishUploadItemFavoritedWithUid:(NSString *)uid itemExistsAlready:(BOOL)exists success:(BOOL)success
{
    if(success && !exists)
        NSLog(@"Firebase Favorites successfully updated");
}



@end
