//
//  Faculty.h
//  JumpPad
//
//  Created by Si Te Feng on 2/25/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FacultyImageLink, Program, School;

@interface Faculty : NSManagedObject

@property (nonatomic, retain) NSNumber * alumniNumber;
@property (nonatomic, retain) NSNumber * facebookLink;
@property (nonatomic, retain) NSNumber * facultyId;
@property (nonatomic, retain) NSNumber * logoUrl;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * numPrograms;
@property (nonatomic, retain) NSNumber * population;
@property (nonatomic, retain) NSDate * timeModified;
@property (nonatomic, retain) NSNumber * totalFunding;
@property (nonatomic, retain) NSString * twitterLink;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSDate * yearEstablished;
@property (nonatomic, retain) NSSet *images;
@property (nonatomic, retain) NSSet *programs;
@property (nonatomic, retain) School *school;
@end

@interface Faculty (CoreDataGeneratedAccessors)

- (void)addImagesObject:(FacultyImageLink *)value;
- (void)removeImagesObject:(FacultyImageLink *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

- (void)addProgramsObject:(Program *)value;
- (void)removeProgramsObject:(Program *)value;
- (void)addPrograms:(NSSet *)values;
- (void)removePrograms:(NSSet *)values;

@end
