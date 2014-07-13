//
//  iPhMainExploreViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/10/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPMainExploreViewController.h"
#import "iPhMainTableViewCell.h"


@interface iPhMainExploreViewController : JPMainExploreViewController <UITableViewDataSource, UITableViewDelegate, JPDashletCellInfoDelegate>



@property (nonatomic, strong) UITableView* tableView;




@end
