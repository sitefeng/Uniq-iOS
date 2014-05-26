//
//  NSString+JPDateStringParser.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-26.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "NSString+JPDateStringParser.h"

@implementation NSString (JPDateStringParser)

- (NSUInteger)monthIntegerValue
{
    NSString* monthString = [self substringToIndex:2];
    
    return (NSUInteger)[monthString integerValue];
}

- (NSUInteger)dateIntegerValue
{
    NSString* monthString = [self substringFromIndex:3];
    NSUInteger month = 0;
    
    if(monthString.length == 2)
        month = (NSUInteger)[monthString integerValue];
    
    return month;
}


@end
