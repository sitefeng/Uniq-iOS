//
//  JPUserLocator.m
//  Uniq
//
//  Created by Si Te Feng on 6/27/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPUserLocator.h"
#import "User.h"
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>
#import "DXAlertView.h"
#import "Mixpanel.h"


@implementation JPUserLocator

- (id)initWithUser: (User*)user
{
    self = [super init];
    if(self)
    {
        _user = user;
    }
    
    return self;
}

- (id)init
{
    self = [self initWithUser:nil];
    return self;
}

- (void)startLocating
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 500; // meters
    
    [locationManager startUpdatingLocation];
}


#pragma mark - location services Delegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    
    if(_user && [self.delegate respondsToSelector:@selector(shouldSaveUserLocation)])
    {
        if([self.delegate shouldSaveUserLocation])
        {
            _user.longitude = [NSNumber numberWithFloat:location.coordinate.longitude];
            _user.latitude  = [NSNumber numberWithFloat:location.coordinate.latitude];
        }
    }
    
    //Finding the city and province name
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
    {
        if(error)
        {
            [self showErrorAlert:error];
            return;
        }
        
        CLPlacemark* placeMark = [placemarks firstObject];
        
        NSString* city = @"--";
        NSString* state = @"--";
        
        if(placeMark.addressDictionary)
        {
            NSDictionary* dictionary = placeMark.addressDictionary;
            city = (NSString*)[dictionary objectForKey: (NSString *)kABPersonAddressCityKey];
            state = (NSString*)[dictionary objectForKey:(NSString *)kABPersonAddressStateKey];
            
            NSString* locationString = [NSString stringWithFormat:@"%@, %@", city, state];
            [self.delegate userLocatedWithLocationName:locationString coordinates:placeMark.location.coordinate];
            
            //Mixpanel
            [[Mixpanel sharedInstance] track:@"User Located"
                                  properties:@{@"Device Type": [JPStyle deviceTypeString]}];
            
            //Store In database
            if(_user && [self.delegate respondsToSelector:@selector(shouldSaveUserLocation)])
            {
                if([self.delegate shouldSaveUserLocation])
                {
                    _user.locationString = locationString;
                }
            }
            
        }
        
    }];
    
    [locationManager stopUpdatingLocation];
}


- (void)showErrorAlert: (NSError*)error
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Cannot Find Location" message:@"Cannot determine location, please check internet connection and try again" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                          
    [alert show];
}










@end
