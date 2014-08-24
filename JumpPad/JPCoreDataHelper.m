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


@implementation JPCoreDataHelper


- (instancetype)init
{
    self = [super init];
    if(self)
    {
        UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        context = [delegate managedObjectContext];
        
        _cloudFav = [[JPCloudFavoritesHelper alloc] init];
        _cloudFav.delegate = self;
    }
    
    return self;
}


#pragma mark - Favoriting Items
- (void)removeFavoriteWithDashletUid: (NSUInteger)dashletUid
{
    NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
    favReq.predicate = [NSPredicate predicateWithFormat:@"itemId = %@", [NSNumber numberWithInteger:dashletUid]];
    NSArray* results = [context executeFetchRequest:favReq error:nil];
    
    for(UserFavItem* item in results)
    {
        [context deleteObject:item];
    }
    [context save:nil];
}


- (void)addFavoriteWithDashletUid: (NSUInteger)dashletUid andType: (JPDashletType)type
{
    NSEntityDescription* newFavItemDes = [NSEntityDescription entityForName:@"UserFavItem" inManagedObjectContext:context];
    _userFav = (UserFavItem*)[[NSManagedObject alloc] initWithEntity:newFavItemDes insertIntoManagedObjectContext:context];

    _userFav.itemId = [NSNumber numberWithInteger:dashletUid];
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
    NSInteger itemId = [JPGlobal itemIdWithDashletUid:dashletUid type:type];
    [_cloudFav uploadItemFavoritedWithUid:[NSString stringWithFormat:@"%ld", (long)itemId]];
    
}


- (BOOL)isFavoritedWithDashletUid: (NSUInteger)dashletUid
{
    NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
    favReq.predicate = [NSPredicate predicateWithFormat:@"itemId = %@", [NSNumber numberWithInteger:dashletUid]];
    NSArray* results = [context executeFetchRequest:favReq error:nil];
    
    if([results count] > 0)
        return YES;
    else
        return NO;
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
    //Delete Everything from before first
    NSFetchRequest* req = [[NSFetchRequest alloc] initWithEntityName:@"Featured"];
    NSArray* results = [context executeFetchRequest:req error:nil];
    for(Featured* object in results)
    {
        [context deleteObject:object];
    }
    
    NSURL* fileUrl = [[NSBundle mainBundle] URLForResource:@"getAllFeaturedInfo" withExtension:@"json"];
    NSData* featuredData = [NSData dataWithContentsOfURL:fileUrl];
    NSError* error = nil;
    NSArray* jsonObject = [NSJSONSerialization JSONObjectWithData:featuredData options:NSJSONReadingAllowFragments error:&error];
    
    if(error)
        NSLog(@"Error: %@", error);
    
    NSMutableArray* featuredArray = [NSMutableArray array];
    
    for(NSDictionary* featuredDict in jsonObject)
    {
        NSEntityDescription* featuredDesc = [NSEntityDescription entityForName:@"Featured" inManagedObjectContext:context];
        NSManagedObject* featured = [[NSManagedObject alloc] initWithEntity:featuredDesc insertIntoManagedObjectContext:context];
        
        [featured setValue:[featuredDict valueForKey:@"id"] forKey:@"featuredId"];
        if([featuredDict valueForKey:@"linkedUrl"]!=[NSNull null])
            [featured setValue:[featuredDict valueForKey:@"linkedUrl"] forKey:@"linkedUrl"];
        
        [featured setValue:[featuredDict valueForKey:@"linkedUid"] forKey:@"linkedUid"];
        [featured setValue:[featuredDict valueForKey:@"title"] forKey:@"title"];
        [featured setValue:[featuredDict valueForKey:@"imageLink"] forKey:@"imageLink"];
        
        [featuredArray addObject:featured];
        [context insertObject:featured];
    }
    
    [context save:nil];

    return featuredArray;
}




@end
