//
//  iPadDashletBackgroundView.m
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "iPadDashletBackgroundView.h"

@interface iPadDashletBackgroundView()


@property (nonatomic, strong) UIImage* icon;

@end



@implementation iPadDashletBackgroundView

@synthesize iconName=_iconName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        
        
    }
    return self;
}

- (void)setIconName:(NSString *)iconName
{
    _iconName = iconName;
    _icon = [[UIImage alloc] initWithContentsOfFile:iconName];
    
}





- (void)setIcon:(UIImage *)icon
{
    if(!_icon)
    {
        _icon = [[UIImage alloc] init];
    }
    
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
 
    
    
    
    
    
    
    
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
