//
//  iPadMainExploreViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iPadSearchBarView, iPadBannerView;

@interface iPadMainExploreViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
@private
    
    BOOL      _isOrientationPortrait; //or will be portrait for resizing frames
    
    float     _screenWidth;
}

//---Model---

//Array of JPDashlets of type JPDashletTypeCollege
@property (nonatomic, strong) NSMutableArray* featuredDashlets;



//---View---
@property (nonatomic, strong) UICollectionView* cv;
@property (nonatomic, strong) iPadBannerView* bannerView;
@property (nonatomic, strong) iPadSearchBarView* searchBarView;



@end
