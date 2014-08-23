//
//  iPhMainTabBarController.m
//  Uniq
//
//  Created by Si Te Feng on 8/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhMainTabBarController.h"
#import "JPFont.h"
#import "JPStyle.h"
#import "UserInterfaceConstants.h"
#import "HNScrollView.h"


@interface iPhMainTabBarController ()

@end

@implementation iPhMainTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kiPhoneWidthPortrait, kiPhoneHeightPortrait)];
    whiteView.backgroundColor = [JPStyle colorWithHex:@"E2E2E2" alpha:1];
    
    imageScrollView = [[HNScrollView alloc] initWithFrame:CGRectMake(0,0,whiteView.frame.size.width, whiteView.frame.size.height)];
    imageScrollView.showsHorizontalScrollIndicator = NO;
    imageScrollView.showsVerticalScrollIndicator = NO;
    imageScrollView.delegate = self;
    imageScrollView.pagingEnabled = YES;
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(50, kiPhoneHeightPortrait-100, kiPhoneWidthPortrait-100, 5)];
    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [JPStyle interfaceTintColor];
    pageControl.alpha = 0;
    [whiteView addSubview:pageControl];
    
    actionButton = [[UIButton alloc] initWithFrame:CGRectMake(100, kiPhoneHeightPortrait- 80, kiPhoneWidthPortrait-200, 44)];
    [actionButton setTitleColor:[JPStyle interfaceTintColor] forState:UIControlStateNormal];
    [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [actionButton setTitle:@"Start!" forState:UIControlStateNormal];
    actionButton.titleLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:24];
    actionButton.hidden = YES;
    [actionButton addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:actionButton];
    
    ///////////////////////////////////////////////////////
    //Page 1
    logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 60, kiPhoneWidthPortrait-120, kiPhoneWidthPortrait-120)];
    logoImageView.image = [UIImage imageNamed:@"appIcon-1024"];
    logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    logoImageView.layer.cornerRadius = 25;
    logoImageView.layer.masksToBounds = YES;
    [imageScrollView addSubview:logoImageView];
    
    logoShadowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, whiteView.frame.size.width, whiteView.frame.size.height)];
    logoShadowView.image = [UIImage imageNamed:@"entranceBackground-100"];
    logoShadowView.contentMode = UIViewContentModeScaleAspectFit;
    logoShadowView.alpha = 0.8;
    [whiteView addSubview:logoShadowView];
    
    
    appTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 280, kiPhoneWidthPortrait-20, 60)];
    appTitle.font = [UIFont fontWithName:[JPFont defaultMediumFont] size:55];
    appTitle.textColor = [UIColor blackColor];
    appTitle.text = @"Uniq";
    appTitle.textAlignment = NSTextAlignmentCenter;
    appTitle.alpha = 0;
    [imageScrollView addSubview:appTitle];
    
    appSubtitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 350, kiPhoneWidthPortrait-20, 20)];
    appSubtitle.font = [UIFont fontWithName:[JPFont defaultThinFont] size:18];
    appSubtitle.textAlignment = NSTextAlignmentCenter;
    appSubtitle.textColor = [UIColor blackColor];
    appSubtitle.text = @"College Info Reimagined";
    appSubtitle.alpha = 0;
    [imageScrollView addSubview:appSubtitle];

    
    
    ///////////////////////////////////////
    //Pages 2-4
    CGFloat currXPos = kiPhoneWidthPortrait;
    
    NSArray*   imageNames = @[@"entranceImg2", @"entranceImg3", @"entranceImg5"];
    NSArray*   descriptions = @[@"Exploring the information you need has never been so simple and elegant", @"Experience personalized info tailored to you", @"Let’s get started!"];
    
    for(int i= 1; i<=3; i++)
    {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*currXPos + 30, 45, kiPhoneWidthPortrait-60, kiPhoneWidthPortrait-60)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:imageNames[i-1]];
        [imageScrollView addSubview:imageView];
        
        UILabel* descriptionView = [[UILabel alloc] initWithFrame:CGRectMake(i*currXPos + 30, 340, kiPhoneWidthPortrait-60, 80)];
        descriptionView.font = [UIFont fontWithName:[JPFont defaultThinFont] size:18];
        descriptionView.textAlignment = NSTextAlignmentCenter;
        descriptionView.numberOfLines = 4;
        descriptionView.text = descriptions[i-1];
        [imageScrollView addSubview:descriptionView];
        
    }
    
    [whiteView sendSubviewToBack:logoShadowView];
    imageScrollView.contentSize = CGSizeMake(kiPhoneWidthPortrait*(1+[descriptions count]), kiPhoneHeightPortrait);
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
    pageControl.currentPage = (NSUInteger)scrollView.contentOffset.x/ kiPhoneWidthPortrait;
    
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
