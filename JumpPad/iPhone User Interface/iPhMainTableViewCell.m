//
//  iPhMainTableViewCell.m
//  Uniq
//
//  Created by Si Te Feng on 7/10/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhMainTableViewCell.h"
#import "iPadDashletImageView.h"
#import "JPDashlet.h"
#import "JPFont.h"
#import "JPStyle.h"
#import "iPadDashletDetailsView.h"


@implementation iPhMainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.itemImageView = [[iPadDashletImageView alloc] initWithFrame:CGRectMake(5, 5, 108 -10, 81 -10)];
        self.itemImageView.clipsToBounds = YES;
        self.itemImageView.layer.cornerRadius = 15;
        self.itemImageView.layer.borderColor = [UIColor blackColor].CGColor;
        self.itemImageView.layer.borderWidth = 1.0f;
        [self addSubview:self.itemImageView];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(110, 1, kiPhoneWidthPortrait-110, 48)];
        self.title.font = [UIFont fontWithName:[JPFont defaultFont] size:16];
        self.title.numberOfLines = 2;
        [self addSubview:self.title];
        
        
        //Details
        populationImgView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 54, 18, 18)];
        populationImgView.contentMode = UIViewContentModeScaleAspectFit;
        UIImage* populationImage = [UIImage imageNamed:@"populationWireframe"];
        populationImgView.image = populationImage;
        [self addSubview:populationImgView];
        
        populationLabel = [[UILabel alloc] initWithFrame:CGRectMake(133, 50, 60, 24)];
        populationLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:16];
        populationLabel.textColor = [UIColor grayColor];
        [self addSubview:populationLabel];
        
        locationImgView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 54, 18, 18)];
        locationImgView.contentMode = UIViewContentModeScaleAspectFit;
        UIImage* locationImage = [UIImage imageNamed:@"locationWireframe"];
        locationImgView.image = locationImage;
        [self addSubview:locationImgView];
        
        locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 50, 110, 24)];
        locationLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:16];
        locationLabel.textColor = [UIColor grayColor];
        [self addSubview:locationLabel];
        
        
        self.separatorInset = UIEdgeInsetsZero;
        
    }
    return self;
}


- (void)setDashletInfo:(JPDashlet *)dashletInfo
{
    _dashletInfo = dashletInfo;
    
    NSMutableArray* imageURLs = self.dashletInfo.backgroundImages;
    
    if([imageURLs count]>0) {
        NSURL* imageURL = [imageURLs firstObject];
        self.itemImageView.imageURLs = [@[imageURL] mutableCopy];
    }
    
    self.itemImageView.logoURL = self.dashletInfo.icon;
    
    self.title.text = dashletInfo.title;
    
    populationLabel.text = [NSString stringWithFormat:@"%i",[dashletInfo.population intValue]];
    locationLabel.text = [NSString stringWithFormat:@"%@", dashletInfo.location.cityName];
}


- (void)prepareForReuse
{
    self.title.text = @"";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
