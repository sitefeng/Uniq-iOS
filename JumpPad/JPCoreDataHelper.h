//
//  JPCoreDataHelper.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPCloudFavoritesHelper.h"

@class UserFavItem;
@interface JPCoreDataHelper : NSObject <JPCloudFavoritesHelperDelegate>
{
    
    NSManagedObjectContext* context;
    
    UserFavItem*  _userFav;
    
    JPCloudFavoritesHelper* _cloudFav;
}



- (void)removeFavoriteWithDashletUid: (NSUInteger)dashletUid;
- (void)addFavoriteWithDashletUid: (NSUInteger)dashletUid andType: (JPDashletType)type;
- (BOOL)isFavoritedWithDashletUid: (NSUInteger)dashletUid;



- (NSArray*)retrieveFeaturedItems;


@end
