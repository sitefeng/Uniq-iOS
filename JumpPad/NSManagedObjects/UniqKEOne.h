//
//  UniqKEOne.h
//  Uniq
//
//  Created by Si Te Feng on 2/10/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UniqKEFunction;

@interface UniqKEOne : NSManagedObject

@property (nonatomic, retain) NSSet *functions;
@end

@interface UniqKEOne (CoreDataGeneratedAccessors)

- (void)addFunctionsObject:(UniqKEFunction *)value;
- (void)removeFunctionsObject:(UniqKEFunction *)value;
- (void)addFunctions:(NSSet *)values;
- (void)removeFunctions:(NSSet *)values;

@end
