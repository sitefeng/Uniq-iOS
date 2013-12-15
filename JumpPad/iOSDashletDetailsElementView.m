//
//  iOSDashletDetailsElementView.m
//  JumpPad
//
//  Created by Si Te Feng on 12/11/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "iOSDashletDetailsElementView.h"
#import "ApplicationConstants.h"
#import "JPFont.h"


@implementation iOSDashletDetailsElementView


- (instancetype)initWithIconName:(NSString*)iconName andValue:(NSString*)value
{
    self = [self initWithFrame:CGRectZero];
    if(self)
    {
        [self setTintColor:[UIColor redColor]];
        
        self.iconImage = [UIImage imageNamed: iconName];
        self.value = value;

        [self addSubview:self.imageView];
        
        
        
        
        
        [self addSubview:self.label];
        
    }
    
    return self;
}


- (void)setIconImage:(UIImage *)iconImage
{
    //Check the functionality of the following code!!!
    if(iconImage ==nil)
    {
        iconImage = [UIImage imageNamed: kDashletDetailsElementIconDefaultName];
    }
    
    _iconImage = iconImage;
    
    self.imageView = [[UIImageView alloc] initWithImage:iconImage];
}


- (void)setValue:(NSString *)value
{
    _value = value;

    _label = [[UILabel alloc] init];
    
    _attributes = @{NSFontAttributeName: [UIFont fontWithName:[JPFont defaultBoldFont] size:19], NSForegroundColorAttributeName: [JPStyle dashletDefaultDetailsTextColor] };
    
    _label.attributedText = [[NSAttributedString alloc] initWithString: value attributes:_attributes];
    
//    self.label.text = value;
    
}


// For each individual scrollable elements, the width is automatically generated. Specified WIDTH will be IGNORED!
- (void)setFrame:(CGRect)frame
{
    //Autogenerating element width
    CGSize textSize = [self.label.text sizeWithAttributes:_attributes];
    CGFloat frameWidth = textSize.width + frame.size.height;
    
    CGRect newFrame = jpr(frame.origin.x, frame.origin.y, frameWidth, frame.size.height);
    
    [super setFrame:newFrame];
    
    
    //Setting icon and value
    [self.imageView setFrame:jpr(7, 7, newFrame.size.height - 14, newFrame.size.height - 14)];
    
    [self.label setFrame:jpr(newFrame.size.height, 3, textSize.width, newFrame.size.height - 6)];
    
    
    
    
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
