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
    JPDashletTypeCollege,
    JPDashletTypeFaculty,
    JPDashletTypeProgram

} JPDashletType;



@interface JPDashlet : NSObject <NSCopying>

//Item Unique Idenntifier for the exact item
//CCCC-FFF-PPP (College#-Faculty#-Program#), program=0 means the item is a faculty
@property (nonatomic, strong) NSString* itemUID;

@property (nonatomic, strong) JPLocation* location;
//Includes the country, city, and coordinates


@property (nonatomic, strong) NSString* title;
@property (nonatomic, assign) NSUInteger type;
@property (nonatomic, strong) NSMutableArray*  backgroundImages;


//For dashlet grid detail view
@property (nonatomic, strong) NSDictionary* details;

//Not Applicable to Faculties and Programs
@property (nonatomic, strong) UIImage* icon;




- (instancetype)initWithItemUID: (NSString*)uid;

- (NSComparisonResult)compareWithName:(JPDashlet *)otherDashlet;

- (NSComparisonResult)compareWithLocation:(JPDashlet *)otherDashlet;
- (NSComparisonResult)compareWithAverage:(JPDashlet *)otherDashlet;
- (NSComparisonResult)compareWithPopulation:(JPDashlet *)otherDashlet;

@end
