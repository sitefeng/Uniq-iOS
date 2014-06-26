//
//  iPadMainHomeViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

//#import <CoreLocation/CoreLocation.h>

#import "iPadMainHomeViewController.h"

#import "JPFont.h"
#import "JPStyle.h"

#import "Uniq-Swift.h"
#import "UniqAppDelegate.h"

#import "iPadHomeMarkTableViewCell.h"


@interface iPadMainHomeViewController ()




@end

NSString* const reuseIdentifier = @"reuseIdentifier";

@implementation iPadMainHomeViewController


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.profileBanner = [[iPadHomeProfileBanner alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, kiPadWidthPortrait, 300)];
    self.profileBanner.clipsToBounds = YES;
    self.profileBanner.userImage = [UIImage imageNamed:@"profileIcon"];
    
    self.profileBanner.userNameLabel.text = @"Peter Parker";
    self.profileBanner.userLocationLabel.text = @"San Francisco";
    self.profileBanner.userAverage = 91.3f;
    self.profileBanner.homeViewController = self;
    [self.view addSubview:self.profileBanner];
    
    
    //Settings Button
    UIButton* settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(kiPadWidthPortrait - 55, CGRectGetMaxY(self.profileBanner.frame)-55,  44,  44)];
    
    [settingsButton setImage:[UIImage imageNamed:@"settingsIcon"] forState:UIControlStateNormal];
    [settingsButton setImage:[[UIImage imageNamed:@"settingsIcon"] imageWithAlpha:0.5] forState:UIControlStateHighlighted];
    [settingsButton addTarget:self action:@selector(settingsButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingsButton];
    

    //tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.profileBanner.frame), kiPadWidthPortrait, kiPadHeightPortrait - CGRectGetMaxY(self.profileBanner.frame)-kiPadTabBarHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[iPadHomeMarkTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    
    [self.view addSubview:self.tableView];
    
}



- (void)settingsButtonTapped: (UIButton*)button
{
    iPadSettingsSplitViewController* settingsVC = [[iPadSettingsSplitViewController alloc] initWithNibName:nil bundle:nil];
    
    UniqAppDelegate* app = (UniqAppDelegate*)[[UIApplication sharedApplication] delegate];
    UIViewController* currentController = app.window.rootViewController;
    
    settingsVC.originalTabBarController = (UITabBarController*)currentController;
    
    app.window.rootViewController = settingsVC;
    app.window.rootViewController = currentController;

    [UIView transitionWithView:self.navigationController.view.window duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        app.window.rootViewController = settingsVC;
    } completion:nil];
    
    
}




- (void)locationButtonPressed: (UIButton*)button
{
    NSLog(@"Pressed");
    
}



#pragma mark - Table View DataSource and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    iPadHomeMarkTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier: reuseIdentifier];
    
    if(!cell)
    {
        cell = [[iPadHomeMarkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    return cell;
    
    
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section ==0)
    {
        return @"Courses Taking";
    }
    else if(section ==1)
    {
        return @"SAT Scores";
    }
    
    return @"";
}


- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{

    if(section==0)
    {
        return @"Only for senior level courses with course code recognized by the college/university";
    }
    else if(section ==1)
    {
        return @"Fill out this information if you have taken the test";
    }

    return @"";
    
}









#pragma mark - location services
//- (void)startStandardUpdates
//{
//    // Create the location manager if this object does not
//    // already have one.
//    if (nil == locationManager)
//        locationManager = [[CLLocationManager alloc] init];
//
//        locationManager.delegate = self;
//        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
//
//        // Set a movement threshold for new events.
//        locationManager.distanceFilter = 500; // meters
//
//        [locationManager startUpdatingLocation];
//}


// Delegate method from the CLLocationManagerDelegate protocol.
//- (void)locationManager:(CLLocationManager *)manager
//didUpdateLocations:(NSArray *)locations {
//    // If it's a relatively recent event, turn off updates to save power.
//    CLLocation* location = [locations lastObject];
//    NSDate* eventDate = location.timestamp;
//    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
//    if (abs(howRecent) < 15.0) {
//        // If the event is recent, do something with it.
//        NSLog(@"latitude %+.6f, longitude %+.6f\n",
//              location.coordinate.latitude,
//              location.coordinate.longitude);
//    }
//}
- (IBAction)EditButtonPressed:(id)sender {
}
@end
