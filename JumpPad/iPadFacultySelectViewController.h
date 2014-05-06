//
//  iPadFacultySelectViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-05.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPadSearchBarView.h"
#import "iPadMainCollectionViewCell.h"
#import "sortViewController.h"


@class iPadSearchBarView, iPadSearchBarView, iPadFacultyBannerView;

@interface iPadFacultySelectViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, JPSearchBarDelegate, JPDashletInfoDelegate, JPSortDelegate, UIPopoverControllerDelegate>
{
@private
    
    BOOL        _isOrientationPortrait; //or will be portrait for resizing frames
    float       _screenWidth;
    
    NSMutableArray* _backupDashlets;
    
}

//---Model---

@property (nonatomic, assign) NSInteger schoolId;  //Initially set by exploreVC


//Array of JPDashlets of type JPDashletTypeFaculty
@property (nonatomic, strong) NSMutableArray* dashlets;


@property (nonatomic, strong) NSManagedObjectContext* context;

@property (nonatomic, assign) JPSortType sortType;


//---View---
@property (nonatomic, strong) UICollectionView* cv;

@property (nonatomic, strong) iPadFacultyBannerView* bannerView;

@property (nonatomic, strong) iPadSearchBarView* searchBarView;

//--Controller--
@property (nonatomic, strong) UIPopoverController* localPopoverController;


@end
