//
//  ProgramApplicationStat+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProgramApplicationStat.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProgramApplicationStat (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *numApplicants;
@property (nullable, nonatomic, retain) NSNumber *pAcceptanceId;
@property (nullable, nonatomic, retain) NSNumber *percentageAccepted;
@property (nullable, nonatomic, retain) NSNumber *year;
@property (nullable, nonatomic, retain) Program *program;

@end

NS_ASSUME_NONNULL_END
