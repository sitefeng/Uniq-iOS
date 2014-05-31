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

- (NSInteger)daysLeftFromToday
{
    NSInteger daysleft = -1;
    
    NSInteger month = [self monthIntegerValue];
    NSInteger date = [self dateIntegerValue];
    
    NSCalendar* currentCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* todayComponents = [currentCal components:NSCalendarUnitYear fromDate:[NSDate date]];\
    
    NSDateComponents* deadlineComponents = [[NSDateComponents alloc] init];
    [deadlineComponents setDay:date];
    [deadlineComponents setMonth:month];
    [deadlineComponents setYear:[todayComponents year]];
    
    NSDate* today = [NSDate date];
    NSDate* deadlineDate = [currentCal dateFromComponents:deadlineComponents];
    
    if([today compare: deadlineDate] == NSOrderedDescending) //Today past the deadline
    {
        [deadlineComponents setYear:([todayComponents year]+1)];
         deadlineDate = [currentCal dateFromComponents:deadlineComponents];
    }
    
    
    NSDateComponents* diffComponent = [currentCal components:NSCalendarUnitDay fromDate:today toDate:deadlineDate options:0];
    
    daysleft = [diffComponent day];
    
    return daysleft;
}
















@end
