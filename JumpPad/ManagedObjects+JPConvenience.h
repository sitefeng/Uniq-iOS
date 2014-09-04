//
//  ManagedObjects+JPConvenience.h
//  Uniq
//
//  Created by Si Te Feng on 9/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "Faculty.h"
#import "School.h"
#import "Program.h"
#import "Contact.h"
#import "ImageLink.h"
#import "SchoolLocation.h"
#import "ImportantDate.h"
#import "ProgramYearlyTuition.h"
#import "ProgramRating.h"
#import "HighschoolCourse.h"
#import "ProgramCourse.h"
#import "UniqAppDelegate.h"


@interface School (JPConvenience)

- (instancetype)initWithDictionary: (NSDictionary*)dict;

- (NSDictionary*)dictionaryRepresentation;

@end



@interface Faculty (JPConvenience)

- (instancetype)initWithDictionary: (NSDictionary*)dict;

@end



@interface Program (JPConvenience)

- (instancetype)initWithDictionary: (NSDictionary*)dict;

@end



@interface Contact (JPConvenience)

- (instancetype)initWithDictionary: (NSDictionary*)dict;

@end



@interface ImageLink (JPConvenience)

- (instancetype)initWithDictionary: (NSDictionary*)dict;

@end


@interface SchoolLocation (JPConvenience)

- (instancetype)initWithDictionary: (NSDictionary*)dict;

@end


@interface ImportantDate (JPConvenience)

- (instancetype)initWithDictionary: (NSDictionary*)dict;

@end

@interface ProgramCourse (JPConvenience)

- (instancetype)initWithDictionary: (NSDictionary*)dict;

@end

@interface HighschoolCourse (JPConvenience)

- (instancetype)initWithRequirementDictionary: (NSDictionary*)dict;

@end