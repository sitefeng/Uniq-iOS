//
//  iPadMainFeaturedViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 12/5/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iPadDashletScrollView.h"

@class iPadBannerView, iPadFilterBarView, iPadDashletScrollView;

@interface iPadMainFeaturedViewController : UIViewController<UIScrollViewDelegate, JPDashletScrollViewDataSource, JPDashletScrollViewDelegate>
{
    @private
    
    BOOL     _isOrientationPortrait; //or will be portrait for resizing frames
    
    
    
    
    
    
    
    
}

@property (retain, nonatomic) iPadBannerView *bannerView;
@property (retain, nonatomic) iPadFilterBarView *filterBarView;
@property (retain, nonatomic) iPadDashletScrollView *dashletScrollView;









@end
