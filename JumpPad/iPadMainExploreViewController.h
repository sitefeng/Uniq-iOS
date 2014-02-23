//
//  iPadMainExploreViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPadSearchBarView.h"
#import "sortViewController.h"

@class iPadBannerView;


@interface iPadMainExploreViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, JPSearchBarDelegate, UIPopoverControllerDelegate, JPSortDelegate>
{
@private
    
    BOOL      _isOrientationPortrait; //or will be portrait for resizing frames
    
    float     _screenWidth;
}

//---Model---

//Array of JPDashlets of type JPDashletTypeCollege
@property (nonatomic, strong) NSMutableArray* dashlets;



//---View---
@property (nonatomic, strong) UICollectionView* cv;
@property (nonatomic, strong) iPadBannerView* bannerView;
@property (nonatomic, strong) iPadSearchBarView* searchBarView;

//--Controller--
@property (nonatomic, strong) UIPopoverController* localPopoverController;

@end
