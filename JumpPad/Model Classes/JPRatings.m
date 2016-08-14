//
//  JPRatings.m
//  Uniq
//
//  Created by Si Te Feng on 8/23/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPRatings.h"

@implementation JPRatings

#pragma mark - Initialization Methods

- (instancetype)init
{
    self = [super init];
    self.ratingOverall = -1;
    self.difficulty = -1;
    self.professors = -1;
    self.schedule = -1;
    self.classmates = -1;
    self.social = -1;
    self.studyEnv = -1;
    self.guyRatio = -1;
    self.weight = 0;
    
    return self;
}

- (instancetype)initWithDefaultValues {
    NSArray* orderedArray = @[@50.00,@50.00,@50.00,@50.00,@50.00,@50.00,@50.00,@50.00];
    self = [self initWithOrderedArray:orderedArray];
    return self;
}

- (instancetype)initWithOrderedArray: (NSArray*)ratingsArray
{
    self = [self init];
    
    self.ratingOverall = [ratingsArray[0] doubleValue];
    self.difficulty = [ratingsArray[1] doubleValue];
    self.professors = [ratingsArray[2] doubleValue];
    self.schedule = [ratingsArray[3] doubleValue];
    self.classmates = [ratingsArray[4] doubleValue];
    self.social = [ratingsArray[5] doubleValue];
    self.studyEnv = [ratingsArray[6] doubleValue];
    self.guyRatio = [ratingsArray[7] doubleValue];
    
    if([ratingsArray count]== 9)
        self.weight = [ratingsArray[8] doubleValue];
    
    return self;
}


- (instancetype)initWithShortKeyDictionary: (NSDictionary*)dict
{
    self = [self init];
    
    if(!dict || [dict isEqual:[NSNull null]])
        return self;
    
    self.ratingOverall = [[dict objectForKey:[self dictionaryShortKeyWithIndex:0]] doubleValue];
    self.difficulty = [[dict objectForKey:[self dictionaryShortKeyWithIndex:1]] doubleValue];
    self.professors = [[dict objectForKey:[self dictionaryShortKeyWithIndex:2]] doubleValue];
    self.schedule = [[dict objectForKey:[self dictionaryShortKeyWithIndex:3]] doubleValue];
    self.classmates = [[dict objectForKey:[self dictionaryShortKeyWithIndex:4]] doubleValue];
    self.social = [[dict objectForKey:[self dictionaryShortKeyWithIndex:5]] doubleValue];
    self.studyEnv = [[dict objectForKey:[self dictionaryShortKeyWithIndex:6]] doubleValue];
    self.guyRatio = [[dict objectForKey:[self dictionaryShortKeyWithIndex:7]] doubleValue];
    self.weight = [[dict objectForKey:@"w"] integerValue];
    
    return self;
    
}

- (instancetype)initWithFullKeyDictionary: (NSDictionary*)dict
{
    self = [self init];
    
    if(!dict || [dict isEqual:[NSNull null]])
        return self;
    
    self.ratingOverall = [[dict objectForKey:[self dictionaryKeyWithIndex:0]] doubleValue];
    self.difficulty = [[dict objectForKey:[self dictionaryKeyWithIndex:1]] doubleValue];
    self.professors = [[dict objectForKey:[self dictionaryKeyWithIndex:2]] doubleValue];
    self.schedule = [[dict objectForKey:[self dictionaryKeyWithIndex:3]] doubleValue];
    self.classmates = [[dict objectForKey:[self dictionaryKeyWithIndex:4]] doubleValue];
    self.social = [[dict objectForKey:[self dictionaryKeyWithIndex:5]] doubleValue];
    self.studyEnv = [[dict objectForKey:[self dictionaryKeyWithIndex:6]] doubleValue];
    self.guyRatio = [[dict objectForKey:[self dictionaryKeyWithIndex:7]] doubleValue];
    self.weight = [[dict objectForKey:[self dictionaryKeyWithIndex:8]] integerValue];
    
    return self;
}


#pragma mark - Getting value in structures

- (NSDictionary*)getFullKeyDictionaryRepresentation
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[NSNumber numberWithDouble:self.ratingOverall] forKey:[self dictionaryKeyWithIndex:0]];
    [dict setObject:[NSNumber numberWithDouble:self.difficulty] forKey:[self dictionaryKeyWithIndex:1]];
    [dict setObject:[NSNumber numberWithDouble:self.professors] forKey:[self dictionaryKeyWithIndex:2]];
    [dict setObject:[NSNumber numberWithDouble:self.schedule] forKey:[self dictionaryKeyWithIndex:3]];
    [dict setObject:[NSNumber numberWithDouble:self.classmates] forKey:[self dictionaryKeyWithIndex:4]];
    [dict setObject:[NSNumber numberWithDouble:self.social] forKey:[self dictionaryKeyWithIndex:5]];
    [dict setObject:[NSNumber numberWithDouble:self.studyEnv] forKey:[self dictionaryKeyWithIndex:6]];
    [dict setObject:[NSNumber numberWithDouble:self.guyRatio] forKey:[self dictionaryKeyWithIndex:7]];
    [dict setObject:[NSNumber numberWithInteger:self.weight] forKey:[self dictionaryKeyWithIndex:8]];
    
    return dict;
}


