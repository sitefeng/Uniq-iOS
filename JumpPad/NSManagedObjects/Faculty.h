//
//  Faculty.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-04.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ImageLink, Program, School;

@interface Faculty : NSManagedObject

@property (nonatomic, retain) NSNumber * alumniNumber;
@property (nonatomic, retain) NSString * facebookLink;
@property (nonatomic, retain) NSNumber * facultyId;
@property (nonatomic, retain) NSNumber * logoUrl;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * numPrograms;
@property (nonatomic, retain) NSNumber * population;
@property (nonatomic, retain) NSNumber * totalFunding;
@property (nonatomic, retain) NSString * twitterLink;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSNumber * yearEstablished;
@property (nonatomic, retain) NSSet *programs;
@property (nonatomic, retain) School *school;
@property (nonatomic, retain) NSSet *images;
@end

@interface Faculty (CoreDataGeneratedAccessors)

- (void)addProgramsObject:(Program *)value;
- (void)removeProgramsObject:(Program *)value;
- (void)addPrograms:(NSSet *)values;
- (void)removePrograms:(NSSet *)values;

- (void)addImagesObject:(ImageLink *)value;
- (void)removeImagesObject:(ImageLink *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

@end
