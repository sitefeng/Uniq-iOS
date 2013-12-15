//
//  JPItemUID.m
//  JumpPad
//
//  Created by Si Te Feng on 12/11/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "JPItemUID.h"

@implementation JPItemUID

+ (JPItemUID*)itemUIDFromString: (NSString*)string
{
    JPItemUID* uid = (JPItemUID*)string;
    
    return uid;
}

- (NSUInteger)collegeNumber
{
    
    
    return 1;
}


- (NSUInteger)facultyNumber
{
    
    
        return 1;
    
}
- (NSUInteger)programNumber
{
    
        return 1;
    
}









- (BOOL)isEqual:(JPItemUID*)object
{
    
    
    
    
    return YES;
    
}



- (NSString*)description
{
    return self;
}





@end
