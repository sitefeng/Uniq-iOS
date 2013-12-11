//
//  iPadDashletView.h
//  JumpPad
//
//  Created by Si Te Feng on 12/7/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>


@class JPDashlet, iPadDashletBackgroundView, iPadDashletTitleView, iPadDashletDetailsView;

@interface iPadDashletView : UIView






@property (nonatomic, retain) JPDashlet* dashlet;

@property (nonatomic, retain) iPadDashletBackgroundView* backgroundView;
@property (nonatomic, retain) iPadDashletTitleView* titleView;
@property (nonatomic, retain) iPadDashletDetailsView* detailsView;


@property (nonatomic, assign) BOOL hideDeleteButton;








@end
