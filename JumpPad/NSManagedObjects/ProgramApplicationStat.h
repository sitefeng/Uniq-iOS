//
//  ProgramApplicationStat.h
//  JumpPad
//
//  Created by Si Te Feng on 2/25/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Program;

@interface ProgramApplicationStat : NSManagedObject

@property (nonatomic, retain) NSNumber * numApplicants;
@property (nonatomic, retain) NSNumber * pAcceptanceId;
@property (nonatomic, retain) NSNumber * percentageAccepted;
@property (nonatomic, retain) NSDate * timeModified;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) Program *program;

@end
