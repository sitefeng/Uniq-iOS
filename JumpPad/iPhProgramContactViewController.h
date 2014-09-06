//
//  iPhProgramContactViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPProgramContactViewController.h"
#import <MessageUI/MessageUI.h>


@class Program, iPhMapPanView;
@interface iPhProgramContactViewController : JPProgramContactViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
{
    iPhMapPanView*   _mapPanView;
    
    CGFloat   _imageViewYBeforePan;
        
        
    MFMailComposeViewController* _mailController;

}



@property (nonatomic, strong) UITableView* tableView;





@end
