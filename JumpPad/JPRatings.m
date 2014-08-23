//
//  JPRatings.m
//  Uniq
//
//  Created by Si Te Feng on 8/23/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPRatings.h"

@implementation JPRatings

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
    return self;
}


- (instancetype)initWithOrderedArray: (NSArray*)ratingsArray
{
    self = [self init];
    
    self.ratingOverall = [ratingsArray[0] integerValue];
    self.difficulty = [ratingsArray[1] integerValue];
    self.professors = [ratingsArray[2] integerValue];
    self.schedule = [ratingsArray[3] integerValue];
    self.classmates = [ratingsArray[4] integerValue];
    self.social = [ratingsArray[5] integerValue];
    self.studyEnv = [ratingsArray[6] integerValue];
    self.guyRatio = [ratingsArray[7] integerValue];
    
    return self;
}


- (instancetype)initWithShortKeyDictionary: (NSDictionary*)dict
{
    self = [self init];
    
    if(!dict || [dict isEqual:[NSNull null]])
        return self;
    
    self.ratingOverall = [[dict objectForKey:[self dictionaryShortKeyWithIndex:0]] integerValue];
    self.difficulty = [[dict objectForKey:[self dictionaryShortKeyWithIndex:1]] integerValue];
    self.professors = [[dict objectForKey:[self dictionaryShortKeyWithIndex:2]] integerValue];
    self.schedule = [[dict objectForKey:[self dictionaryShortKeyWithIndex:3]] integerValue];
    self.classmates = [[dict objectForKey:[self dictionaryShortKeyWithIndex:4]] integerValue];
    self.social = [[dict objectForKey:[self dictionaryShortKeyWithIndex:5]] integerValue];
    self.studyEnv = [[dict objectForKey:[self dictionaryShortKeyWithIndex:6]] integerValue];
    self.guyRatio = [[dict objectForKey:[self dictionaryShortKeyWithIndex:7]] integerValue];
    
    return self;
    
}




- (NSDictionary*)getFullKeyDictionaryRepresentation
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[NSNumber numberWithInteger:self.ratingOverall] forKey:[self dictionaryKeyWithIndex:0]];
    [dict setObject:[NSNumber numberWithInteger:self.difficulty] forKey:[self dictionaryKeyWithIndex:1]];
    [dict setObject:[NSNumber numberWithInteger:self.professors] forKey:[self dictionaryKeyWithIndex:2]];
    [dict setObject:[NSNumber numberWithInteger:self.schedule] forKey:[self dictionaryKeyWithIndex:3]];
    [dict setObject:[NSNumber numberWithInteger:self.classmates] forKey:[self dictionaryKeyWithIndex:4]];
    [dict setObject:[NSNumber numberWithInteger:self.social] forKey:[self dictionaryKeyWithIndex:5]];
    [dict setObject:[NSNumber numberWithInteger:self.studyEnv] forKey:[self dictionaryKeyWithIndex:6]];
    [dict setObject:[NSNumber numberWithInteger:self.guyRatio] forKey:[self dictionaryKeyWithIndex:7]];
    
    return dict;
}


- (NSDictionary*)getShortKeyDictionaryRepresentation
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[NSNumber numberWithInteger:self.ratingOverall] forKey:[self dictionaryShortKeyWithIndex:0]];
    [dict setObject:[NSNumber numberWithInteger:self.difficulty] forKey:[self dictionaryShortKeyWithIndex:1]];
    [dict setObject:[NSNumber numberWithInteger:self.professors] forKey:[self dictionaryShortKeyWithIndex:2]];
    [dict setObject:[NSNumber numberWithInteger:self.schedule] forKey:[self dictionaryShortKeyWithIndex:3]];
    [dict setObject:[NSNumber numberWithInteger:self.classmates] forKey:[self dictionaryShortKeyWithIndex:4]];
    [dict setObject:[NSNumber numberWithInteger:self.social] forKey:[self dictionaryShortKeyWithIndex:5]];
    [dict setObject:[NSNumber numberWithInteger:self.studyEnv] forKey:[self dictionaryShortKeyWithIndex:6]];;
    [dict setObject:[NSNumber numberWithInteger:self.guyRatio] forKey:[self dictionaryShortKeyWithIndex:7]];
    
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
                       [NSNumber numberWithDouble:self.guyRatio]];
    return array;
    
}



- (NSString*)dictionaryKeyWithIndex: (NSInteger)num
{
    NSArray* keyArray = @[@"ratingOverall", @"difficulty", @"professors", @"schedule", @"classmates", @"social", @"studyEnv", @"guyRatio"];
    
    return keyArray[num];
}


- (NSString*)dictionaryShortKeyWithIndex: (NSInteger)num
{
    return [[self dictionaryKeyWithIndex:num] substringToIndex:2];
}


@end
