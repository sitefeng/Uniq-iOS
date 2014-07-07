//
//  iPadDashletDetailsView.m
//  JumpPad
//
//  Created by Si Te Feng on 12/11/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "iOSDashletDetailsView.h"
#import "JPFont.h"

@implementation iOSDashletDetailsView

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame value1:@0 value2: @0];
    
    return self;
}


- (id)initWithFrame:(CGRect)frame value1:(id)val1 value2: (id)val2
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 23, 23)];
        self.starImageView.contentMode = UIViewContentModeScaleAspectFit;
        UIImage* populationImage = [UIImage imageNamed:@"population"];
        self.starImageView.image = populationImage;
        [self addSubview:self.starImageView];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(25, 3, 60, 24)];
        self.label.font = [UIFont fontWithName:[JPFont defaultFont] size:18];
        self.label.text = [NSString stringWithFormat:@"%@", val1];
        self.label.textColor = [UIColor blackColor];
        [self addSubview:self.label];
        
        self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(90, 5, 19, 19)];
        self.imageView2.contentMode = UIViewContentModeScaleAspectFit;
        UIImage* locationImage = [UIImage imageNamed:@"location"];
        self.imageView2.image = locationImage;
        [self addSubview:self.imageView2];
        
        self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(110, 3, 110, 24)];
        self.label2.font = [UIFont fontWithName:[JPFont defaultFont] size:18];
        self.label2.text = [NSString stringWithFormat:@"%@", val2];
        self.label2.textColor = [UIColor blackColor];
        [self addSubview:self.label2];
        
        [self setUserInteractionEnabled:NO];
    }
    return self;
    
}





//setFrame
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
