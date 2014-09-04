//
//  ProgramYearlyTuition.h
//  Uniq
//
//  Created by Si Te Feng on 9/4/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Program;

@interface ProgramYearlyTuition : NSManagedObject

@property (nonatomic, retain) NSNumber * domesticTuition;
@property (nonatomic, retain) NSNumber * internationalTuition;
@property (nonatomic, retain) NSString * term;
@property (nonatomic, retain) Program *program;

@end
