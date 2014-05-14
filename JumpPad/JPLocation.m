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
-(instancetype)initWithCooridinates: (CGPoint)coord city: (NSString*)city province:(NSString *)province
{
    self = [self init];
    
    self.coordinates = coord;
    self.cityName = city;
    self.provinceName = province;
    
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

//Inaccurate: Only for Testing and Convenience purposes
+ (CGPoint)coordinatesForCity: (NSString*)city
{
    CGPoint c;
    
    if([city caseInsensitiveCompare:@"toronto"] == NSOrderedSame)
    {
        c = jpp(43.658092,-79.380598);
    }
    else if([city caseInsensitiveCompare:@"waterloo"] == NSOrderedSame)
    {
        c= jpp(43.656877,-79.32085);
    }
    else if([city caseInsensitiveCompare:@"london"] == NSOrderedSame)
    {
        c= jpp(43.472285,-80.544858);
    }
    else if([city caseInsensitiveCompare:@"hamilton"] == NSOrderedSame)
    {
        c= jpp(43.006145,-81.269537);
    }
    else if([city caseInsensitiveCompare:@"ottawa"] == NSOrderedSame)
    {
        c= jpp(43.260879,-79.919225);//carleton
    }
    else if([city caseInsensitiveCompare:@"kingston"] == NSOrderedSame)
    {
        c= jpp(45.385956,-75.695396);//queens
    }
    else
    {
        c= jpp(45.000000,-77.000000);//random
    }
        
    return c;
}


- (double)distanceToLocation: (JPLocation*)destination
{
    return [JPLocation distanceBetweenLocationOne:self.coordinates andLocationTwo:destination.coordinates];
}


- (double)distanceToCoordinate: (CGPoint)destination
{
    return [JPLocation distanceBetweenLocationOne:self.coordinates andLocationTwo:destination];
}


+ (double)distanceBetweenLocationOne: (CGPoint)p1 andLocationTwo: (CGPoint)p2
{
    //ex: jpp(43.658092,-79.380598)
    /*  To Calculate the distance between two locations,
     use the Haversine formula:
     a = sin²(Δφ/2) + cos(φ1).cos(φ2).sin²(Δλ/2)
     c = 2.atan2(√a, √(1−a))
     d = R.c
     
     where	φ is latitude, λ is longitude, R is earth’s radius (mean radius = 6,371km)
     note that angles need to be in radians to pass to trig functions!
     
     Source: http://www.movable-type.co.uk/scripts/latlong.html
     */
    
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


- (NSString*)description
{
    return [NSString stringWithFormat:@"City:%@[%f,%f]",self.cityName,self.coordinates.x, self.coordinates.y];
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    JPLocation* location = [[JPLocation alloc] init];
    location.countryName = [self.countryName copyWithZone:zone];
    location.cityName = [self.cityName copyWithZone:zone];
    location.coordinates = self.coordinates;
    
    return location;
}





@end
