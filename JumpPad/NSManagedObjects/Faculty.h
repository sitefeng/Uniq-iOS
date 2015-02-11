//
//  Faculty.h
//  Uniq
//
//  Created by Si Te Feng on 2/10/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact, ImageLink, ImportantDate, Program, RelatedItem, School, SchoolLocation;

@interface Faculty : NSManagedObject

@property (nonatomic, retain) NSString * about;
@property (nonatomic, retain) NSNumber * alumniNumber;
@property (nonatomic, retain) NSDecimalNumber * avgAdm;
@property (nonatomic, retain) NSString * facultyId;
@property (nonatomic, retain) NSNumber * gradPopulation;
@property (nonatomic, retain) NSString * logoUrl;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * numPrograms;
@property (nonatomic, retain) NSString * schoolId;
@property (nonatomic, retain) NSNumber * toDelete;
@property (nonatomic, retain) NSNumber * totalFunding;
@property (nonatomic, retain) NSNumber * undergradPopulation;
@property (nonatomic, retain) NSNumber * yearEstablished;
@property (nonatomic, retain) NSSet *contacts;
@property (nonatomic, retain) NSSet *images;
@property (nonatomic, retain) NSSet *importantDates;
@property (nonatomic, retain) SchoolLocation *location;
@property (nonatomic, retain) NSSet *programs;
@property (nonatomic, retain) NSSet *relatedItems;
@property (nonatomic, retain) School *school;
@end

@interface Faculty (CoreDataGeneratedAccessors)

- (void)addContactsObject:(Contact *)value;
- (void)removeContactsObject:(Contact *)value;
- (void)addContacts:(NSSet *)values;
- (void)removeContacts:(NSSet *)values;

- (void)addImagesObject:(ImageLink *)value;
- (void)removeImagesObject:(ImageLink *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

- (void)addImportantDatesObject:(ImportantDate *)value;
- (void)removeImportantDatesObject:(ImportantDate *)value;
- (void)addImportantDates:(NSSet *)values;
- (void)removeImportantDates:(NSSet *)values;

- (void)addProgramsObject:(Program *)value;
- (void)removeProgramsObject:(Program *)value;
- (void)addPrograms:(NSSet *)values;
- (void)removePrograms:(NSSet *)values;

- (void)addRelatedItemsObject:(RelatedItem *)value;
- (void)removeRelatedItemsObject:(RelatedItem *)value;
- (void)addRelatedItems:(NSSet *)values;
- (void)removeRelatedItems:(NSSet *)values;

@end
