//
//  SchoolLocation.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-11.
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
@property (nonatomic, retain) NSString * province;
@property (nonatomic, retain) NSString * streetName;
@property (nonatomic, retain) NSString * streetNum;
@property (nonatomic, retain) NSNumber * unit;
@property (nonatomic, retain) School *school;

@end
