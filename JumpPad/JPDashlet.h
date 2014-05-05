//
//  JPDashlet.h
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPLocation.h"

typedef enum
{
    JPDashletTypeSchool,
    JPDashletTypeFaculty,
    JPDashletTypeProgram

} JPDashletType;


@class School;


@interface JPDashlet : NSObject <NSCopying>

//Item Unique Idenntifier for the exact item

@property (nonatomic, assign) NSInteger dashletUid;

@property (nonatomic, strong) JPLocation* location;
//Includes the country, city, and coordinates


@property (nonatomic, strong) NSString* title;
@property (nonatomic, assign) NSUInteger type;
@property (nonatomic, strong) NSMutableArray*  backgroundImages;
                               //Array of NSURLs

//For dashlet grid detail view
@property (nonatomic, strong) NSNumber* yearEstablished;
@property (nonatomic, strong) NSNumber* population;

//Not Applicable to Faculties and Programs
@property (nonatomic, strong) NSURL* icon;




- (instancetype)initWithDashletUid: (NSInteger)uid;
- (instancetype)initWithSchool: (School*)school;

- (NSComparisonResult)compareWithName:(JPDashlet *)otherDashlet;

- (NSComparisonResult)compareWithLocation:(JPDashlet *)otherDashlet;
- (NSComparisonResult)compareWithAverage:(JPDashlet *)otherDashlet;
- (NSComparisonResult)compareWithPopulation:(JPDashlet *)otherDashlet;

@end
