//
//  iPhProgramRatingsViewController.h
//  Uniq
//
//  Created by Si Te Feng on 8/14/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Program;
@interface iPhProgramRatingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray*   _cellTitles;
}




@property (nonatomic, strong) Program* program;

@property (nonatomic, strong) UITableView* tableView;

- (instancetype)initWithProgram: (Program*)program;



@end