- (NSDictionary*)getShortKeyDictionaryRepresentation
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[NSNumber numberWithDouble:self.ratingOverall] forKey:[self dictionaryShortKeyWithIndex:0]];
    [dict setObject:[NSNumber numberWithDouble:self.difficulty] forKey:[self dictionaryShortKeyWithIndex:1]];
    [dict setObject:[NSNumber numberWithDouble:self.professors] forKey:[self dictionaryShortKeyWithIndex:2]];
    [dict setObject:[NSNumber numberWithDouble:self.schedule] forKey:[self dictionaryShortKeyWithIndex:3]];
    [dict setObject:[NSNumber numberWithDouble:self.classmates] forKey:[self dictionaryShortKeyWithIndex:4]];
    [dict setObject:[NSNumber numberWithDouble:self.social] forKey:[self dictionaryShortKeyWithIndex:5]];
    [dict setObject:[NSNumber numberWithDouble:self.studyEnv] forKey:[self dictionaryShortKeyWithIndex:6]];;
    [dict setObject:[NSNumber numberWithDouble:self.guyRatio] forKey:[self dictionaryShortKeyWithIndex:7]];
    [dict setObject:[NSNumber numberWithInteger:self.weight] forKey:@"w"];
    
    return dict;
    
}


- (NSArray*)getOrderedArray
{
    
    NSArray* array = @[[NSNumber numberWithDouble:self.ratingOverall],
                       [NSNumber numberWithDouble:self.difficulty],
                       [NSNumber numberWithDouble:self.professors],
                       [NSNumber numberWithDouble:self.schedule],
                       [NSNumber numberWithDouble:self.classmates],
                       [NSNumber numberWithDouble:self.social],
                       [NSNumber numberWithDouble:self.studyEnv],
                       [NSNumber numberWithDouble:self.guyRatio],
                       [NSNumber numberWithInteger:self.weight]];
    return array;
    
}



#pragma mark - Utility Methods

- (JPRatings*)getNewAvgRatingByAppendingAvg:(JPRatings*)avgRatings withWeight:(NSInteger)weight
{
    JPRatings* newRatings = [[JPRatings alloc] init];
    
    newRatings.ratingOverall = (avgRatings.ratingOverall*weight+ self.ratingOverall)/(weight+1);
    newRatings.difficulty = (avgRatings.difficulty*weight+ self.difficulty)/(weight+1);
    newRatings.professors = (avgRatings.professors*weight+ self.professors)/(weight+1);
    newRatings.schedule = (avgRatings.schedule*weight+ self.schedule)/(weight+1);
    newRatings.classmates = (avgRatings.classmates*weight+ self.classmates)/(weight+1);
    newRatings.social = (avgRatings.social*weight+ self.social)/(weight+1);
    newRatings.studyEnv = (avgRatings.studyEnv*weight+ self.studyEnv)/(weight+1);
    newRatings.guyRatio = (avgRatings.guyRatio*weight+ self.guyRatio)/(weight+1);

    return newRatings;
}


- (JPRatings*)getNewAvgRatingByUpdatingAvg:(JPRatings*)avgRatings withWeight:(NSInteger)weight withOldUserRatings:(JPRatings*)oldRatings
{
    JPRatings* prevAvg = [[JPRatings alloc] init];
    
    if(weight <= 1)
        return self;
    
    prevAvg.ratingOverall = (avgRatings.ratingOverall*weight-oldRatings.ratingOverall)/(weight-1);
    prevAvg.difficulty = (avgRatings.difficulty*weight-oldRatings.difficulty)/(weight-1);
    prevAvg.professors = (avgRatings.professors*weight-oldRatings.professors)/(weight-1);
    prevAvg.schedule = (avgRatings.schedule*weight-oldRatings.schedule)/(weight-1);
    prevAvg.classmates = (avgRatings.classmates*weight-oldRatings.classmates)/(weight-1);
    prevAvg.social = (avgRatings.social*weight-oldRatings.social)/(weight-1);
    prevAvg.studyEnv = (avgRatings.studyEnv*weight-oldRatings.studyEnv)/(weight-1);
    prevAvg.guyRatio = (avgRatings.guyRatio*weight-oldRatings.guyRatio)/(weight-1);
    
    JPRatings* updatedAvg = [self getNewAvgRatingByAppendingAvg:prevAvg withWeight:weight-1];
    
    return updatedAvg;
}




#pragma mark - Convenience Methods

- (NSString*)dictionaryKeyWithIndex: (NSInteger)num
{
    NSArray* keyArray = @[@"ratingOverall", @"difficulty", @"professors", @"schedule", @"classmates", @"socialEnjoyment", @"studyEnv", @"guyRatio", @"weight"];
    
    return keyArray[num];
}


- (NSString*)dictionaryShortKeyWithIndex: (NSInteger)num
{
    return [[self dictionaryKeyWithIndex:num] substringToIndex:2];
}


@end
