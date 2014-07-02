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


@class iPadBannerView;

@interface iPadMainFavoritesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, JPSearchBarDelegate, UIPopoverControllerDelegate, JPSortDelegate, JPDashletInfoDelegate>
{
    NSManagedObjectContext* context;
    
    BOOL        _isOrientationPortrait; //or will be portrait for resizing frames
    float       _screenWidth;
    
    NSMutableArray*    _dashletTypeCounts;
    
}



- (IBAction)editBarButtonPressed:(id)sender;


//---Model---

//Array of JPDashlets
//to be Displayed on Screen
@property (nonatomic, strong) NSMutableArray* dashlets;//array of 3arrays, school JPdashletArray, faculty, and program array

@property (nonatomic, strong) NSMutableArray* backupDashlets; //for sort

@property (nonatomic, assign) JPSortType sortType;



@property (nonatomic, strong) NSMutableArray* bannerURLs;



//---View---
@property (nonatomic, strong) UICollectionView* cv;
@property (nonatomic, strong) iPadBannerView* bannerView;
@property (nonatomic, strong) iPadSearchBarView* searchBarView;

//--Controller--
@property (nonatomic, strong) UIPopoverController* localPopoverController;



@end