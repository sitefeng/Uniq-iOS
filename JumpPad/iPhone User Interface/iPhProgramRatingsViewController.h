//
//  iPhProgramRatingsViewController.h
//  Uniq
//
//  Created by Si Te Feng on 8/14/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPhProgramRatingsTableCell.h"
#import "JPProgramRatingHelper.h"

@class Program, JPProgramRatingHelper;
@interface iPhProgramRatingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, JPProgramRatingsCellDelegate, JPProgramRatingHelperDelegate>


@property (nonatomic, strong) Program* program;

@property (nonatomic, strong) UITableView* tableView;

- (instancetype)initWithProgram: (Program*)program;

@end
