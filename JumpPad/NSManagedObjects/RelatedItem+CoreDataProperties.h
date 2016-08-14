//
//  RelatedItem+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RelatedItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface RelatedItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *itemId;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) Faculty *faculty;
@property (nullable, nonatomic, retain) Program *program;
@property (nullable, nonatomic, retain) School *school;

@end

NS_ASSUME_NONNULL_END
