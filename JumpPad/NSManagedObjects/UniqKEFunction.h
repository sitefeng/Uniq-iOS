//
//  UniqKEFunction.h
//  Uniq
//
//  Created by Si Te Feng on 2/10/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UniqKEKeyword, UniqKEOne;

@interface UniqKEFunction : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) NSSet *keywords;
@property (nonatomic, retain) UniqKEOne *knowledgeEngine;
@end

@interface UniqKEFunction (CoreDataGeneratedAccessors)

- (void)addKeywordsObject:(UniqKEKeyword *)value;
- (void)removeKeywordsObject:(UniqKEKeyword *)value;
- (void)addKeywords:(NSSet *)values;
- (void)removeKeywords:(NSSet *)values;

@end
