//
//  ProgramCourse+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProgramCourse.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProgramCourse (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *catalogNum;
@property (nullable, nonatomic, retain) NSString *courseCode;
@property (nullable, nonatomic, retain) NSString *courseDescription;
@property (nullable, nonatomic, retain) NSString *courseName;
@property (nullable, nonatomic, retain) NSString *enrollmentTerm;
@property (nullable, nonatomic, retain) Program *program;

@end

NS_ASSUME_NONNULL_END
