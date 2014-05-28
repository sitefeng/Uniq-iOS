//
//  UniqKEFunction.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-27.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UniqKEFunction : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSSet *keywords;
@property (nonatomic, retain) NSManagedObject *knowledgeEngine;
@end

@interface UniqKEFunction (CoreDataGeneratedAccessors)

- (void)addKeywordsObject:(NSManagedObject *)value;
- (void)removeKeywordsObject:(NSManagedObject *)value;
- (void)addKeywords:(NSSet *)values;
- (void)removeKeywords:(NSSet *)values;

@end
