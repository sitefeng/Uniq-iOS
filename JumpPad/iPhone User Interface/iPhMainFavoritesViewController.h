//
//  iPhMainFavoritesViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPMainFavoritesViewController.h"

@interface iPhMainFavoritesViewController : JPMainFavoritesViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView* tableView;


@end
