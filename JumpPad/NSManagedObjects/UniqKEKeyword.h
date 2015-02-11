//
//  UniqKEKeyword.h
//  Uniq
//
//  Created by Si Te Feng on 2/10/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UniqKEFunction;

@interface UniqKEKeyword : NSManagedObject

@property (nonatomic, retain) NSString * keyword;
@property (nonatomic, retain) UniqKEFunction *function;

@end
