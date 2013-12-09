//
//  iPadDashletView.m
//  JumpPad
//
//  Created by Si Te Feng on 12/7/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "iPadDashletView.h"
#import "iPadDashletBackgroundView.h"
#import "iPadDashletDetailsView.h"

@implementation iPadDashletView

- (id)initWithFrame:(CGRect)frame
{
    //Making sure the initialized view is a correctly sized square view
    if(frame.size.height != frame.size.width)
    {
        frame.size.height = frame.size.width;
    }
    
    if(frame.size.width > 372)
    {
        frame.size.width = 372;
    }
    else if(frame.size.width < 330)
    {
        frame.size.width = 330;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = [UIColor clearColor];
        
        
        
        
        
        
        
        
    }
    return self;
}




- (void)drawRect:(CGRect)rect
{
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 3.0);
//    
//    CGFloat components[] = {0.0, 0.0, 0.8, 1.0};
//    CGColorRef color = CGColorCreate(colorspace, components);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [JPStyle dashletDefaultBorderColor].CGColor);
    
    CGContextAddRect(context, CGRectInset(self.bounds, 1.5, 1.5));
    
    CGContextSetLineWidth(context, 3);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    
    
    
}


















@end
