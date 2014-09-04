//
//  JPRatings.h
//  Uniq
//
//  Created by Si Te Feng on 8/23/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPRatings : NSObject



@property (nonatomic, assign) double ratingOverall;
@property (nonatomic, assign) double difficulty;
@property (nonatomic, assign) double professors;
@property (nonatomic, assign) double schedule;
@property (nonatomic, assign) double classmates;
@property (nonatomic, assign) double social;
@property (nonatomic, assign) double studyEnv;
@property (nonatomic, assign) double guyRatio;


- (instancetype)initWithOrderedArray: (NSArray*)ratingsArray;
- (instancetype)initWithShortKeyDictionary: (NSDictionary*)dict;

- (NSArray*)getOrderedArray;
- (NSDictionary*)getFullKeyDictionaryRepresentation;
- (NSDictionary*)getShortKeyDictionaryRepresentation;


//Utility Methods
- (JPRatings*)getNewAvgRatingByAppendingAvg:(JPRatings*)avgRatings withWeight:(NSInteger)weight;

- (JPRatings*)getNewAvgRatingByUpdatingAvg:(JPRatings*)avgRatings withWeight:(NSInteger)weight withOldUserRatings:(JPRatings*)oldRatings;



@end
