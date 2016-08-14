//
//  JPProgramContactViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/19/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class School, Faculty, Program, JPLocation, SchoolLocation, Contact, JPContact;
@interface JPProgramContactViewController : UIViewController
{
    @protected
    JPDashletType   _itemType;
}



@property (nonatomic, assign) double distanceToHome;
@property (nonatomic, strong) JPLocation* location;
@property (nonatomic, strong) JPContact* contactInfo;
@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) School* school;
@property (nonatomic, strong) Faculty* faculty;
@property (nonatomic, strong) Program* program;


- (id)initWithProgram: (Program*)program;
- (id)initWithSchool:(School *)school;
- (id)initWithFaculty: (Faculty *)faculty;

- (void)reloadViews;
- (NSArray*)getInformationArrayOfType: (NSString*)arrayType;


@end
