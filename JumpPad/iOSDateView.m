//
//  iOSDateView.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-26.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iOSDateView.h"

#import "JPGlobal.h"
#import "JPFont.h"
#import "JPStyle.h"

@implementation iOSDateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor greenColor];
        
        self.month = 0;
        self.date = 0;
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef context= UIGraphicsGetCurrentContext();
    
    //Background color
    [[JPStyle colorWithName:@"red"] set];
    UIBezierPath* outerBoundsPath = [UIBezierPath bezierPathWithRect:rect];
    [outerBoundsPath fill];
    CGContextFillPath(context);
    
    //Content rect
    CGRect contentRect = CGRectInset(rect, rect.size.width*0.07, rect.size.height*0.07);
    
    NSString* dateString = @"--";
    if(self.date >= 1 && self.date <=31)
        dateString = [NSString stringWithFormat:@"%lu", (unsigned long)self.date];
    
    CGFloat fontSize = 80;
    UIFont* dateFont = [UIFont fontWithName:[JPFont defaultThinFont] size:fontSize];
    CGSize dateStringSize = [dateString sizeWithAttributes:@{NSFontAttributeName: dateFont}];
    
    CGRect dateRect = CGRectMake(contentRect.origin.x, rect.size.height*0.23, contentRect.size.width, contentRect.size.height - rect.size.height*0.23);
    
    while(dateStringSize.width > contentRect.size.width || dateStringSize.height > dateRect.size.height)
    {
        fontSize -= 1;
        
        dateFont = [UIFont fontWithName:[JPFont defaultThinFont] size:fontSize];
        dateStringSize = [dateString sizeWithAttributes:@{NSFontAttributeName: dateFont}];
        
    }
    
    CGRect dateTextFrame = CGRectMake(dateRect.origin.x, dateRect.origin.y, dateStringSize.width, dateStringSize.height);
 
    CGRect centeredDateRect = rectCenteredInRect(dateTextFrame, dateRect);
    
    
    [dateString drawInRect:centeredDateRect withAttributes:@{NSFontAttributeName: dateFont, NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    
    //Month
    NSString* monthString = [[JPGlobal monthStringWithInt:self.month] uppercaseString];
    
    CGRect monthRect = CGRectMake(contentRect.origin.x, rect.size.height* 0.13, contentRect.size.width, rect.size.height* 0.2);
    
    fontSize = 50;
    UIFont* monthFont = [UIFont fontWithName:[JPFont defaultThinFont] size:fontSize];
    
    CGSize monthStringSize = [monthString sizeWithAttributes:@{NSFontAttributeName: monthFont}];
    
    while(monthStringSize.height > monthRect.size.height || monthStringSize.width > monthRect.size.width)
    {
        fontSize -= 1;
        monthFont = [UIFont fontWithName:[JPFont defaultThinFont] size:fontSize];
        
        monthStringSize = [monthString sizeWithAttributes:@{NSFontAttributeName: monthFont}];
    }
    
    
    CGRect monthStringRect = CGRectMake(monthRect.origin.x, monthRect.origin.y, monthStringSize.width, monthStringSize.height);
    CGRect centeredMonthRect = rectCenteredInRect(monthStringRect, monthRect);
    
    [monthString drawInRect:centeredMonthRect withAttributes:@{NSFontAttributeName: monthFont, NSForegroundColorAttributeName: [UIColor whiteColor]}];

    
}

          
          
CGRect rectCenteredInRect(CGRect rect, CGRect mainRect)
{
    return CGRectOffset(rect, (mainRect.size.width - rect.size.width)/2, (mainRect.size.height - rect.size.height)/2);
}
          
          
          
          
          
          
          
          


@end
