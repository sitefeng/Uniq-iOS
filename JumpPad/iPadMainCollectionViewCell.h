//
//  iPadMainCollectionViewCell.h
//  JumpPad
//
//  Created by Si Te Feng on 2/21/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iPadDashletImageView, JPDashlet, iOSDashletTitleView, iOSDashletDetailsView;

@interface iPadMainCollectionViewCell : UICollectionViewCell


@property (nonatomic, strong) iPadDashletImageView* imageView;

@property (nonatomic, strong) JPDashlet* dashletInfo;

@property (nonatomic, strong) iOSDashletTitleView* title;
@property (nonatomic, strong) iOSDashletDetailsView* details;

@property (nonatomic, strong) UIButton* infoButton;


@end
