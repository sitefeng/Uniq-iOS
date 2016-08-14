//
//  SchoolLocation+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SchoolLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface SchoolLocation (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *apt;
@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *country;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSString *postalCode;
@property (nullable, nonatomic, retain) NSString *region;
@property (nullable, nonatomic, retain) NSString *streetName;
@property (nullable, nonatomic, retain) NSString *streetNum;
@property (nullable, nonatomic, retain) NSString *unit;
@property (nullable, nonatomic, retain) Faculty *faculty;
@property (nullable, nonatomic, retain) Program *program;
@property (nullable, nonatomic, retain) School *school;

@end

NS_ASSUME_NONNULL_END
