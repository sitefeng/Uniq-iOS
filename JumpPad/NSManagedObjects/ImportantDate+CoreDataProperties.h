//
//  ImportantDate+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ImportantDate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImportantDate (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *date;
@property (nullable, nonatomic, retain) NSString *descriptor;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) Faculty *faculty;
@property (nullable, nonatomic, retain) Program *program;

@end

NS_ASSUME_NONNULL_END
