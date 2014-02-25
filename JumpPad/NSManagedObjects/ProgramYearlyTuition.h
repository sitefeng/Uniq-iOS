//
//  ProgramYearlyTuition.h
//  JumpPad
//
//  Created by Si Te Feng on 2/25/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Program;

@interface ProgramYearlyTuition : NSManagedObject

@property (nonatomic, retain) NSNumber * domesticTuition;
@property (nonatomic, retain) NSNumber * internationalTuition;
@property (nonatomic, retain) NSNumber * pYearlyTuitionId;
@property (nonatomic, retain) NSDate * timeModified;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) Program *program;

@end
