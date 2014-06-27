//
//  UniqKEKeyword.h
//  Uniq
//
//  Created by Si Te Feng on 6/26/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UniqKEFunction;

@interface UniqKEKeyword : NSManagedObject

@property (nonatomic, retain) NSString * keyword;
@property (nonatomic, retain) UniqKEFunction *function;

@end
