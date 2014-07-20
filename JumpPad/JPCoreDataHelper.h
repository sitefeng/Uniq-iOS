//
//  JPCoreDataHelper.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserFavItem;
@interface JPCoreDataHelper : NSObject
{
    
    NSManagedObjectContext* context;
    
    UserFavItem*  _userFav;
}



- (void)removeFavoriteWithDashletUid: (NSUInteger)dashletUid;
- (void)addFavoriteWithDashletUid: (NSUInteger)dashletUid andType: (JPDashletType)type;
- (BOOL)isFavoritedWithDashletUid: (NSUInteger)dashletUid;



- (NSArray*)retrieveFeaturedItems;


@end
