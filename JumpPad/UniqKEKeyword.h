//
//  UniqKEKeyword.h
//  Uniq
//
//  Created by Si Te Feng on 9/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UniqKEFunction;

@interface UniqKEKeyword : NSManagedObject

@property (nonatomic, retain) NSString * keyword;
@property (nonatomic, retain) UniqKEFunction *function;

@end
