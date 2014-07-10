//
//  JPMainFavoritesViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JPBannerView;
@interface JPMainFavoritesViewController : UIViewController
//abstract super class for iPad and iPhone counterparts
{
    @protected
    NSManagedObjectContext* context;
    
    NSMutableArray*    _dashletTypeCounts;
    
    
    BOOL               _isEditing;
    NSMutableArray*    _favDashletsToDelete;
    
}


//Array of array of JPDashlets
@property (nonatomic, strong) NSMutableArray* dashlets;//array of 3arrays, school JPdashletArray, faculty, and program array
@property (nonatomic, strong) NSMutableArray* backupDashlets; //for sort



@property (nonatomic, strong) NSMutableArray* bannerURLs;
@property (nonatomic, strong) JPBannerView* bannerView;


- (void)updateDashletsInfo;
- (void)updateBannerInfo;

- (void)removeUnselectedFavoritesFromCoreData;
- (void)editBarButtonPressed: (id)sender;
- (void)favButtonPressedIsFavorited: (BOOL)fav dashletUid: (NSUInteger)dashletUid;

@end
