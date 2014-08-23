//
//  JPRatings.h
//  Uniq
//
//  Created by Si Te Feng on 8/23/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPRatings : NSObject



@property (nonatomic, assign) NSInteger ratingOverall;
@property (nonatomic, assign) NSInteger difficulty;
@property (nonatomic, assign) NSInteger professors;
@property (nonatomic, assign) NSInteger schedule;
@property (nonatomic, assign) NSInteger classmates;
@property (nonatomic, assign) NSInteger social;
@property (nonatomic, assign) NSInteger studyEnv;
@property (nonatomic, assign) NSInteger guyRatio;


- (instancetype)initWithOrderedArray: (NSArray*)ratingsArray;
- (instancetype)initWithShortKeyDictionary: (NSDictionary*)dict;
- (NSArray*)getOrderedArray;


- (NSDictionary*)getFullKeyDictionaryRepresentation;
- (NSDictionary*)getShortKeyDictionaryRepresentation;


@end
