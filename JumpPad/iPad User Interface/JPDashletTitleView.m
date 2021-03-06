//
//  iPadDashletTitleView.m
//  JumpPad
//
//  Created by Si Te Feng on 12/10/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "JPDashletTitleView.h"
#import "JPFont.h"

@implementation JPDashletTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUserInteractionEnabled:NO];

        self.titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)setTitleIconName:(NSString *)titleIconName
{
    _titleIconName = titleIconName;
    self.titleIconImage = [UIImage imageWithContentsOfFile:titleIconName];
}



- (void) setText:(NSString *)text
{
    _text = text;
    self.titleLabel.text = text;
    
    float fontSize = 15.0f;
    NSString* fontName = [JPFont defaultMediumFont];
    
    CGSize size = [self.titleLabel.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize]}];
    
    while(size.width > self.titleLabel.bounds.size.width)
    {
        fontSize -= 0.5;
        
        size = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize]}];
    }
    
    self.titleLabel.font = [UIFont fontWithName:fontName size:fontSize];
    
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
