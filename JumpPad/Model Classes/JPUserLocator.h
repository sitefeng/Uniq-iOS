//
//  JPUserLocator.h
//  Uniq
//
//  Created by Si Te Feng on 6/27/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol JPUserLocatorDelegate;
@class User;
@interface JPUserLocator : NSObject<CLLocationManagerDelegate>
{
    User*      _user;
    CLLocationManager* locationManager;
    
}


@property (nonatomic, weak) id<JPUserLocatorDelegate> delegate;

- (id)initWithUser: (User*)user;

- (void)startLocating;


@end



@protocol JPUserLocatorDelegate <NSObject>

@required
- (void)userLocatedWithLocationName: (NSString*)name coordinates:(CLLocationCoordinate2D)coord ;

@optional
- (BOOL)shouldSaveUserLocation;

@end