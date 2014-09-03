//
//  UserFavItem.h
//  Uniq
//
//  Created by Si Te Feng on 9/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface UserFavItem : NSManagedObject

@property (nonatomic, retain) NSNumber * applied;
@property (nonatomic, retain) NSNumber * gotOffer;
@property (nonatomic, retain) NSNumber * researched;
@property (nonatomic, retain) NSNumber * response;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * favItemId;
@property (nonatomic, retain) User *user;

@end
