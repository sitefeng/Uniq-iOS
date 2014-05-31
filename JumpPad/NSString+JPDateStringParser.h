//
//  NSString+JPDateStringParser.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-26.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JPDateStringParser)


//Accepts "MM/dd" format
- (NSUInteger)monthIntegerValue;

- (NSUInteger)dateIntegerValue;


- (NSInteger)daysLeftFromToday;


@end
