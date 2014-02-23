//
//  iPadMainFeaturedViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 12/5/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "iPadMainFeaturedViewController.h"
#import "JPDashlet.h"
#import "iPadFilterBarView.h"
#import "iPadMainCollectionViewCell.h"


@interface iPadMainFeaturedViewController ()

@end

@implementation iPadMainFeaturedViewController

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Getting current device orientation
    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation))
    {
        _isOrientationPortrait = YES;
    }
    else
    {
        _isOrientationPortrait = NO;
    }
    
    self.view.backgroundColor = [JPStyle mainViewControllerDefaultBackgroundColor];
    
}















@end
