//
//  ProgramRating+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProgramRating.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProgramRating (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *classmates;
@property (nullable, nonatomic, retain) NSNumber *difficulty;
@property (nullable, nonatomic, retain) NSNumber *guyToGirlRatio;
@property (nullable, nonatomic, retain) NSNumber *professor;
@property (nullable, nonatomic, retain) NSNumber *ratingOverall;
@property (nullable, nonatomic, retain) NSNumber *schedule;
@property (nullable, nonatomic, retain) NSNumber *socialEnjoyments;
@property (nullable, nonatomic, retain) NSNumber *studyEnv;
@property (nullable, nonatomic, retain) NSNumber *weight;
@property (nullable, nonatomic, retain) Program *program;

@end

NS_ASSUME_NONNULL_END
