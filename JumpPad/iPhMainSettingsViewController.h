//
//  JPMainHomeViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPUserLocator.h"
#import <MessageUI/MessageUI.h>

@interface iPhMainSettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, JPUserLocatorDelegate, MFMailComposeViewControllerDelegate, UIActionSheetDelegate>
{
    NSArray*    _cellSectionTitles;
    NSArray*    _cellTitleStrings;
    NSArray*    _cellImageStrings;
}


@property (nonatomic, strong) UITableView* tableView;


@end
