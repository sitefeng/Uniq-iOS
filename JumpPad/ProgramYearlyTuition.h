//
//  ProgramYearlyTuition.h
//  Uniq
//
//  Created by Si Te Feng on 6/26/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Program;

@interface ProgramYearlyTuition : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * domesticTuition;
@property (nonatomic, retain) NSDecimalNumber * internationalTuition;
@property (nonatomic, retain) NSNumber * pYearlyTuitionId;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) Program *program;

@end
