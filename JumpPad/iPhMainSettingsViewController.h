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

@class User, JPUserLocator, MFMailComposeViewController;
@interface iPhMainSettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, JPUserLocatorDelegate, MFMailComposeViewControllerDelegate, UIActionSheetDelegate, UIAlertViewDelegate>
{
    
    NSManagedObjectContext* context;
    User*       _user;
    JPUserLocator*  _userLocator;
    
    NSArray*    _cellSectionTitles;
    NSArray*    _cellTitleStrings;
    NSArray*    _cellImageStrings;
    
    MFMailComposeViewController* _mailController;
    
}


@property (nonatomic, strong) UITableView* tableView;


@end
