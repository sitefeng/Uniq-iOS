//
//  JPLocation.h
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPLocation : NSObject <NSCopying>

@property (nonatomic, retain) NSString* countryName;
@property (nonatomic, retain) NSString* cityName;

@property (nonatomic, assign) CGPoint coordinates;




- (instancetype)initWithCooridinates: (CGPoint)coord city: (NSString*)city;

- (BOOL)isEqual: (JPLocation*) location;

+ (CGPoint)coordinatesForCity: (NSString*)city;

- (double)distanceToLocation: (JPLocation*)destination;

- (double)distanceToCoordinate: (CGPoint)destination;

+ (double)distanceBetweenLocationOne: (CGPoint)p1 andLocationTwo: (CGPoint)p2;

@end
