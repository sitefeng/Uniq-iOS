//
//  JPMainFeaturedViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBParallaxPhoneCell.h"

@class JBParallaxPhoneCell, JPCoreDataHelper;
@interface iPhMainFeaturedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, JPFavoriteButtonDelegate>
{
    NSManagedObjectContext* context;
    JPCoreDataHelper*  _helper;
}




@property (nonatomic, strong) UITableView* tableView;


@property (nonatomic, strong) NSMutableArray* featuredArray;



@end
