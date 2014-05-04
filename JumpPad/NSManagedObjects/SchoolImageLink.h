//
//  SchoolImageLink.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-04.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class School;

@interface SchoolImageLink : NSManagedObject

@property (nonatomic, retain) NSString * descriptor;
@property (nonatomic, retain) NSString * imageLink;
@property (nonatomic, retain) School *school;

@end
