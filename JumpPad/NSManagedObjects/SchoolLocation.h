//
//  SchoolLocation.h
//  Uniq
//
//  Created by Si Te Feng on 2/10/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
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
