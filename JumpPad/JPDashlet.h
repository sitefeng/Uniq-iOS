//
//  JPDashlet.h
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPLocation.h"



@class School, Faculty, Program;


@interface JPDashlet : NSObject <NSCopying>

//Item Unique Idenntifier for the exact item

@property (nonatomic, assign) NSInteger dashletUid;



@property (nonatomic, strong) NSString* title;
@property (nonatomic, assign) JPDashletType type;

@property (nonatomic, strong) NSMutableArray*  backgroundImages;
                             //Array of NSURLs


//For dashlet grid detail view
@property (nonatomic, strong) NSNumber* yearEstablished;
@property (nonatomic, strong) NSNumber* population;


//******************
//For Schools Only

@property (nonatomic, strong) JPLocation* location;
//Includes the country, city, and coordinates

@property (nonatomic, strong) NSURL* icon;

//******************


- (instancetype)initWithDashletUid: (NSUInteger)uid;

- (instancetype)initWithSchool: (School*)school;
- (instancetype)initWithFaculty: (Faculty*)faculty fromSchool: (NSInteger)schoolDashletId;
- (instancetype)initWithProgram: (Program*)program fromFaculty: (NSInteger)facultyDashletId; //Full ID

- (NSComparisonResult)compareWithName:(JPDashlet *)otherDashlet;

- (NSComparisonResult)compareWithLocation:(JPDashlet *)otherDashlet;
- (NSComparisonResult)compareWithAverage:(JPDashlet *)otherDashlet;
- (NSComparisonResult)compareWithPopulation:(JPDashlet *)otherDashlet;

@end
