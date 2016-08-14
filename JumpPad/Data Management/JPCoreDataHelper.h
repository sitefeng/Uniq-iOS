//
//  JPCoreDataHelper.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPCloudFavoritesHelper.h"
#import "JPDataRequest.h"
#import "JPConnectivityManager.h"


@class UserFavItem, JPLocation, Program, Faculty, School;
@interface JPCoreDataHelper : NSObject <JPCloudFavoritesHelperDelegate, JPDataRequestDelegate>
{
    
    NSManagedObjectContext* context;
    JPConnectivityManager* _connectivity;
    
    UserFavItem*  _userFav;
    
    JPCloudFavoritesHelper* _cloudFav;
    
    
    Program*      _downloadItemProgramToBeLinked;
    Faculty*      _downloadItemFacultyToBeLinked;
}


- (CGFloat)distanceToUserLocationWithLocation: (JPLocation*)location;


//Favoriting
- (void)removeFavoriteWithItemId: (NSString*)itemId withType:(JPDashletType)type;
- (void)addFavoriteWithItemId:(NSString *)itemId andType:(JPDashletType)type schoolSlug: (NSString *)schoolSlug facultySlug: (NSString *)facultySlug programSlug: (NSString *)programSlug;

- (BOOL)isFavoritedWithItemId: (NSString*)itemId;


//Retrieving from Core Data
- (NSManagedObject*)retrieveItemFromCoreDataWithItemId: (NSString*)itemId withType: (JPDashletType)type;

- (NSDictionary*)retrieveItemDictionaryFromCoreDataWithItemId:(NSString*)itemId withType: (JPDashletType)type;
- (NSArray*)retrieveItemsArrayFromCoreDataWithParentItemId:(NSString*)itemId withChildType:(JPDashletType)type;


//Deleting
- (void)deleteAllTemporaryItemsFromCoreData;


//Downloading
- (void)downloadItemToCoreDataWithItemId:(NSString*)itemId itemType:(JPDashletType)type schoolSlug: (NSString *)schoolSlug facultySlug: (NSString *)facultySlug programSlug: (NSString *)programSlug;





@end
