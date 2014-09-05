//
//  iPadProgramSelectViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPadSearchBarView.h"
#import "iPadMainCollectionViewCell.h"
#import "sortViewController.h"
#import "JPDataRequest.h"


@class iPadSearchBarView, iPadSearchBarView, iPadFacultyBannerView;

@interface iPadProgramSelectViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, JPSearchBarDelegate, JPSortDelegate, JPDashletInfoDelegate, UIPopoverControllerDelegate, JPDataRequestDelegate>
{
    @private
    JPDataRequest* _dataRequest;
    
    BOOL        _isOrientationPortrait; //or will be portrait for resizing frames
    float       _screenWidth;
    
    NSMutableArray* _backupDashlets;
    
}

//---Model---

@property (nonatomic, strong) NSString* facultyId;  //Initially set by FacultySelectVC (dashletUid)
@property (nonatomic, strong) JPDashlet* facultyDashlet;


//Array of JPDashlets of type JPDashletTypeProgram
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
