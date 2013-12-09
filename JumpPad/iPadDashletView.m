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
#import "JPLocation.h"

@implementation iPadDashletView

- (id)initWithFrame:(CGRect)frame
{
    //Making sure the initialized view is a correctly sized square view
    if(frame.size.height != frame.size.width)
    {
        frame.size.height = frame.size.width;
    }
    
    if(frame.size.width > kiPadSizeDashletPortrait.width)
    {
        frame.size.width = kiPadSizeDashletPortrait.width;
    }
    else if(frame.size.width < kiPadSizeDashletLandscape.width)
    {
        frame.size.width = kiPadSizeDashletLandscape.width;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = [UIColor clearColor];
        
        
        
        
        
        
        
        
    }
    return self;
}




- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [JPStyle dashletDefaultBorderColor].CGColor);
    
    CGContextAddRect(context, CGRectInset(self.bounds, kiPadDashletBorderWidth/2.0, kiPadDashletBorderWidth/2.0));

    CGContextSetLineWidth(context, kiPadDashletBorderWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGPoint line[] = {jpp(0, kiPadDashletDividerPositionFromTopPortrait),jpp(self.frame.size.width, kiPadDashletDividerPositionFromTopPortrait)};
    CGContextSetLineWidth(context, kiPadDashletDividerWidth);
    CGContextAddLines(context, line, 2);
    CGContextDrawPath(context, kCGPathStroke);
    
    
}


















@end
