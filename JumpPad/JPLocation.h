//
//  JPLocation.h
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPLocation : NSObject

@property (nonatomic, assign) NSString* countryName;
@property (nonatomic, assign) NSString* cityName;

@property (nonatomic, assign) CGPoint coordinates;
//ex: ccp(43.658092,-79.380598)
/*  To Calculate the distance between two locations,
 use the Haversine formula:
 a = sin²(Δφ/2) + cos(φ1).cos(φ2).sin²(Δλ/2)
 c = 2.atan2(√a, √(1−a))
 d = R.c
 
 where	φ is latitude, λ is longitude, R is earth’s radius (mean radius = 6,371km)
 note that angles need to be in radians to pass to trig functions!
 
 Source: http://www.movable-type.co.uk/scripts/latlong.html
 */



- (instancetype)initWithCooridinates: (CGPoint)coord city: (NSString*)city country: (NSString*)country;

- (BOOL)isEqual: (JPLocation*) location;

+ (CGPoint)coordinatesForCity: (NSString*)city;

- (double)distanceToLocation: (JPLocation*)destination;

- (double)distanceToCoordinate: (CGPoint)destination;

+ (double)distanceBetweenLocationOne: (CGPoint)p1 andLocationTwo: (CGPoint)p2;

@end
