//
//  School.h
//  Uniq
//
//  Created by Si Te Feng on 2/10/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact, Faculty, ImageLink, RelatedItem, SchoolLocation, SchoolRanking;

@interface School : NSManagedObject

@property (nonatomic, retain) NSString * about;
@property (nonatomic, retain) NSNumber * alumniNumber;
@property (nonatomic, retain) NSDecimalNumber * avgAdm;
@property (nonatomic, retain) NSNumber * gradPopulation;
@property (nonatomic, retain) NSString * logoUrl;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * numFaculties;
@property (nonatomic, retain) NSNumber * numPrograms;
@property (nonatomic, retain) NSString * schoolId;
@property (nonatomic, retain) NSNumber * toDelete;
@property (nonatomic, retain) NSNumber * totalFunding;
@property (nonatomic, retain) NSNumber * undergradPopulation;
@property (nonatomic, retain) NSNumber * yearEstablished;
@property (nonatomic, retain) NSSet *contacts;
@property (nonatomic, retain) NSSet *faculties;
@property (nonatomic, retain) NSSet *images;
@property (nonatomic, retain) SchoolLocation *location;
@property (nonatomic, retain) NSSet *rankings;
@property (nonatomic, retain) NSSet *relatedItems;
@end

@interface School (CoreDataGeneratedAccessors)

- (void)addContactsObject:(Contact *)value;
- (void)removeContactsObject:(Contact *)value;
- (void)addContacts:(NSSet *)values;
- (void)removeContacts:(NSSet *)values;

- (void)addFacultiesObject:(Faculty *)value;
- (void)removeFacultiesObject:(Faculty *)value;
- (void)addFaculties:(NSSet *)values;
- (void)removeFaculties:(NSSet *)values;

- (void)addImagesObject:(ImageLink *)value;
- (void)removeImagesObject:(ImageLink *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

- (void)addRankingsObject:(SchoolRanking *)value;
- (void)removeRankingsObject:(SchoolRanking *)value;
- (void)addRankings:(NSSet *)values;
- (void)removeRankings:(NSSet *)values;

- (void)addRelatedItemsObject:(RelatedItem *)value;
- (void)removeRelatedItemsObject:(RelatedItem *)value;
- (void)addRelatedItems:(NSSet *)values;
- (void)removeRelatedItems:(NSSet *)values;

@end
