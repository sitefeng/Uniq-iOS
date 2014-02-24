//
//  iPadMainCollectionViewCell.m
//  JumpPad
//
//  Created by Si Te Feng on 2/21/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadMainCollectionViewCell.h"
#import "iPadDashletImageView.h"
#import "JPDashlet.h"
#import "iOSDashletTitleView.h"
#import "iOSDashletDetailsView.h"

#import "iPadCollegeViewController.h"

@implementation iPadMainCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"whiteBackground2"]];
        
        //Creating the Subviews
        CGRect imageFrame = CGRectMake(kiPadDashletImagePadding, kiPadDashletImagePadding, frame.size.width - 2*kiPadDashletImagePadding, frame.size.height/4*3 - 2*kiPadDashletImagePadding);
        
        self.imageView = [[iPadDashletImageView alloc] initWithFrame:imageFrame];
        
        self.title = [[iOSDashletTitleView alloc] initWithFrame:CGRectMake(12, frame.size.height/4.0*3 , frame.size.width - 18, frame.size.height/8.0 - 4 )];
  
        self.details = [[iOSDashletDetailsView alloc] initWithFrame:CGRectMake(12, frame.size.height/8.0*7 -2 , frame.size.width - 24, frame.size.height/8.0 - 1)];
        
        self.infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
        self.infoButton.frame = CGRectMake(frame.size.width - 40, frame.size.height - 40, 40, 40);
        
        [self.infoButton addTarget:self action:@selector(infoButtonPressed:) forControlEvents:UIControlEventTouchDown];
        
        //Adding the Subviews
        [self addSubview:self.imageView];
        
        [self addSubview:self.title];
        [self addSubview:self.details];
        
        [self addSubview:self.infoButton];
        
    }
    return self;
}


- (void)setDashletInfo:(JPDashlet *)dashletInfo
{
    _dashletInfo = dashletInfo;
    
    self.title.text = [_dashletInfo.title uppercaseString];
    
    self.imageView.logo = _dashletInfo.icon;
    
    self.imageView.images = _dashletInfo.backgroundImages;
    
}




- (void)infoButtonPressed: (id)sender
{
    [self.delegate infoButtonPressed:self];
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
