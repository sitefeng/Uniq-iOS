//
//  Program+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Program.h"

NS_ASSUME_NONNULL_BEGIN

@interface Program (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *about;
@property (nullable, nonatomic, retain) NSString *applicationDeadline;
@property (nullable, nonatomic, retain) NSString *appProcess;
@property (nullable, nonatomic, retain) NSString *avgAdm;
@property (nullable, nonatomic, retain) NSString *curriculumTerms;
@property (nullable, nonatomic, retain) NSString *degree;
@property (nullable, nonatomic, retain) NSString *degreeAbbrev;
@property (nullable, nonatomic, retain) NSString *facultyId;
@property (nullable, nonatomic, retain) NSNumber *gradPopulation;
@property (nullable, nonatomic, retain) NSString *internshipAbout;
@property (nullable, nonatomic, retain) NSNumber *isCoop;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *numAccepted;
@property (nullable, nonatomic, retain) NSNumber *numApplicants;
@property (nullable, nonatomic, retain) NSNumber *numFavorites;
@property (nullable, nonatomic, retain) NSString *programId;
@property (nullable, nonatomic, retain) NSString *schoolId;
@property (nullable, nonatomic, retain) NSString *shortName;
@property (nullable, nonatomic, retain) NSString *slug;
@property (nullable, nonatomic, retain) NSNumber *toDelete;
@property (nullable, nonatomic, retain) NSNumber *undergradPopulation;
@property (nullable, nonatomic, retain) NSNumber *yearEstablished;
@property (nullable, nonatomic, retain) NSString *facultySlug;
@property (nullable, nonatomic, retain) NSString *schoolSlug;
@property (nullable, nonatomic, retain) NSSet<ProgramApplicationStat *> *applicationStats;
@property (nullable, nonatomic, retain) NSSet<Contact *> *contacts;
@property (nullable, nonatomic, retain) NSSet<ProgramCourse *> *courses;
@property (nullable, nonatomic, retain) Faculty *faculty;
@property (nullable, nonatomic, retain) NSSet<ImageLink *> *images;
@property (nullable, nonatomic, retain) NSSet<ImportantDate *> *importantDates;
@property (nullable, nonatomic, retain) SchoolLocation *location;
@property (nullable, nonatomic, retain) ProgramRating *rating;
@property (nullable, nonatomic, retain) NSSet<RelatedItem *> *relatedItems;
@property (nullable, nonatomic, retain) NSSet<HighschoolCourse *> *requiredCourses;
@property (nullable, nonatomic, retain) ProgramYearlyTuition *tuition;

@end

@interface Program (CoreDataGeneratedAccessors)

- (void)addApplicationStatsObject:(ProgramApplicationStat *)value;
- (void)removeApplicationStatsObject:(ProgramApplicationStat *)value;
- (void)addApplicationStats:(NSSet<ProgramApplicationStat *> *)values;
- (void)removeApplicationStats:(NSSet<ProgramApplicationStat *> *)values;

- (void)addContactsObject:(Contact *)value;
- (void)removeContactsObject:(Contact *)value;
- (void)addContacts:(NSSet<Contact *> *)values;
- (void)removeContacts:(NSSet<Contact *> *)values;

- (void)addCoursesObject:(ProgramCourse *)value;
- (void)removeCoursesObject:(ProgramCourse *)value;
- (void)addCourses:(NSSet<ProgramCourse *> *)values;
- (void)removeCourses:(NSSet<ProgramCourse *> *)values;

- (void)addImagesObject:(ImageLink *)value;
- (void)removeImagesObject:(ImageLink *)value;
- (void)addImages:(NSSet<ImageLink *> *)values;
- (void)removeImages:(NSSet<ImageLink *> *)values;

- (void)addImportantDatesObject:(ImportantDate *)value;
- (void)removeImportantDatesObject:(ImportantDate *)value;
- (void)addImportantDates:(NSSet<ImportantDate *> *)values;
- (void)removeImportantDates:(NSSet<ImportantDate *> *)values;

- (void)addRelatedItemsObject:(RelatedItem *)value;
- (void)removeRelatedItemsObject:(RelatedItem *)value;
- (void)addRelatedItems:(NSSet<RelatedItem *> *)values;
- (void)removeRelatedItems:(NSSet<RelatedItem *> *)values;

- (void)addRequiredCoursesObject:(HighschoolCourse *)value;
- (void)removeRequiredCoursesObject:(HighschoolCourse *)value;
- (void)addRequiredCourses:(NSSet<HighschoolCourse *> *)values;
- (void)removeRequiredCourses:(NSSet<HighschoolCourse *> *)values;

@end

NS_ASSUME_NONNULL_END
