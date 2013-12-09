//
//  iPadMainFeaturedViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 12/5/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "iPadMainFeaturedViewController.h"
#import "iPadDashletScrollView.h"

@interface iPadMainFeaturedViewController ()

@property (nonatomic, strong) NSMutableArray *players;

@end

@implementation iPadMainFeaturedViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [JPStyle mainViewControllerDefaultBackgroundColor];
    
    iPadDashletScrollView* scrollView = [[iPadDashletScrollView alloc] initWithFrame:CGRectZero];
    
    [scrollView setFrame: CGRectMake(0, kiPadTopBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - kiPadTopBarHeight - kiPadTabBarHeight)];
    
    
    [self.view addSubview:scrollView];
    
    
}









                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        







@end
