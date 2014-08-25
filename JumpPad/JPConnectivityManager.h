//
//  HNDataManager.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/5/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

static NSString* const kNeedUpdateDataNotification = @"kNeedUpdateDataNotification";


@interface JPConnectivityManager : NSObject
{
    BOOL   _alertDisplayed;
    AFNetworkReachabilityManager* reachability;
}


@property (nonatomic) BOOL shouldDisplayAlert;

//Networking
- (void)startUpdating;
- (void)stopUpdating;





@end


