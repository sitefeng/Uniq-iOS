//
//  iPadMainTabBarController.h
//  Uniq
//
//  Created by Si Te Feng on 8/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNScrollView;
@interface iPadMainTabBarController : UITabBarController <UIScrollViewDelegate>
{
    UIView*    whiteView;
    
    
    HNScrollView*  imageScrollView;
    UIPageControl* pageControl;
    UIButton*      actionButton;
    
    
    UIImageView*  logoImageView;
    UIImageView*  logoShadowView;
    UILabel*      appTitle;
    UILabel*      appSubtitle;
    
    
    NSTimer*      _backgroundAlphaChange;
    
}



@end
