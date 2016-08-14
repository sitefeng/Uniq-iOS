//
//  SchoolRanking+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SchoolRanking.h"

NS_ASSUME_NONNULL_BEGIN

@interface SchoolRanking (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *ranking;
@property (nullable, nonatomic, retain) NSString *rankingSource;
@property (nullable, nonatomic, retain) NSNumber *schoolRankingId;
@property (nullable, nonatomic, retain) School *school;

@end

NS_ASSUME_NONNULL_END
