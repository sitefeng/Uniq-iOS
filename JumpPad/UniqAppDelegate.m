//
//  JumpPadAppDelegate.m
//  JumpPad
//
//  Created by Si Te Feng on 11/30/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "UniqAppDelegate.h"
#import "Mixpanel.h"
#import "JPStyle.h"

#import "JPMainSync.h"
#import "JPConnectivityManager.h"
#import "AFNetworkReachabilityManager.h"
#import <Parse/Parse.h>
#import "JPCoreDataHelper.h"


@implementation UniqAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // To retrieve all URL links and store them into core data
    JPMainSync* syncer = [[JPMainSync alloc] init];
    [syncer sync];
    
    connectivityManager = [JPConnectivityManager sharedManager];
    [connectivityManager startUpdating];
    
    
    ////////////////
    [JPStyle applyGlobalStyle];
    

    ///////////////////////////////////////////////////
    //Adding Mixpanel
    [Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];
    Mixpanel* mixpanel = [Mixpanel sharedInstance];
    
    if (debugMode)
    {
        [mixpanel track:@"App Launches Debug"
             properties:@{@"Device Type": [JPStyle deviceTypeString]}];
    }
    else
    {
        [mixpanel track:@"App Launches"
             properties:@{@"Device Type": [JPStyle deviceTypeString]}];
    }
    ////////////////////////////////////////////////
    ////////////////////////////////////////////////
    
    ////////////////////////////////////////
    //Parse
    [Parse setApplicationId:@"P7owDlPOJQHtrQxoyMUlbHZE6dpNylK9ZggTvOjL"
                  clientKey:@"7qbh1hOkCegxe3QH86ktkxZwISBeDI2cIUUJAJlP"];
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    ///////////////////////////////////////////
    
    //Tab bar change to 3rd element
    UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
    tabBar.selectedIndex = 2;
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    JPCoreDataHelper* coreDataHelper = [[JPCoreDataHelper alloc] init];
    [coreDataHelper deleteAllTemporaryItemsFromCoreData];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [self saveContext];
    
}


#pragma mark - Remote Notifications

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}


- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PFPush handlePush:userInfo];
}





#pragma mark - Save Core Data Context

- (void)saveContext
{
    NSError *error = nil;
    
    NSManagedObjectContext *context = self.managedObjectContext;
    
    if (context != nil)
    {
        if([context hasChanges] && ![context save:&error])
        {
            NSLog(@"<<Unresolved ManagedObjectContext save error: %@, %@>>", error, [error userInfo]);
        }
    }
    
}


#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if(coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managedObjectContext;

}


- (NSManagedObjectModel *)managedObjectModel
{
    
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"JPLocalDatabase" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
    
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if(_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"JPLocalDatabase.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        NSLog(@"Unresolved PersistentStore error: %@, %@",error, [error userInfo]);
    }
    
    return _persistentStoreCoordinator;
    
}


- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
}



- (BOOL)_isReachable
{
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}



@end
