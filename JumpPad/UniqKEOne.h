//
//  UniqKEOne.h
//  Uniq
//
//  Created by Si Te Feng on 9/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
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
