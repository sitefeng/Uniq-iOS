//
//  ProgramCourse.h
//  Uniq
//
//  Created by Si Te Feng on 6/26/14.
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
@property (nonatomic, retain) Program *program;

@end
