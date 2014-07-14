//
//  iPhAppProgressPanView.m
//  Uniq
//
//  Created by Si Te Feng on 7/13/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhAppProgressPanView.h"
#import "JPStyle.h"
#import "JPFont.h"

@implementation iPhAppProgressPanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [JPStyle colorWithName:@"tWhite"];
        UIView* bottomVisibleView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 30, frame.size.width, 30)];
        [self addSubview:bottomVisibleView];
        
        _dragBar = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2.0 - 15, 5, 30, 20)];
        _dragBar.image = [UIImage imageNamed:@"dragBarIcon"];
        [bottomVisibleView addSubview:_dragBar];
        
        UILabel* dragBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
        dragBarLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
        dragBarLabel.textColor = [UIColor blackColor];
        dragBarLabel.text = @"Progress";
        [bottomVisibleView addSubview:dragBarLabel];
        
        
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
