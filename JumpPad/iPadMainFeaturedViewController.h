//
//  iPadMainFeaturedViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 12/5/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>


@class JBParallaxCell;

@interface iPadMainFeaturedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    @private
    
    BOOL      _isOrientationPortrait; //or will be portrait for resizing frames

    
}



@property (nonatomic, strong) UITableView* tableView;




@end
