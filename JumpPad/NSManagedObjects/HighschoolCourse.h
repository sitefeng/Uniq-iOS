//
//  HighschoolCourse.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-04.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface HighschoolCourse : NSManagedObject

@property (nonatomic, retain) NSString * courseCode;
@property (nonatomic, retain) NSNumber * courseId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) User *user;

@end
