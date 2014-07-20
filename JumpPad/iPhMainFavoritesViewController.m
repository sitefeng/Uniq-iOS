//
//  iPhMainFavoritesViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhMainFavoritesViewController.h"
#import "iPhMainTableViewCell.h"
#import "JPBannerView.h"
#import "JPDashlet.h"
#import "iPhProgramViewController.h"

@interface iPhMainFavoritesViewController ()

@end

@implementation iPhMainFavoritesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    context = [(UniqAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    self.bannerView = [[JPBannerView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight, kiPhoneWidthPortrait, 100)];
    [self.view addSubview:self.bannerView];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+100, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait-100) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[iPhMainTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self.view addSubview:self.tableView];
    
    _isEditing = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section== JPDashletTypeSchool)
    {
        return @"FAVORITE SCHOOLS";
    } else if(section == JPDashletTypeFaculty)
    {
        return @"FAVORITE FACULTIES";
    }
    else
        return @"FAVORITE PROGRAMS";
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count: %@", self.dashlets[section]);
    return [self.dashlets[section] count];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    iPhMainTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    cell.dashletInfo = self.dashlets[indexPath.section][indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 81;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    iPhMainTableViewCell* cell = (iPhMainTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    JPDashlet* dashlet = cell.dashletInfo;
    
    [self favButtonPressedIsFavorited:NO dashletUid:dashlet.dashletUid];
    [self removeUnselectedFavoritesFromCoreData];
    
    [self.tableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    iPhMainTableViewCell* cell = (iPhMainTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    JPDashlet* dashlet = cell.dashletInfo;
    iPhProgramViewController* programController = [[iPhProgramViewController alloc] initWithDashletUid:dashlet.dashletUid];
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:programController];
    
    [self presentViewController:navController animated:YES completion:nil];
    
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
