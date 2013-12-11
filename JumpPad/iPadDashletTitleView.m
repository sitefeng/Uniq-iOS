//
//  iPadDashletTitleView.m
//  JumpPad
//
//  Created by Si Te Feng on 12/10/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "iPadDashletTitleView.h"

@implementation iPadDashletTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    
    
    self.backgroundColor = [JPStyle dashletDefaultTitleBackgroundColor];
    
    
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
