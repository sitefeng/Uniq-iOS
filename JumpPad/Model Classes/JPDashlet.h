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
{
    NSManagedObjectContext* context;
}

//Item Unique Idenntifier for the exact item
@property (nonatomic, strong) NSString*  itemId;

@property (nonatomic, strong) NSString* title;
@property (nonatomic, assign) JPDashletType type;


@property (nonatomic, strong) NSMutableArray*  backgroundImages;
                             //Array of NSURLs


//For dashlet detail view elements
@property (nonatomic, strong) NSNumber* population;
@property (nonatomic, strong) JPLocation* location;
//Includes the country, city, and coordinates

//For School Only
//***************************
@property (nonatomic, strong) NSURL* icon;

//******************

//////////////////////////////////////////
//From Core Data
- (instancetype)initWithItemId: (NSString*)itemId withType: (JPDashletType)type;
- (instancetype)initWithSchool: (School*)school;
- (instancetype)initWithFaculty: (Faculty*)faculty;
- (instancetype)initWithProgram: (Program*)program;

////////////////////////////////
//Online
- (instancetype)initWithDictionary: (NSDictionary*)dict ofDashletType: (JPDashletType)type;



- (BOOL)isFavorited;

- (NSComparisonResult)compareWithName:(JPDashlet *)otherDashlet;
- (NSComparisonResult)compareWithLocation:(JPDashlet *)otherDashlet;
- (NSComparisonResult)compareWithAverage:(JPDashlet *)otherDashlet;
- (NSComparisonResult)compareWithPopulation:(JPDashlet *)otherDashlet;

@end
