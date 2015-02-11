//
//  Program.h
//  Uniq
//
//  Created by Si Te Feng on 2/10/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact, Faculty, HighschoolCourse, ImageLink, ImportantDate, ProgramApplicationStat, ProgramCourse, ProgramRating, ProgramYearlyTuition, RelatedItem, SchoolLocation;

@interface Program : NSManagedObject

@property (nonatomic, retain) NSString * about;
@property (nonatomic, retain) NSString * applicationDeadline;
@property (nonatomic, retain) NSString * appProcess;
@property (nonatomic, retain) NSString * avgAdm;
@property (nonatomic, retain) NSString * curriculumTerms;
@property (nonatomic, retain) NSString * degree;
@property (nonatomic, retain) NSString * degreeAbbrev;
@property (nonatomic, retain) NSString * facultyId;
@property (nonatomic, retain) NSNumber * gradPopulation;
@property (nonatomic, retain) NSString * internshipAbout;
@property (nonatomic, retain) NSNumber * isCoop;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * numAccepted;
@property (nonatomic, retain) NSNumber * numApplicants;
@property (nonatomic, retain) NSNumber * numFavorites;
@property (nonatomic, retain) NSString * programId;
@property (nonatomic, retain) NSString * schoolId;
@property (nonatomic, retain) NSString * shortName;
@property (nonatomic, retain) NSString * slug;
@property (nonatomic, retain) NSNumber * toDelete;
@property (nonatomic, retain) NSNumber * undergradPopulation;
@property (nonatomic, retain) NSNumber * yearEstablished;
@property (nonatomic, retain) NSSet *applicationStats;
@property (nonatomic, retain) NSSet *contacts;
@property (nonatomic, retain) NSSet *courses;
@property (nonatomic, retain) Faculty *faculty;
@property (nonatomic, retain) NSSet *images;
@property (nonatomic, retain) NSSet *importantDates;
@property (nonatomic, retain) SchoolLocation *location;
@property (nonatomic, retain) ProgramRating *rating;
@property (nonatomic, retain) NSSet *relatedItems;
@property (nonatomic, retain) NSSet *requiredCourses;
@property (nonatomic, retain) NSSet *tuitions;
@end

@interface Program (CoreDataGeneratedAccessors)

- (void)addApplicationStatsObject:(ProgramApplicationStat *)value;
- (void)removeApplicationStatsObject:(ProgramApplicationStat *)value;
- (void)addApplicationStats:(NSSet *)values;
- (void)removeApplicationStats:(NSSet *)values;

- (void)addContactsObject:(Contact *)value;
- (void)removeContactsObject:(Contact *)value;
- (void)addContacts:(NSSet *)values;
- (void)removeContacts:(NSSet *)values;

- (void)addCoursesObject:(ProgramCourse *)value;
- (void)removeCoursesObject:(ProgramCourse *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

- (void)addImagesObject:(ImageLink *)value;
- (void)removeImagesObject:(ImageLink *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

- (void)addImportantDatesObject:(ImportantDate *)value;
- (void)removeImportantDatesObject:(ImportantDate *)value;
- (void)addImportantDates:(NSSet *)values;
- (void)removeImportantDates:(NSSet *)values;

- (void)addRelatedItemsObject:(RelatedItem *)value;
- (void)removeRelatedItemsObject:(RelatedItem *)value;
- (void)addRelatedItems:(NSSet *)values;
- (void)removeRelatedItems:(NSSet *)values;

- (void)addRequiredCoursesObject:(HighschoolCourse *)value;
- (void)removeRequiredCoursesObject:(HighschoolCourse *)value;
- (void)addRequiredCourses:(NSSet *)values;
- (void)removeRequiredCourses:(NSSet *)values;

- (void)addTuitionsObject:(ProgramYearlyTuition *)value;
- (void)removeTuitionsObject:(ProgramYearlyTuition *)value;
- (void)addTuitions:(NSSet *)values;
- (void)removeTuitions:(NSSet *)values;

@end
