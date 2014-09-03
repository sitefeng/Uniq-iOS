//
//  UniqKEFunction.h
//  Uniq
//
//  Created by Si Te Feng on 9/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
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
