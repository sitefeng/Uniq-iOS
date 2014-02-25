//
//  Program.h
//  JumpPad
//
//  Created by Si Te Feng on 2/25/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Faculty, ProgramApplicationStat, ProgramCourse, ProgramImageLink, ProgramRating, ProgramYearlyTuition;

@interface Program : NSManagedObject

@property (nonatomic, retain) NSString * about;
@property (nonatomic, retain) NSDate * admissionDeadline;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * ext;
@property (nonatomic, retain) NSString * facebookLink;
@property (nonatomic, retain) NSNumber * fax;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * phone;
@property (nonatomic, retain) NSNumber * population;
@property (nonatomic, retain) NSNumber * programId;
@property (nonatomic, retain) NSDate * timeModified;
@property (nonatomic, retain) NSString * twitterLink;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSNumber * yearEstablished;
@property (nonatomic, retain) NSSet *applicationStats;
@property (nonatomic, retain) NSSet *courses;
@property (nonatomic, retain) Faculty *faculty;
@property (nonatomic, retain) NSSet *images;
@property (nonatomic, retain) NSSet *ratings;
@property (nonatomic, retain) NSSet *tuitions;
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

- (void)addImagesObject:(ProgramImageLink *)value;
- (void)removeImagesObject:(ProgramImageLink *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

- (void)addRatingsObject:(ProgramRating *)value;
- (void)removeRatingsObject:(ProgramRating *)value;
- (void)addRatings:(NSSet *)values;
- (void)removeRatings:(NSSet *)values;

- (void)addTuitionsObject:(ProgramYearlyTuition *)value;
- (void)removeTuitionsObject:(ProgramYearlyTuition *)value;
- (void)addTuitions:(NSSet *)values;
- (void)removeTuitions:(NSSet *)values;

@end
