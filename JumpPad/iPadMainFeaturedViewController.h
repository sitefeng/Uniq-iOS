//
//  iPadMainFeaturedViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 12/5/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBParallaxCell.h"
#import "JPCloudFavoritesHelper.h"

@class JBParallaxCell, JPCoreDataHelper;
@interface iPadMainFeaturedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, JPFavoriteButtonDelegate, JPCloudFavoritesHelperDelegate>
{
    @private
    
    NSManagedObjectContext* context;
    JPCoreDataHelper*  _coreDataHelper;
    JPCloudFavoritesHelper* _cloudFav;
    
    BOOL      _isOrientationPortrait; //or will be portrait for resizing frames
    

    
}



@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* featuredArray;
@property (nonatomic, strong) NSMutableArray* featuredFavNums;

@end
