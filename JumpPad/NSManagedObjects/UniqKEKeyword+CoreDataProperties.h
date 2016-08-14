//
//  UniqKEKeyword+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UniqKEKeyword.h"

NS_ASSUME_NONNULL_BEGIN

@interface UniqKEKeyword (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *keyword;
@property (nullable, nonatomic, retain) UniqKEFunction *function;

@end

NS_ASSUME_NONNULL_END
