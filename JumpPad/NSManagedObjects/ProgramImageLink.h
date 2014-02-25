//
//  ProgramImageLink.h
//  JumpPad
//
//  Created by Si Te Feng on 2/25/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Program;

@interface ProgramImageLink : NSManagedObject

@property (nonatomic, retain) NSString * descriptor;
@property (nonatomic, retain) NSString * imageLink;
@property (nonatomic, retain) NSNumber * pImageId;
@property (nonatomic, retain) NSDate * timeModified;
@property (nonatomic, retain) Program *program;

@end
