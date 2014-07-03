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




@implementation iPadMainCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [JPStyle colorWithName:@"tWhite"];
        
        //Creating the Subviews
        CGRect imageFrame = CGRectMake(0, 0, frame.size.width, frame.size.height/4*3 );
        
        self.imageView = [[iPadDashletImageView alloc] initWithFrame:imageFrame];
        
        self.title = [[iOSDashletTitleView alloc] initWithFrame:CGRectMake(2, frame.size.height/4.0*3 , frame.size.width - 2, frame.size.height/8.0 - 4 )];
  
        self.details = [[iOSDashletDetailsView alloc] initWithFrame:CGRectMake(6, frame.size.height/8.0*7 -2 , frame.size.width - 12, frame.size.height/8.0 - 1)];
        
        self.infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
        self.infoButton.frame = CGRectMake(frame.size.width - 40, frame.size.height - 40, 40, 40);
        self.infoButton.hidden = YES;
        [self.infoButton addTarget:self action:@selector(infoButtonPressed:) forControlEvents:UIControlEventTouchDown];
        
        //Adding the Subviews
        [self addSubview:self.imageView];
        
        [self addSubview:self.title];
        [self addSubview:self.details];
        
        [self addSubview:self.infoButton];
        
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10;
        
    }
    return self;
}


#pragma mark - Setter Methods

- (void)setDashletInfo:(JPDashlet *)dashletInfo
{
    _dashletInfo = dashletInfo;
    
    if(_dashletInfo.title)
    {
        self.title.text = [_dashletInfo.title uppercaseString];
    }
    else
    {
        self.title.text = @"- - - - -";
    }
    
    self.imageView.logoURL = _dashletInfo.icon;
    
    self.imageView.imageURLs = _dashletInfo.backgroundImages;
    
}


- (void)setDelegate:(id<JPDashletInfoDelegate>)delegate
{
    _delegate = delegate;
    
    if([_delegate respondsToSelector:@selector(infoButtonPressed:)])
    {
        self.infoButton.hidden = NO;
    }
}



- (void)infoButtonPressed: (id)sender
{
    if([self.delegate respondsToSelector:@selector(infoButtonPressed:)])
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
