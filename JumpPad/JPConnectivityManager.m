//
//  HNDataManager.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/5/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPConnectivityManager.h"
#import "AFNetworkReachabilityManager.h"
#import "SVStatusHUD.h"


@implementation JPConnectivityManager

+ (instancetype)sharedManager
{
    static JPConnectivityManager* _sharedManager = nil;
    
    @synchronized(self)
    {
        if(!_sharedManager)
        {
            _sharedManager = [[JPConnectivityManager alloc] init];
        }
    }
    
    return _sharedManager;

}



- (void)startUpdating
{
    reachability = [AFNetworkReachabilityManager sharedManager];
    [reachability startMonitoring];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    
    _statusTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkNetworkStatus) userInfo:nil repeats:YES];
    
    _stopStatusTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(stopStatusTimer) userInfo:nil repeats:NO];
}

- (void)stopUpdating
{
    [reachability stopMonitoring];
    [_statusTimer invalidate];
    _statusTimer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)checkNetworkStatus
{
    BOOL reach = [reachability isReachable];
    if(reach)
    {
        NSLog(@"Reachable");
        [self postNeedUpdateDataNotification];
        [_statusTimer invalidate];
        _statusTimer = nil;
    }
    else
    {
        NSLog(@"Not Reachable");
    }
}


- (void)stopStatusTimer
{
    [_statusTimer invalidate];
    _statusTimer = nil;
    _stopStatusTimer = nil;
}


#pragma mark - Public Methods

- (BOOL)isReachable
{
    BOOL reach = [reachability isReachable];
    return reach;
}


- (void)networkStatusChanged: (NSNotification*)notification
{
    NSDictionary* userInfo = notification.userInfo;
    
    NSNumber* value = [userInfo objectForKey:AFNetworkingReachabilityNotificationStatusItem];
    
    if([value integerValue] == AFNetworkReachabilityStatusReachableViaWiFi || [value integerValue] == AFNetworkReachabilityStatusReachableViaWWAN)
    {
        [self postNeedUpdateDataNotification];
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"wifi"] status:@"Connected"];
        NSLog(@"Reachable");
    }
    else
    {
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"noWifi"] status:@"Offline Mode"];
        NSLog(@"Not Reachable");

    }
    
}


- (void)postNeedUpdateDataNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNeedUpdateDataNotification object:self];
    
    
}







@end
