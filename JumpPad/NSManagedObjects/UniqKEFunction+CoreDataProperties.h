//
//  UniqKEFunction+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UniqKEFunction.h"

NS_ASSUME_NONNULL_BEGIN

@interface UniqKEFunction (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *category;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *priority;
@property (nullable, nonatomic, retain) NSSet<UniqKEKeyword *> *keywords;
@property (nullable, nonatomic, retain) UniqKEOne *knowledgeEngine;

@end

@interface UniqKEFunction (CoreDataGeneratedAccessors)

- (void)addKeywordsObject:(UniqKEKeyword *)value;
- (void)removeKeywordsObject:(UniqKEKeyword *)value;
- (void)addKeywords:(NSSet<UniqKEKeyword *> *)values;
- (void)removeKeywords:(NSSet<UniqKEKeyword *> *)values;

@end

NS_ASSUME_NONNULL_END
