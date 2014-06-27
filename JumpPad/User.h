//
//  User.h
//  Uniq
//
//  Created by Si Te Feng on 6/27/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HighschoolCourse;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * currentAvg;
@property (nonatomic, retain) NSString * interest;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * satGrammar;
@property (nonatomic, retain) NSNumber * satMath;
@property (nonatomic, retain) NSNumber * satReading;
@property (nonatomic, retain) NSString * locationString;
@property (nonatomic, retain) NSSet *courses;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(HighschoolCourse *)value;
- (void)removeCoursesObject:(HighschoolCourse *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

@end
