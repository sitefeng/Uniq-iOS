//
//  iPadMainFeaturedViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 12/5/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "iPadMainFeaturedViewController.h"
#import "iPadDashletScrollView.h"
#import "JPDashlet.h"

@interface iPadMainFeaturedViewController ()

@property (nonatomic, strong) NSMutableArray *players;

@end

@implementation iPadMainFeaturedViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [JPStyle mainViewControllerDefaultBackgroundColor];
    
    iPadDashletScrollView* scrollView = [[iPadDashletScrollView alloc] initWithFrame:CGRectZero];

    
    scrollView.delegate = self;
    scrollView.dataSource = self;
    [scrollView loadDashlets];
    
    [scrollView setFrame: CGRectMake(0, kiPadTopBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - kiPadTopBarHeight - kiPadTabBarHeight)];
    
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:jps(scrollView.frame.size.width, 2000)];
    
    [self.view addSubview:scrollView];
    
    
}

- (JPDashlet*)dashletScrollView:(iPadDashletScrollView *)scrollView dashletAtIndexPath:(NSIndexPath *)path
{
    JPDashlet* dashlet = [[JPDashlet alloc] initWithItemUID:@"0001-001-001"];
    return dashlet;
}


- (NSUInteger)dashletScrollView:(iPadDashletScrollView *)scrollView numberOfDashletsInSection:(NSUInteger)section
{
    return 9;
    
}

- (NSUInteger) numberOfSectionsInDashletScrollView:(iPadDashletScrollView *)scrollView
{
    return 1;
}


                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        







@end
