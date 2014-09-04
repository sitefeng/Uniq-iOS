//
//  SchoolLocation.h
//  Uniq
//
//  Created by Si Te Feng on 9/4/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Faculty, Program, School;

@interface SchoolLocation : NSManagedObject

@property (nonatomic, retain) NSString * apt;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * postalCode;
@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) NSString * streetName;
@property (nonatomic, retain) NSString * streetNum;
@property (nonatomic, retain) NSString * unit;
@property (nonatomic, retain) Faculty *faculty;
@property (nonatomic, retain) Program *program;
@property (nonatomic, retain) School *school;

@end
