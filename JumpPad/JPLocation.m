//
//  JPLocation.m
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "JPLocation.h"

@implementation JPLocation

//Designated Initializer
-(instancetype)initWithCooridinates: (CGPoint)coord city: (NSString*)city country: (NSString*)country
{
    self = [self init];
    
    self.coordinates = coord;
    self.cityName = city;
    self.countryName = country;
    
    return self;
    
}


- (BOOL)isEqual: (JPLocation*) location
{
    //Two locations considered equal when cityName or the actual coordinates matches
    //A city is represented as one exact coordinate
    if([self.cityName caseInsensitiveCompare:location.cityName]==NSOrderedSame   ||
       (self.coordinates.x == location.coordinates.x && self.coordinates.y == location.coordinates.y))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}


+ (CGPoint)coordinatesForCity: (NSString*)city
{
    
    CGPoint c;
    
    if([city caseInsensitiveCompare:@"toronto"] == NSOrderedSame)
    {
        c = jpp(43.658092,-79.380598);
    }
    
    
    return c;
    
}



- (double)distanceToLocation: (JPLocation*)destination
{
    
    double lat1 = 0;
    double lon1 = 0;
    
    if(self.coordinates.x != 0 && self.coordinates.y != 0)
    {
        lat1 = self.coordinates.x;
        lon1 = self.coordinates.y;
    }
    else if(self.cityName != nil)
    {
        lat1 = [JPLocation coordinatesForCity:self.cityName].x;
        lon1 = [JPLocation coordinatesForCity:self.cityName].y;
    }
    
    double lat2 = destination.coordinates.x;
    double lon2 = destination.coordinates.y;
    
    double R = 6371;
    double dLat = (lat2-lat1)/180.0*M_PI;
    double dLon = (lon2-lon1)/180.0*M_PI;
    
    lat1 = lat1/180.0*M_PI;
    lat2 = lat2/180.0*M_PI;
    
    double a = sin(dLat/2) * sin(dLat/2) + sin(dLon/2) * sin(dLon/2) * cos(lat1) * cos(lat2);
    
    double c = 2 * atan2(sqrt(a), sqrt(1-a));
    
    double distance = R * c;
    
    return distance;
    
}



- (double)distanceToCoordinate: (CGPoint)destination
{
    double lat1 = 0;
    double lon1 = 0;
    
    if(self.coordinates.x != 0 && self.coordinates.y != 0)
    {
        lat1 = self.coordinates.x;
        lon1 = self.coordinates.y;
    }
    else if(self.cityName != nil)
    {
        lat1 = [JPLocation coordinatesForCity:self.cityName].x;
        lon1 = [JPLocation coordinatesForCity:self.cityName].y;
    }
    
    double lat2 = destination.x;
    double lon2 = destination.y;
    
    double R = 6371;
    double dLat = (lat2-lat1)/180.0*M_PI;
    double dLon = (lon2-lon1)/180.0*M_PI;
    
    lat1 = lat1/180.0*M_PI;
    lat2 = lat2/180.0*M_PI;
    
    double a = sin(dLat/2) * sin(dLat/2) + sin(dLon/2) * sin(dLon/2) * cos(lat1) * cos(lat2);
    double c = 2 * atan2(sqrt(a), sqrt(1-a));
    double distance = R * c;
    return distance;
}


+ (double)distanceBetweenLocationOne: (CGPoint)p1 andLocationTwo: (CGPoint)p2
{
    double lat1 = p1.x;
    double lon1 = p1.y;
    double lat2 = p2.x;
    double lon2 = p2.y;
    
    double R = 6371;
    double dLat = (lat2-lat1)/180.0*M_PI;
    double dLon = (lon2-lon1)/180.0*M_PI;
    
    lat1 = lat1/180.0*M_PI;
    lat2 = lat2/180.0*M_PI;
    
    double a = sin(dLat/2) * sin(dLat/2) + sin(dLon/2) * sin(dLon/2) * cos(lat1) * cos(lat2);
    
    double c = 2 * atan2(sqrt(a), sqrt(1-a));
    
    double distance = R * c;
    
    return distance;
}




@end
