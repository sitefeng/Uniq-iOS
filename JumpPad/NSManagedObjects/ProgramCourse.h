//
//  ProgramCourse.h
//  JumpPad
//
//  Created by Si Te Feng on 2/25/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Program;

@interface ProgramCourse : NSManagedObject

@property (nonatomic, retain) NSString * courseCode;
@property (nonatomic, retain) NSString * courseDescription;
@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSNumber * enrollmentYear;
@property (nonatomic, retain) NSNumber * pCourseId;
@property (nonatomic, retain) NSDate * timeModified;
@property (nonatomic, retain) Program *program;

@end