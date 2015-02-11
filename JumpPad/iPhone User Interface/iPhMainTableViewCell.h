//
//  iPhMainTableViewCell.h
//  Uniq
//
//  Created by Si Te Feng on 7/10/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>


@class iPadDashletImageView, JPDashlet, iPadDashletDetailsView;
@protocol JPDashletCellInfoDelegate;
@interface iPhMainTableViewCell : UITableViewCell
{
    UIImageView* populationImgView;
    UILabel*     populationLabel;
    UIImageView* locationImgView;
    UILabel*     locationLabel;
}


@property (nonatomic, strong) JPDashlet* dashletInfo;

@property (nonatomic, strong) iPadDashletImageView* itemImageView;

@property (nonatomic, strong) UILabel* title;
@property (nonatomic, strong) iPadDashletDetailsView* details;

@property (nonatomic, strong) UIButton* infoButton;
@property (nonatomic, strong) UIButton* favButton;
@property (nonatomic, assign) BOOL      showFavButton;

@property (nonatomic, weak) id<JPDashletCellInfoDelegate> delegate;






@end

@protocol JPDashletCellInfoDelegate <NSObject>

@optional
- (void)infoButtonPressed: (iPhMainTableViewCell*)sender;
- (void)favButtonPressed: (iPhMainTableViewCell*)sender favorited: (BOOL)fav;


@end
