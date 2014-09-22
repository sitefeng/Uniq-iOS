//
//  JPMainFeaturedViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBParallaxPhoneCell.h"
#import "JPDataRequest.h"
#import "JPCloudFavoritesHelper.h"


@class JBParallaxPhoneCell, JPCoreDataHelper, JPDataRequest;
@interface JPMainFeaturedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, JPFavoriteButtonDelegate, JPDataRequestDelegate, JPCloudFavoritesHelperDelegate>
{
    NSManagedObjectContext* context;
    JPCoreDataHelper*  _helper;
    JPDataRequest*     _dataReq;
    JPCloudFavoritesHelper*  _cloudFav;
}




@property (nonatomic, strong) UITableView* tableView;


@property (nonatomic, strong) NSArray* featuredArray;
@property (nonatomic, strong) NSMutableArray* featuredFavNums;


@end
