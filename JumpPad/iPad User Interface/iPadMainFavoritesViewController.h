//
//  iPadMainFavoritesViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPadSearchBarView.h"
#import "sortViewController.h"
#import "iPadMainCollectionViewCell.h"
#import "JPMainFavoritesViewController.h"

@class JPBannerView;

@interface iPadMainFavoritesViewController : JPMainFavoritesViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, JPSearchBarDelegate, UIPopoverControllerDelegate, JPSortDelegate, JPDashletInfoDelegate>
{
    
    @private
    BOOL        _isOrientationPortrait; //or will be portrait for resizing frames
    float       _screenWidth;
    
    
    

}



- (IBAction)editBarButtonPressed:(id)sender;


//---Model---
@property (nonatomic, assign) JPSortType sortType;



//---View---
@property (nonatomic, strong) UICollectionView* cv;
@property (nonatomic, strong) iPadSearchBarView* searchBarView;

//--Controller--
@property (nonatomic, strong) UIPopoverController* localPopoverController;



@end