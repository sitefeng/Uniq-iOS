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
#import "iOSDashletDetailsView.h"
#import "iOSDashletTitleView.h"

@implementation iPhMainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.itemImageView = [[iPadDashletImageView alloc] initWithFrame:CGRectMake(0, 0, 108, 81)];
        [self addSubview:self.itemImageView];
        
        self.title = [[iOSDashletTitleView alloc] initWithFrame:CGRectMake(110, 5, kiPhoneWidthPortrait-110, 30)];
        [self addSubview:self.title];
        
        self.details = [[iOSDashletDetailsView alloc] initWithFrame:CGRectMake(110, 40, kiPhoneWidthPortrait- 110, 30)];
        [self addSubview:self.details];
        
        self.separatorInset = UIEdgeInsetsZero;
        
    }
    return self;
}


- (void)setDashletInfo:(JPDashlet *)dashletInfo
{
    _dashletInfo = dashletInfo;
    
    self.itemImageView.imageURLs = self.dashletInfo.backgroundImages;
    self.itemImageView.logoURL = self.dashletInfo.icon;
    
    self.title.text = dashletInfo.title;
    
    self.details.label.text = [NSString stringWithFormat:@"%i",[dashletInfo.population intValue]];
    self.details.label2.text = [NSString stringWithFormat:@"%@", dashletInfo.location.cityName];
    
}



- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
