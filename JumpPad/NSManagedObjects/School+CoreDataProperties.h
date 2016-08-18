//
//  School+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/17/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "School.h"

NS_ASSUME_NONNULL_BEGIN

@interface School (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *about;
@property (nullable, nonatomic, retain) NSNumber *alumniNumber;
@property (nullable, nonatomic, retain) NSNumber *avgAdm;
@property (nullable, nonatomic, retain) NSNumber *gradPopulation;
@property (nullable, nonatomic, retain) NSString *logoUrl;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *numFaculties;
@property (nullable, nonatomic, retain) NSNumber *numPrograms;
@property (nullable, nonatomic, retain) NSString *schoolId;
@property (nullable, nonatomic, retain) NSString *slug;
@property (nullable, nonatomic, retain) NSNumber *toDelete;
@property (nullable, nonatomic, retain) NSString *totalFunding;
@property (nullable, nonatomic, retain) NSNumber *undergradPopulation;
@property (nullable, nonatomic, retain) NSNumber *yearEstablished;
@property (nullable, nonatomic, retain) NSSet<Contact *> *contacts;
@property (nullable, nonatomic, retain) NSSet<Faculty *> *faculties;
@property (nullable, nonatomic, retain) NSSet<ImageLink *> *images;
@property (nullable, nonatomic, retain) SchoolLocation *location;
@property (nullable, nonatomic, retain) NSSet<SchoolRanking *> *rankings;
@property (nullable, nonatomic, retain) NSSet<RelatedItem *> *relatedItems;

@end

@interface School (CoreDataGeneratedAccessors)

- (void)addContactsObject:(Contact *)value;
- (void)removeContactsObject:(Contact *)value;
- (void)addContacts:(NSSet<Contact *> *)values;
- (void)removeContacts:(NSSet<Contact *> *)values;

- (void)addFacultiesObject:(Faculty *)value;
- (void)removeFacultiesObject:(Faculty *)value;
- (void)addFaculties:(NSSet<Faculty *> *)values;
- (void)removeFaculties:(NSSet<Faculty *> *)values;

- (void)addImagesObject:(ImageLink *)value;
- (void)removeImagesObject:(ImageLink *)value;
- (void)addImages:(NSSet<ImageLink *> *)values;
- (void)removeImages:(NSSet<ImageLink *> *)values;

- (void)addRankingsObject:(SchoolRanking *)value;
- (void)removeRankingsObject:(SchoolRanking *)value;
- (void)addRankings:(NSSet<SchoolRanking *> *)values;
- (void)removeRankings:(NSSet<SchoolRanking *> *)values;

- (void)addRelatedItemsObject:(RelatedItem *)value;
- (void)removeRelatedItemsObject:(RelatedItem *)value;
- (void)addRelatedItems:(NSSet<RelatedItem *> *)values;
- (void)removeRelatedItems:(NSSet<RelatedItem *> *)values;

@end

NS_ASSUME_NONNULL_END
