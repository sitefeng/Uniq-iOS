//
//  iPhMainExploreViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/10/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhMainExploreViewController.h"

#import "JPBannerView.h"
#import "School.h"
#import "JPDashlet.h"
#import "iPhMainTableViewCell.h"
#import "iPhFacProgSelectViewController.h"
#import "iPhSchoolHomeViewController.h"
#import "AsyncImageView.h"
#import "iPadDashletImageView.h"
#import "JPStyle.h"


@interface iPhMainExploreViewController ()


@end

@implementation iPhMainExploreViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [JPStyle defaultBackgroundGray];
    
    [UIApplication sharedApplication].statusBarHidden = false;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _indexPathsNeedReloading = [NSMutableArray array];

    CGFloat bannerHeight = 100.0f;
    CGFloat viewWidth = self.view.frame.size.width;
    
    self.bannerView = [[JPBannerView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight, viewWidth, bannerHeight)];
    [self.view addSubview:self.bannerView];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bannerView.frame), viewWidth, kiPhoneContentHeightWithHeight([UIScreen mainScreen].bounds.size.height) - bannerHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [JPStyle transluscentWhite];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[iPhMainTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self.view addSubview:self.tableView];
}


#pragma mark - UITable View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dashlets count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    iPhMainTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    cell.separatorInset = UIEdgeInsetsZero;
    
    JPDashlet* dashlet = self.dashlets[indexPath.row];

    cell.delegate = self;
    cell.dashletInfo = dashlet;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 81;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JPDashlet* selectedDashlet = self.dashlets[indexPath.row];
    
    iPhFacProgSelectViewController* selectViewController = [[iPhFacProgSelectViewController alloc] initWithItemId:selectedDashlet.itemId schoolSlug:selectedDashlet.schoolSlug facultySlug:nil forSelectionType:JPDashletTypeSchool];
    
    selectViewController.title = selectedDashlet.title;
    
    [self.navigationController pushViewController:selectViewController animated:YES];
    
}

#pragma mark - Image Loaded
- (void)imageLoaded
{
    [self.tableView reloadRowsAtIndexPaths:_indexPathsNeedReloading withRowAnimation:UITableViewRowAnimationFade];
    
    [_indexPathsNeedReloading removeAllObjects];
}



- (void)setDashlets:(NSMutableArray *)dashlets
{
    super.dashlets = dashlets;
    
    [self.tableView reloadData];
    
}









- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [AsyncImageLoader sharedLoader].cache = nil;
}








@end
