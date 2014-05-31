//
//  JPMainSync.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-30.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPMainSync : NSObject





@property (nonatomic, strong) NSManagedObjectContext* context;

@property (nonatomic, strong) NSDate* timeModified;



- (void)sync;

- (void)deleteAll;


@end
