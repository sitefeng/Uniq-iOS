//
//  UniqKEOne+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UniqKEOne.h"

NS_ASSUME_NONNULL_BEGIN

@interface UniqKEOne (CoreDataProperties)

@property (nullable, nonatomic, retain) NSSet<UniqKEFunction *> *functions;

@end

@interface UniqKEOne (CoreDataGeneratedAccessors)

- (void)addFunctionsObject:(UniqKEFunction *)value;
- (void)removeFunctionsObject:(UniqKEFunction *)value;
- (void)addFunctions:(NSSet<UniqKEFunction *> *)values;
- (void)removeFunctions:(NSSet<UniqKEFunction *> *)values;

@end

NS_ASSUME_NONNULL_END
