//
//  iPadDashletView.h
//  JumpPad
//
//  Created by Si Te Feng on 12/7/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>


@class JPDashlet, iPadDashletBackgroundView, iOSDashletTitleView, iOSDashletDetailsView;

@interface iPadDashletView : UIView






@property (nonatomic, retain) JPDashlet* dashlet;

@property (nonatomic, retain) iPadDashletBackgroundView* backgroundView;
@property (nonatomic, retain) iOSDashletTitleView* titleView;
@property (nonatomic, retain) iOSDashletDetailsView* detailsView;


@property (nonatomic, assign, getter = isDeleteButtonHidden) BOOL deleteButtonHidden;








@end
