//
//  HighschoolCourse.h
//  Uniq
//
//  Created by Si Te Feng on 9/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Program, User;

@interface HighschoolCourse : NSManagedObject

@property (nonatomic, retain) NSString * courseCode;
@property (nonatomic, retain) NSString * courseLevel;
@property (nonatomic, retain) NSNumber * courseMark;
@property (nonatomic, retain) NSString * name; 
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) Program *program;

@end
