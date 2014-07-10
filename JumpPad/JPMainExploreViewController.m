//
//  JPMainExploreViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPMainExploreViewController.h"
#import "JPBannerView.h"
#import "UniqAppDelegate.h"
#import "Banner.h"

@interface JPMainExploreViewController ()

@end

@implementation JPMainExploreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Custom initialization
    UniqAppDelegate* del = [[UIApplication sharedApplication] delegate];
    context = [del managedObjectContext];
    
    
    self.banner = [[JPBannerView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight + kiPhoneNavigationBarHeight, kiPhoneWidthPortrait, 100)];
    [self.view addSubview:self.banner];
    
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateBannerView];
    [self.banner activateAutoscroll];
}


- (void)updateBannerView
{
    NSFetchRequest* bannerRequest = [NSFetchRequest fetchRequestWithEntityName:@"Banner"];
    bannerRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"bannerId" ascending:YES]];
    
    NSError* err = nil;
    NSArray* bannerArray = [context executeFetchRequest:bannerRequest error:&err];
    if(err)
        JPLog(@"ERR: %@", err);
    
    _bannerURLs = [NSMutableArray array];
    
    for(Banner* banner in bannerArray)
    {
        NSURL* bannerURL = [NSURL URLWithString:banner.bannerLink];
        [_bannerURLs addObject: bannerURL];
    }
    
    [self.banner setImgArrayURL:_bannerURLs];
    
}




- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.banner pauseAutoscroll];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
