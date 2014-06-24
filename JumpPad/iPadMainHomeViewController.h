//
//  iPadMainHomeViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iPadHomeProfileBanner, iPadHomeToolbarView;
@interface iPadMainHomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
}



@property (nonatomic, strong) iPadHomeProfileBanner* profileBanner;

@property (nonatomic, strong) iPadHomeToolbarView* toolbar;

@property (nonatomic, strong) UITableView* tableView;



@end
