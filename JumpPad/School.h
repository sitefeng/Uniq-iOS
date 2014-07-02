//
//  School.h
//  Uniq
//
//  Created by Si Te Feng on 7/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Faculty, ImageLink, SchoolLocation, SchoolRanking;

@interface School : NSManagedObject

@property (nonatomic, retain) NSNumber * alumniNumber;
@property (nonatomic, retain) NSString * facebookLink;
@property (nonatomic, retain) NSString * linkedinLink;
@property (nonatomic, retain) NSString * logoUrl;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * numPrograms;
@property (nonatomic, retain) NSNumber * population;
@property (nonatomic, retain) NSNumber * schoolId;
@property (nonatomic, retain) NSDate * timeModified;
@property (nonatomic, retain) NSNumber * totalFunding;
@property (nonatomic, retain) NSString * twitterLink;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSNumber * yearEstablished;
@property (nonatomic, retain) NSSet *faculties;
@property (nonatomic, retain) NSSet *images;
@property (nonatomic, retain) SchoolLocation *location;
@property (nonatomic, retain) NSSet *rankings;
@end

@interface School (CoreDataGeneratedAccessors)

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

@end
