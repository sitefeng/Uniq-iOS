//
//  Contact+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Contact.h"

NS_ASSUME_NONNULL_BEGIN

@interface Contact (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *extraInfo;
@property (nullable, nonatomic, retain) NSString *facebook;
@property (nullable, nonatomic, retain) NSString *linkedin;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *phoneExt;
@property (nullable, nonatomic, retain) NSString *twitter;
@property (nullable, nonatomic, retain) NSString *website;
@property (nullable, nonatomic, retain) Faculty *faculty;
@property (nullable, nonatomic, retain) Program *program;
@property (nullable, nonatomic, retain) School *school;

@end

NS_ASSUME_NONNULL_END
