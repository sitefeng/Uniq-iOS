//
//  ProgramCourse.h
//  Uniq
//
//  Created by Si Te Feng on 2/10/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Program;

@interface ProgramCourse : NSManagedObject

@property (nonatomic, retain) NSString * catalogNum;
@property (nonatomic, retain) NSString * courseCode;
@property (nonatomic, retain) NSString * courseDescription;
@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSString * enrollmentTerm;
@property (nonatomic, retain) Program *program;

@end
