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


@interface JPDashlet : NSObject

//Item Unique Idenntifier for the exact item
//CCCC-FFF-PPP (College#-Faculty#-Program#), program=0 means the item is a faculty
@property (nonatomic, retain) NSString* itemUID;

@property (nonatomic, assign) JPLocation* location;
//Includes the country, city, and coordinates


@property (nonatomic, retain) NSString* title;
@property (nonatomic, assign) NSUInteger type;
@property (nonatomic, retain) NSArray*  backgroundImages;
@property (nonatomic, retain) NSString* borderColor; //in Hex value

//For dashlet grid detail view
@property (nonatomic, retain) NSDictionary* details;

//Not Applicable to Faculties and Programs
@property (nonatomic, retain) id icon;




- (instancetype)initWithItemUID: (NSString*)uid;




@end
