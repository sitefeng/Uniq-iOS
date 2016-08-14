//
//  UserFavItem+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserFavItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserFavItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *applied;
@property (nullable, nonatomic, retain) NSString *favItemId;
@property (nullable, nonatomic, retain) NSNumber *gotOffer;
@property (nullable, nonatomic, retain) NSNumber *researched;
@property (nullable, nonatomic, retain) NSNumber *response;
@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
