//
//  HNDataManager.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/5/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNConnectivityManager.h"
#import "AFNetworkReachabilityManager.h"
#import "SVStatusHUD.h"


@implementation HNConnectivityManager

- (instancetype)init
{
    self = [super init];
    
    return self;
}



- (void)startUpdating
{
    reachability = [AFNetworkReachabilityManager sharedManager];
    [reachability startMonitoring];
    BOOL reach =   [reachability isReachable];
    NSLog(@"Reachability: %d", reach);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}


- (void)stopUpdating
{
    [reachability stopMonitoring];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)networkStatusChanged: (NSNotification*)notification
{
    NSDictionary* userInfo = notification.userInfo;
    
    NSNumber* value = [userInfo objectForKey:AFNetworkingReachabilityNotificationStatusItem];
    
    if([value integerValue] == AFNetworkReachabilityStatusReachableViaWiFi || [value integerValue] == AFNetworkReachabilityStatusReachableViaWWAN)
    {
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"wifi"] status:@"Connected"];
        NSLog(@"Reachable");
    }
    else
    {
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"noWifi"] status:@"Offline Mode"];
        NSLog(@"Not Reachable");
    }
    
}










@end
