//
//  ProgramYearlyTuition+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProgramYearlyTuition.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProgramYearlyTuition (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *domesticTuition;
@property (nullable, nonatomic, retain) NSNumber *internationalTuition;
@property (nullable, nonatomic, retain) Program *program;

@end

NS_ASSUME_NONNULL_END
