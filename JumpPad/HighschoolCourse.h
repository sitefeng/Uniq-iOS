//
//  HighschoolCourse.h
//  Uniq
//
//  Created by Si Te Feng on 6/27/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface HighschoolCourse : NSManagedObject

@property (nonatomic, retain) NSString * courseCode;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * courseLevel;
@property (nonatomic, retain) NSNumber * courseMark;
@property (nonatomic, retain) User *user;

@end
