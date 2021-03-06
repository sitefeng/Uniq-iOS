//
//  iPadMainCollectionViewCell.h
//  JumpPad
//
//  Created by Si Te Feng on 2/21/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iPadDashletImageView, JPDashlet, JPDashletTitleView, iPadDashletDetailsView, AutoScrollLabel;

@protocol JPDashletInfoDelegate;

@interface iPadMainCollectionViewCell : UICollectionViewCell
{
   
}

@property (nonatomic, strong) iPadDashletImageView* imageView;

@property (nonatomic, strong) JPDashlet* dashletInfo;

//JPDashletTitleView no longer used
@property (nonatomic, strong) AutoScrollLabel* title;
@property (nonatomic, strong) iPadDashletDetailsView* details;

@property (nonatomic, strong) UIButton* infoButton;
@property (nonatomic, strong) UIButton* favButton;
@property (nonatomic, assign) BOOL      showFavButton;

@property (nonatomic, weak) id<JPDashletInfoDelegate> delegate;


@end



@protocol JPDashletInfoDelegate <NSObject>

@optional
- (void)infoButtonPressed: (iPadMainCollectionViewCell*)sender;
- (void)favButtonPressed: (iPadMainCollectionViewCell*)sender favorited: (BOOL)fav;



@end