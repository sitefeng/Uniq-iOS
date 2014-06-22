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


@interface iPadMainHomeViewController ()




@end

@implementation iPadMainHomeViewController


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.profileBanner = [[iPadHomeProfileBanner alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, kiPadWidthPortrait, 300)];
    self.profileBanner.clipsToBounds = YES;
    self.profileBanner.userImage = [UIImage imageNamed:@"profileIcon"];
    
    self.profileBanner.userNameLabel.text = @"Perter Pan";
    self.profileBanner.userHighschoolLabel.text = @"Sir John A MacDonald High School";
    self.profileBanner.userLocationLabel.text = @"San Francisco";
    
    [self.view addSubview:self.profileBanner];
    
    

    self.toolbar = [[iPadHomeToolbarView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight+ self.profileBanner.frame.size.height, kiPadWidthPortrait, 50)];
    
    self.toolbar.delegate = self;
    
    [self.view addSubview:self.toolbar];
    
    
    
    
    
}



- (void)settingsButtonTapped: (UIButton*)button
{
    iPadSettingsSplitViewController* settingsVC = [[iPadSettingsSplitViewController alloc] initWithNibName:nil bundle:nil];
    
    UniqAppDelegate* app = (UniqAppDelegate*)[[UIApplication sharedApplication] delegate];
    UIViewController* currentController = app.window.rootViewController;
    
    settingsVC.originalTabBarController = (UITabBarController*)currentController;
    
    app.window.rootViewController = settingsVC;
    app.window.rootViewController = currentController;

    [UIView transitionWithView:self.navigationController.view.window duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        app.window.rootViewController = settingsVC;
    } completion:nil];
    
    
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
@end
