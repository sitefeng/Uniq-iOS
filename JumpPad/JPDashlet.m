//
//  JPDashlet.m
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "JPDashlet.h"

@implementation JPDashlet






- (instancetype)initWithItemUID: (NSString*)uid
{
    self = [super init];
    if(self)
    {
        self.itemUID = uid;
    }
    
    return self;
}










- (NSString*)description
{
    return [NSString stringWithFormat:@"Dashlet for %@[%@]", self.title, self.itemUID];
}




@end
