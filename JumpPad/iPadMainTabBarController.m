//
//  iPadMainTabBarController.m
//  Uniq
//
//  Created by Si Te Feng on 8/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadMainTabBarController.h"
#import "HNScrollView.h"
#import "JPFont.h"
#import "JPStyle.h"
#import "UserInterfaceConstants.h"

@interface iPadMainTabBarController ()

@end

@implementation iPadMainTabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kiPadWidthPortrait, kiPadHeightPortrait)];
    whiteView.backgroundColor = [JPStyle colorWithHex:@"E2E2E2" alpha:1];
    
    imageScrollView = [[HNScrollView alloc] initWithFrame:CGRectMake(0,0,whiteView.frame.size.width, whiteView.frame.size.height)];
    imageScrollView.showsHorizontalScrollIndicator = NO;
    imageScrollView.showsVerticalScrollIndicator = NO;
    imageScrollView.delegate = self;
    imageScrollView.pagingEnabled = YES;
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(50, kiPadHeightPortrait-200, kiPadWidthPortrait-100, 5)];
    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [JPStyle interfaceTintColor];
    pageControl.alpha = 0;
    [whiteView addSubview:pageControl];
    
    actionButton = [[UIButton alloc] initWithFrame:CGRectMake(100, kiPadHeightPortrait- 140, kiPadWidthPortrait-200, 54)];
    [actionButton setTitleColor:[JPStyle interfaceTintColor] forState:UIControlStateNormal];
    [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [actionButton setTitle:@"Start!" forState:UIControlStateNormal];
    actionButton.titleLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:44];
    actionButton.hidden = YES;
    [actionButton addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:actionButton];
    
    ///////////////////////////////////////////////////////
    //Page 1
    logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 150, kiPadWidthPortrait-400, kiPadWidthPortrait-400)];
    logoImageView.image = [UIImage imageNamed:@"appIcon-1024"];
    logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    logoImageView.layer.cornerRadius = 35;
    logoImageView.layer.masksToBounds = YES;
    [imageScrollView addSubview:logoImageView];
    
    logoShadowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, whiteView.frame.size.width, whiteView.frame.size.height)];
    logoShadowView.image = [UIImage imageNamed:@"entranceBackgroundiPad"];
    logoShadowView.contentMode = UIViewContentModeScaleAspectFill;
    logoShadowView.alpha = 0.8;
    [whiteView addSubview:logoShadowView];
    
    
    appTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 580, kiPadWidthPortrait-20, 80)];
    appTitle.font = [UIFont fontWithName:[JPFont defaultMediumFont] size:72];
    appTitle.textColor = [UIColor blackColor];
    appTitle.text = @"Uniq";
    appTitle.textAlignment = NSTextAlignmentCenter;
    appTitle.alpha = 0;
    [imageScrollView addSubview:appTitle];
    
    appSubtitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 670, kiPadWidthPortrait-20, 30)];
    appSubtitle.font = [UIFont fontWithName:[JPFont defaultThinFont] size:25];
    appSubtitle.textAlignment = NSTextAlignmentCenter;
    appSubtitle.textColor = [UIColor blackColor];
    appSubtitle.text = @"College Info Simplified";
    appSubtitle.alpha = 0;
    [imageScrollView addSubview:appSubtitle];
    
    
    
    ///////////////////////////////////////
    //Pages 2-4
    CGFloat currXPos = kiPadWidthPortrait;
    
    NSArray*   imageNames = @[@"entranceImg2", @"entranceImg4", @"entranceImg5"];
    NSArray*   descriptions = @[@"Exploring the information you need has never been so simple and elegant", @"Experience personalized info tailored to you", @"Let’s get started!"];
    
    for(int i= 1; i<=3; i++)
    {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*currXPos + 80, 45, kiPadWidthPortrait-160, kiPadWidthPortrait-160)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:imageNames[i-1]];
        [imageScrollView addSubview:imageView];
        
        
        UILabel* descriptionView = [[UILabel alloc] initWithFrame:CGRectMake(i*currXPos + 80, kiPadHeightPortrait - 330, kiPadWidthPortrait-160, 80)];
        descriptionView.font = [UIFont fontWithName:[JPFont defaultThinFont] size:24];
        descriptionView.textAlignment = NSTextAlignmentCenter;
        descriptionView.numberOfLines = 2;
        descriptionView.text = descriptions[i-1];
        [imageScrollView addSubview:descriptionView];
        
    }
    
    
    [whiteView sendSubviewToBack:logoShadowView];
    imageScrollView.contentSize = CGSizeMake(kiPadWidthPortrait*(1+[descriptions count]), kiPadHeightPortrait);
    [whiteView addSubview:imageScrollView];
    [whiteView bringSubviewToFront:actionButton];
    [whiteView bringSubviewToFront:pageControl];
    [self.view addSubview:whiteView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];

    [UIView animateWithDuration:1.5 animations:^{
        pageControl.alpha = 1;
        appTitle.alpha = 1;
        appSubtitle.alpha = 1;
    }];
    
    [self changeBackgroundAlpha];
}


- (void)actionButtonPressed: (UIButton*)button
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    [UIView animateWithDuration:1 animations:^{
        whiteView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        whiteView.hidden = YES;
        [whiteView removeFromSuperview];
        whiteView = nil;
        [_backgroundAlphaChange invalidate];
        _backgroundAlphaChange = nil;
        
    }];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControl.currentPage = (NSUInteger)scrollView.contentOffset.x/ kiPadWidthPortrait;
    
    if(pageControl.currentPage == 3)
    {
        actionButton.hidden = NO;
    } else {
        actionButton.hidden = YES;
    }
}


- (void)changeBackgroundAlpha
{
    NSTimeInterval timeInterval = ((arc4random()%100)/100.0)*0.8 + 0.5;
    
    [UIView animateWithDuration:timeInterval delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        logoShadowView.alpha = (arc4random()%100/100.0)*0.4 + 0.6;
        
    } completion:nil];
    
    _backgroundAlphaChange = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(changeBackgroundAlpha) userInfo:nil repeats:NO];
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
