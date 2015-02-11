//
//  HighschoolCourse.h
//  Uniq
//
//  Created by Si Te Feng on 2/10/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Program, User;

@interface HighschoolCourse : NSManagedObject

@property (nonatomic, retain) NSString * courseCode;
@property (nonatomic, retain) NSString * courseLevel;
@property (nonatomic, retain) NSNumber * courseMark;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Program *program;
@property (nonatomic, retain) User *user;

@end
