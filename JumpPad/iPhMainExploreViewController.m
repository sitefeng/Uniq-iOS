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


@interface iPhMainExploreViewController ()

@end

@implementation iPhMainExploreViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.bannerView = [[JPBannerView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight, kiPhoneWidthPortrait, 100)];
    [self.view addSubview:self.bannerView];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bannerView.frame), kiPhoneWidthPortrait, kiPhoneHeightPortrait- kiPhoneStatusBarHeight-kiPhoneNavigationBarHeight - kiPhoneTabBarHeight) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[iPhMainTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    
    cell.delegate = self;
    cell.dashletInfo = self.dashlets[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 81;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JPDashlet* selectedDashlet = self.dashlets[indexPath.row];
    
    iPhFacProgSelectViewController* selectViewController = [[iPhFacProgSelectViewController alloc] initWithDashletUid:selectedDashlet.dashletUid forSelectionType:JPDashletTypeFaculty];
    selectViewController.title = selectedDashlet.title;
    
    [self.navigationController pushViewController:selectViewController animated:YES];
    
}





- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
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
