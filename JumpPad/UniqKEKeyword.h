//
//  UniqKEKeyword.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-27.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UniqKEFunction;

@interface UniqKEKeyword : NSManagedObject

@property (nonatomic, retain) NSString * keyword;
@property (nonatomic, retain) UniqKEFunction *function;

@end
