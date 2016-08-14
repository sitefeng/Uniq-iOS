//
//  HighschoolCourse+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HighschoolCourse.h"

NS_ASSUME_NONNULL_BEGIN

@interface HighschoolCourse (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *courseCode;
@property (nullable, nonatomic, retain) NSString *courseLevel;
@property (nullable, nonatomic, retain) NSNumber *courseMark;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Program *program;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
