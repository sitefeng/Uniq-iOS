//
//  iPadDashletView.m
//  JumpPad
//
//  Created by Si Te Feng on 12/7/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "iPadDashletView.h"
#import "iPadDashletBackgroundView.h"
#import "iOSDashletTitleView.h"
#import "iOSDashletDetailsView.h"
#import "JPLocation.h"

//Delete after Jan 15, 2013
#import "iOSDashletDetailsElementView.h"


@implementation iPadDashletView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = [JPStyle dashletDefaultBackgroundColor];
        

        self.backgroundView = [[iPadDashletBackgroundView alloc] initWithFrame: CGRectZero];
        self.titleView = [[iOSDashletTitleView alloc] initWithFrame: CGRectZero];
        self.detailsView = [[iOSDashletDetailsView alloc] initWithFrame: CGRectZero];
        
        [self addSubview:self.backgroundView];
        [self addSubview:self.titleView];
        [self addSubview:self.detailsView];
        
    }
    return self;
}



- (void)setFrame:(CGRect)frame
{
    //Making sure the initialized view is a correctly sized square view
    if(frame.size.height != frame.size.width)
    {
        frame.size.width = frame.size.height;
    }
    if(frame.size.width > kiPadSizeDashletPortrait.width)
    {
        frame.size.width = kiPadSizeDashletPortrait.width;
    }
    else if(frame.size.width < kiPadSizeDashletLandscape.width)
    {
        frame.size.width = kiPadSizeDashletLandscape.width;
    }

    [super setFrame:frame];
    
    
    //Adding all three subviews to the main dashlet view
    [self.backgroundView setFrame: jpr(kiPadDashletBorderWidth, kiPadDashletBorderWidth, frame.size.width - 2* kiPadDashletBorderWidth, frame.size.height - kiPadDashletBorderWidth - kiPadDashletDividerPositionFromBottom - kiPadDashletDividerWidth/2 - 1)];
    
    [self.titleView setFrame:jpr(kiPadDashletBorderWidth, frame.size.height - kiPadDashletDividerPositionFromBottom + kiPadDashletDividerWidth/2.0, frame.size.width - 2*kiPadDashletBorderWidth, kiPadDashletTitleHeight)];
    
    [self.detailsView setFrame:jpr(kiPadDashletBorderWidth, frame.size.height - kiPadDashletBorderWidth - kiPadDashletDetailsHeight, frame.size.width - 2*kiPadDashletBorderWidth, kiPadDashletDetailsHeight)];
    
    
    
    
    //Adding a details element view temporarily for testing
    
    iOSDashletDetailsElementView* element = [[iOSDashletDetailsElementView alloc] initWithIconName:@"establishedin" andValue:@"Est. 1897"];
    [element setFrame:jpr(kiPadDashletBorderWidth, frame.size.height - kiPadDashletBorderWidth - kiPadDashletDetailsHeight, frame.size.width -500, kiPadDashletDetailsHeight)];
    
    [self insertSubview:element aboveSubview:self.detailsView];
    
    
    
    
    
    
    
}



- (void)drawRect:(CGRect)rect
{
    //Setting the line
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Drawing the main border
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [JPStyle dashletDefaultBorderColor].CGColor);
    
    CGContextAddRect(context, CGRectInset(self.bounds, kiPadDashletBorderWidth/2.0, kiPadDashletBorderWidth/2.0));

    CGContextSetLineWidth(context, kiPadDashletBorderWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextDrawPath(context, kCGPathStroke);
    
    //Drawing the divider line
    float dashletHeight = self.frame.size.height;
    
    CGPoint dividerLine[] = {jpp(0, dashletHeight - kiPadDashletDividerPositionFromBottom),jpp(self.frame.size.width, dashletHeight - kiPadDashletDividerPositionFromBottom)};
    
    CGContextSetLineWidth(context, kiPadDashletDividerWidth);
    CGContextAddLines(context, dividerLine, kiPadDashletDividerWidth);
    CGContextDrawPath(context, kCGPathStroke);

    
    //Drawing the line between the title view and the details view
    CGContextSetStrokeColorWithColor(context, [JPStyle defaultBorderColor].CGColor);
    
    CGPoint thinLine[] = {jpp(0, dashletHeight - kiPadDashletBorderWidth - kiPadDashletDetailsHeight - kiPadDefaultBorderWidth/2.0),jpp(self.frame.size.width, dashletHeight - kiPadDashletBorderWidth - kiPadDashletDetailsHeight - kiPadDefaultBorderWidth/2.0)};
    
    CGContextSetLineWidth(context, kiPadDefaultBorderWidth);
    CGContextAddLines(context, thinLine, kiPadDefaultBorderWidth + 1);
    CGContextDrawPath(context, kCGPathStroke);
    
}


















@end
