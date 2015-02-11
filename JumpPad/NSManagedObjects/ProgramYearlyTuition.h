//
//  ProgramYearlyTuition.h
//  Uniq
//
//  Created by Si Te Feng on 2/10/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
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
