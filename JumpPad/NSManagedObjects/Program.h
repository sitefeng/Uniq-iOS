//
//  Program.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact, Faculty, HighschoolCourse, ImageLink, ImportantDate, ProgramApplicationStat, ProgramCourse, ProgramRating, ProgramYearlyTuition, RelatedItem, SchoolLocation, JPLocation;

NS_ASSUME_NONNULL_BEGIN

@interface Program : NSManagedObject

- (JPLocation *)requestLocationSynchronously;

@end

NS_ASSUME_NONNULL_END

#import "Program+CoreDataProperties.h"
