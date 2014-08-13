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
#import "JPDashletTitleView.h"
#import "iPadDashletDetailsView.h"
#import "AutoScrollLabel.h"
#import "JPFont.h"


@implementation iPadMainCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [JPStyle colorWithName:@"tWhite"];
        
        self.showFavButton = NO;
        
        //Creating the Subviews
        CGRect imageFrame = CGRectMake(0, 0, frame.size.width, frame.size.height/4*3 );
        self.imageView = [[iPadDashletImageView alloc] initWithFrame:imageFrame];
        self.title = [[AutoScrollLabel alloc] initWithFrame:CGRectMake(4, self.frame.size.height/4.0*3 , self.frame.size.width - 8, self.frame.size.height/8.0 - 4 )];
        self.title.font = [UIFont fontWithName:[JPFont defaultFont] size:17];

        self.details = [[iPadDashletDetailsView alloc] initWithFrame:CGRectMake(6, frame.size.height/8.0*7 -2 , frame.size.width - 12, frame.size.height/8.0 - 1)];
        
        self.infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
        self.infoButton.tintColor = [JPStyle interfaceTintColor];
        self.infoButton.frame = CGRectMake(frame.size.width - 40, frame.size.height - 40, 40, 40);
        self.infoButton.hidden = YES;
        [self.infoButton addTarget:self action:@selector(infoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        //Favorite View
        self.favButton = [[UIButton alloc] init];
        self.favButton.frame = CGRectMake(frame.size.width - 45, 5, 40, 40);
        self.favButton.hidden = YES;
        self.favButton.selected = NO;
        [self.favButton setImage:[UIImage imageNamed:@"favoriteIcon"] forState:UIControlStateNormal];
        [self.favButton setImage:[UIImage imageNamed:@"favoriteIconSelected3"] forState:UIControlStateHighlighted];
        [self.favButton setImage:[UIImage imageNamed:@"favoriteIconSelected"] forState:UIControlStateSelected];
        [self.favButton addTarget:self action:@selector(favButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        //Adding the Subviews
        [self addSubview:self.imageView];
        [self addSubview:self.title];
        [self addSubview:self.details];
        [self addSubview:self.infoButton];
        [self addSubview:self.favButton];
        
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10;
        
    }
    return self;
}


#pragma mark - Setter Methods

- (void)setDashletInfo:(JPDashlet *)dashletInfo
{
    _dashletInfo = dashletInfo;
    
    [self.title removeFromSuperview];
    
    [self addSubview:self.title];
    
    if(_dashletInfo.title)
    {
        self.title.text = [_dashletInfo.title uppercaseString];
    }
    else
    {
        self.title.text = @"Information Not Set";
    }
    
    self.imageView.logoURL = _dashletInfo.icon;
    //Load only one image at this time
    self.imageView.imageURLs = _dashletInfo.backgroundImages;
    
    self.details.label.text = [NSString stringWithFormat:@"%@",self.dashletInfo.population];
    self.details.label2.text = [NSString stringWithFormat:@"%@", self.dashletInfo.location.cityName];
    
    self.favButton.selected = [_dashletInfo isFavorited];
    
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


- (void)favButtonPressed: (id)sender
{
    if([self.delegate respondsToSelector:@selector(favButtonPressed:favorited:)])
    {
        if(!self.favButton.selected) //Selecting the fav button
        {
            [self.delegate favButtonPressed:self favorited:YES];
            self.favButton.selected = YES;
        }
        else
        {
            [self.delegate favButtonPressed:self favorited:NO];
            self.favButton.selected = NO;
        }
        
    }
}

- (void)setShowFavButton:(BOOL)showFavButton
{
    _showFavButton = showFavButton;
    
    if(_showFavButton)
    {
        self.favButton.hidden = NO;
    }
    else
    {
        self.favButton.hidden = YES;
    }
}



- (void)prepareForReuse
{

    
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
