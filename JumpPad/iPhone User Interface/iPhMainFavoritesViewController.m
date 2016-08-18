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
#import "iPhSchoolViewController.h"

@interface iPhMainFavoritesViewController ()

@end

@implementation iPhMainFavoritesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    context = [(UniqAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    CGFloat bannerViewHeight = 100.0f;
    self.bannerView = [[JPBannerView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight, self.view.frame.size.width, bannerViewHeight)];
    [self.view addSubview:self.bannerView];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight + bannerViewHeight, self.view.frame.size.width, kiPhoneContentHeightWithHeight([UIScreen mainScreen].bounds.size.height) - bannerViewHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
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
    iPhMainTableViewCell* cell = [[iPhMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
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
    
    [self favButtonPressedIsFavorited:NO itemId:dashlet.itemId itemType:dashlet.type];
    [self removeUnselectedFavoritesFromCoreData];
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    iPhMainTableViewCell* cell = (iPhMainTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    JPDashlet* dashlet = cell.dashletInfo;
    
    id contentController = nil;
    
    if(dashlet.type == JPDashletTypeProgram)
    {
        contentController = [[iPhProgramViewController alloc] initWithItemId:dashlet.itemId schoolSlug:dashlet.schoolSlug facultySlug:dashlet.facultySlug programSlug:dashlet.programSlug];
        
    } else {
        contentController = [[iPhSchoolViewController alloc] initWithItemId:dashlet.itemId itemType:dashlet.type schoolSlug:dashlet.schoolSlug facultySlug:dashlet.facultySlug];
    }
    
    [contentController setTitle:dashlet.title];
    
    //Mixpanel
    [[Mixpanel sharedInstance] track:@"Favorite Selected"
                          properties:@{@"Device Type": [JPStyle deviceTypeString], @"Cell Dashlet Title": dashlet.title}];
    
    
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:contentController];
    
    [self presentViewController:navController animated:YES completion:nil];
    
}



@end
