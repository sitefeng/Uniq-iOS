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
    JPDataRequest*  _dataRequest;
    
    Program*      _downloadItemProgramToBeLinked;
    Faculty*      _downloadItemFacultyToBeLinked;
}


- (CGFloat)distanceToUserLocationWithLocation: (JPLocation*)location;


//Favoriting
- (void)removeFavoriteWithItemId: (NSString*)itemId;
- (void)addFavoriteWithItemId: (NSString*)itemId andType: (JPDashletType)type;
- (BOOL)isFavoritedWithItemId: (NSString*)itemId;


//Retrieving from Core Data
- (NSDictionary*)retrieveItemDictionaryFromCoreDataWithItemId:(NSString*)itemId withType: (JPDashletType)type;

//Downloading
- (void)downloadItemToCoreDataWithItemId:(NSString*)itemId itemType:(JPDashletType)type;


//Featured
- (NSArray*)retrieveFeaturedItems;


@end
