//
//  SchoolLocation.h
//  JumpPad
//
//  Created by Si Te Feng on 2/25/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class School;

@interface SchoolLocation : NSManagedObject

@property (nonatomic, retain) NSNumber * apt;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSNumber * lattitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) NSNumber * schoolLocationId;
@property (nonatomic, retain) NSString * streetName;
@property (nonatomic, retain) NSString * streetNum;
@property (nonatomic, retain) NSDate * timeModified;
@property (nonatomic, retain) NSNumber * unit;
@property (nonatomic, retain) School *school;

@end
