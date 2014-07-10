//
//  iPhMainTableViewCell.h
//  Uniq
//
//  Created by Si Te Feng on 7/10/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPadMainCollectionViewCell.h"

@class iPadDashletImageView;
@protocol JPDashletInfoDelegate;
@interface iPhMainTableViewCell : UITableViewCell




@property (nonatomic, strong) iPadDashletImageView* itemImageView;

@property (nonatomic, strong) JPDashlet* dashletInfo;

@property (nonatomic, strong) iOSDashletTitleView* title;
@property (nonatomic, strong) iOSDashletDetailsView* details;

@property (nonatomic, strong) UIButton* infoButton;
@property (nonatomic, strong) UIButton* favButton;
@property (nonatomic, assign) BOOL      showFavButton;

@property (nonatomic, weak) id<JPDashletInfoDelegate> delegate;






@end
