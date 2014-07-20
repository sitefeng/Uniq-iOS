//
//  iPhProgramContactViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPProgramContactViewController.h"


@class Program, iPhMapPanView;
@interface iPhProgramContactViewController : JPProgramContactViewController <UITableViewDataSource, UITableViewDelegate>
{
    iPhMapPanView*   _mapPanView;
    
    CGFloat   _imageViewYBeforePan;
        
        
    

}



@property (nonatomic, strong) UITableView* tableView;





@end
