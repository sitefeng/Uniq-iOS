//
//  iPadDashletTitleView.m
//  JumpPad
//
//  Created by Si Te Feng on 12/10/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "iOSDashletTitleView.h"

@implementation iOSDashletTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [JPStyle dashletDefaultTitleBackgroundColor];
        
        self.iconPositionLeft = YES;
        
        
        
    }
    return self;
}

- (void)setTitleIconName:(NSString *)titleIconName
{
    _titleIconName = titleIconName;
    self.titleIconImage = [UIImage imageWithContentsOfFile:titleIconName];
}


-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if(self.iconPositionLeft)
    {
        
    }
    else
    {
        
    }
    
    
    
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
