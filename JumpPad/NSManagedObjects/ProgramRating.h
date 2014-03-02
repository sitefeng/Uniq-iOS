//
//  ProgramRating.h
//  JumpPad
//
//  Created by Si Te Feng on 2/25/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Program;

@interface ProgramRating : NSManagedObject

@property (nonatomic, retain) NSNumber * classmates;
@property (nonatomic, retain) NSNumber * difficulty;
@property (nonatomic, retain) NSNumber * guyToGirlRatio;
@property (nonatomic, retain) NSNumber * pRatingId;
@property (nonatomic, retain) NSNumber * professor;
@property (nonatomic, retain) NSNumber * ratingOverall;
@property (nonatomic, retain) NSNumber * schedule;
@property (nonatomic, retain) NSNumber * socialEnjoyments;
@property (nonatomic, retain) NSNumber * studyEnv;
@property (nonatomic, retain) NSDate * timeModified;
@property (nonatomic, retain) Program *program;

@end