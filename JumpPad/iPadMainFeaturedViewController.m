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
#import "iPadBannerView.h"
#import "iPadFilterBarView.h"

@interface iPadMainFeaturedViewController ()

@property (nonatomic, strong) NSMutableArray *players;

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

    //Creating all subviews without a size
    self.bannerView = [[iPadBannerView alloc] initWithFrame:CGRectZero];
    self.filterBarView = [[iPadFilterBarView alloc] initWithFrame:CGRectZero];
    self.dashletScrollView = [[iPadDashletScrollView alloc] initWithFrame:CGRectZero];
    
    //Giving the dashletScrollView where to get the dashlet info, and then load data
    self.dashletScrollView.delegate = self;
    self.dashletScrollView.dataSource = self;
    [self.dashletScrollView loadDashlets];
    
    [self.dashletScrollView setScrollEnabled:YES];
    
    //Add all subviews
    [self.view addSubview:self.dashletScrollView];
    [self.view addSubview:self.filterBarView];
    [self.view addSubview:self.bannerView];
    
    //Display all subviews
    [self resizeFrames];
}


#pragma mark - Dashlet Scroll View Delegate

- (JPDashlet*)dashletScrollView:(iPadDashletScrollView *)scrollView dashletAtIndexPath:(NSIndexPath *)path
{
    JPDashlet* dashlet = [[JPDashlet alloc] initWithItemUID:@"0001-001-001"];
    return dashlet;
}


- (NSUInteger)dashletScrollView:(iPadDashletScrollView *)scrollView numberOfDashletsInSection:(NSUInteger)section
{
    return 87;
}


- (NSUInteger) numberOfSectionsInDashletScrollView:(iPadDashletScrollView *)scrollView
{
    return 1;
}


#pragma mark - Handle View Frame Change

//when device rotated, resize all subviews
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
        _isOrientationPortrait = NO;
    }
    else if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation))
    {
        _isOrientationPortrait = YES;
    }

    [self resizeFrames];
}


//when device orientation changed and view just loaded, change dashlet frames for CGRectZero to a neat layout
- (void)resizeFrames
{
    float bannerHeight=0, width=0, height=0;
    
    //using orientation iVar to track which orientation will the frame set for
    if(_isOrientationPortrait)
    {
        bannerHeight = kiPadSizeMainBannerPortrait.height;
        width = kiPadWidthPortrait;
        height = kiPadHeightPortrait;
    }
    else
    {
        bannerHeight = kiPadSizeMainBannerLandscape.height;
        width = kiPadWidthLandscape;
        height = kiPadHeightLandscape;
    }
    
    //Setting all the frames according to device size
    [self.bannerView setFrame: jpr(0, kiPadTopBarHeight, width, bannerHeight)];
    [self.filterBarView setFrame: jpr(0, kiPadTopBarHeight + bannerHeight, width, kiPadSearchBarHeight)];
    [self.dashletScrollView setFrame: jpr(0, bannerHeight + kiPadFilterBarHeight + kiPadTopBarHeight, width, height - bannerHeight - kiPadSearchBarHeight - kiPadTopBarHeight - kiPadTabBarHeight)];
}
                                        
                                        
                                        







@end
