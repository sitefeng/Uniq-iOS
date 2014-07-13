//
//  JPCoreDataHelper.m
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPCoreDataHelper.h"
#import "UserFavItem.h"


@implementation JPCoreDataHelper


- (instancetype)init
{
    self = [super init];
    if(self)
    {
        UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        context = [delegate managedObjectContext];
    }
    
    return self;
}


- (void)removeFavoriteWithDashletUid: (NSUInteger)dashletUid
{
    NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
    favReq.predicate = [NSPredicate predicateWithFormat:@"itemId = %@", [NSNumber numberWithInteger:dashletUid]];
    NSArray* results = [context executeFetchRequest:favReq error:nil];
    
    for(UserFavItem* item in results)
    {
        [context deleteObject:item];
    }
}


- (void)addFavoriteWithDashletUid: (NSUInteger)dashletUid andType: (JPDashletType)type
{
    NSEntityDescription* newFavItemDes = [NSEntityDescription  entityForName:@"UserFavItem" inManagedObjectContext:context];
    UserFavItem* newItem = (UserFavItem*)[[NSManagedObject alloc] initWithEntity:newFavItemDes insertIntoManagedObjectContext:context];

    newItem.itemId = [NSNumber numberWithInteger:dashletUid];
    newItem.type = [NSNumber numberWithInteger:type];

    [context insertObject:newItem];
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




@end
