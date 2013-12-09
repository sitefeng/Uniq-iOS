//
//  iPadDashletScrollView.m
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "iPadDashletScrollView.h"
#import "iPadDashletView.h"

@implementation iPadDashletScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        iPadDashletView *dashletView = [[iPadDashletView alloc] initWithFrame:CGRectMakeWithOriginXYAndSize(0, 0, kiPadSizeDashletPortrait)];
        
        dashletView.center = ccp(dashletView.frame.size.width/2 + kiPadSizeDashletBorderPadding, dashletView.frame.size.height/2 + kiPadSizeDashletBorderPadding);  //CGPointMake
        
        [self addSubview:dashletView];
        
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
