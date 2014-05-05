//
//  Program.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-04.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Faculty, ImageLink, ProgramApplicationStat, ProgramCourse, ProgramRating, ProgramYearlyTuition;

@interface Program : NSManagedObject

@property (nonatomic, retain) NSString * about;
@property (nonatomic, retain) NSString * admissionDeadline;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * ext;
@property (nonatomic, retain) NSString * facebookLink;
@property (nonatomic, retain) NSNumber * fax;
@property (nonatomic, retain) NSNumber * isCoop;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * numFavorites;
@property (nonatomic, retain) NSNumber * phone;
@property (nonatomic, retain) NSNumber * population;
@property (nonatomic, retain) NSNumber * programId;
@property (nonatomic, retain) NSString * twitterLink;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSNumber * yearEstablished;
@property (nonatomic, retain) NSSet *applicationStats;
@property (nonatomic, retain) NSSet *courses;
@property (nonatomic, retain) Faculty *faculty;
@property (nonatomic, retain) ProgramRating *rating;
@property (nonatomic, retain) NSSet *tuitions;
@property (nonatomic, retain) NSSet *images;
@end

@interface Program (CoreDataGeneratedAccessors)

- (void)addApplicationStatsObject:(ProgramApplicationStat *)value;
- (void)removeApplicationStatsObject:(ProgramApplicationStat *)value;
- (void)addApplicationStats:(NSSet *)values;
- (void)removeApplicationStats:(NSSet *)values;

- (void)addCoursesObject:(ProgramCourse *)value;
- (void)removeCoursesObject:(ProgramCourse *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

- (void)addTuitionsObject:(ProgramYearlyTuition *)value;
- (void)removeTuitionsObject:(ProgramYearlyTuition *)value;
- (void)addTuitions:(NSSet *)values;
- (void)removeTuitions:(NSSet *)values;

- (void)addImagesObject:(ImageLink *)value;
- (void)removeImagesObject:(ImageLink *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

@end
