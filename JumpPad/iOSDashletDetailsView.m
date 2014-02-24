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
    self = [self initWithFrame:frame andRating:0];
    
    return self;
}


- (id)initWithFrame:(CGRect)frame andRating:(NSInteger)rating
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //DELETE
        rating = 25;
        
        self.starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (frame.size.height-18)/2.0, 18, 18)];
        
        self.starImage = [UIImage imageNamed:@"filledStar"];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(20, (frame.size.height -20)/2.0 -3, 150, 24)];
        self.label.font = [UIFont fontWithName:[JPFont defaultFont] size:20];
        self.label.text = [NSString stringWithFormat:@"%i", rating];
        self.label.textColor = [UIColor blackColor];
        
        [self addSubview:self.starImageView];
        [self addSubview:self.label];
        
        [self setUserInteractionEnabled:NO];
    }
    return self;
    
}


- (void)setStarImage:(UIImage *)starImage
{
    _starImage = starImage;
    
    self.starImageView.image = _starImage;
    
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
