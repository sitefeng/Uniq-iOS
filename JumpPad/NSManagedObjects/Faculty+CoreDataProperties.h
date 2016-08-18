//
//  Faculty+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/17/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Faculty.h"

NS_ASSUME_NONNULL_BEGIN

@interface Faculty (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *about;
@property (nullable, nonatomic, retain) NSNumber *alumniNumber;
@property (nullable, nonatomic, retain) NSNumber *avgAdm;
@property (nullable, nonatomic, retain) NSString *facultyId;
@property (nullable, nonatomic, retain) NSNumber *gradPopulation;
@property (nullable, nonatomic, retain) NSString *logoUrl;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *numPrograms;
@property (nullable, nonatomic, retain) NSString *schoolId;
@property (nullable, nonatomic, retain) NSString *schoolSlug;
@property (nullable, nonatomic, retain) NSString *slug;
@property (nullable, nonatomic, retain) NSNumber *toDelete;
@property (nullable, nonatomic, retain) NSNumber *totalFunding;
@property (nullable, nonatomic, retain) NSNumber *undergradPopulation;
@property (nullable, nonatomic, retain) NSNumber *yearEstablished;
@property (nullable, nonatomic, retain) NSSet<Contact *> *contacts;
@property (nullable, nonatomic, retain) NSSet<ImageLink *> *images;
@property (nullable, nonatomic, retain) NSSet<ImportantDate *> *importantDates;
@property (nullable, nonatomic, retain) SchoolLocation *location;
@property (nullable, nonatomic, retain) NSSet<Program *> *programs;
@property (nullable, nonatomic, retain) NSSet<RelatedItem *> *relatedItems;
@property (nullable, nonatomic, retain) School *school;

@end

@interface Faculty (CoreDataGeneratedAccessors)

- (void)addContactsObject:(Contact *)value;
- (void)removeContactsObject:(Contact *)value;
- (void)addContacts:(NSSet<Contact *> *)values;
- (void)removeContacts:(NSSet<Contact *> *)values;

- (void)addImagesObject:(ImageLink *)value;
- (void)removeImagesObject:(ImageLink *)value;
- (void)addImages:(NSSet<ImageLink *> *)values;
- (void)removeImages:(NSSet<ImageLink *> *)values;

- (void)addImportantDatesObject:(ImportantDate *)value;
- (void)removeImportantDatesObject:(ImportantDate *)value;
- (void)addImportantDates:(NSSet<ImportantDate *> *)values;
- (void)removeImportantDates:(NSSet<ImportantDate *> *)values;

- (void)addProgramsObject:(Program *)value;
- (void)removeProgramsObject:(Program *)value;
- (void)addPrograms:(NSSet<Program *> *)values;
- (void)removePrograms:(NSSet<Program *> *)values;

- (void)addRelatedItemsObject:(RelatedItem *)value;
- (void)removeRelatedItemsObject:(RelatedItem *)value;
- (void)addRelatedItems:(NSSet<RelatedItem *> *)values;
- (void)removeRelatedItems:(NSSet<RelatedItem *> *)values;

@end

NS_ASSUME_NONNULL_END
