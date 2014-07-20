//
//  JPProgramContactViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/19/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class School, Faculty, Program;
@interface JPProgramContactViewController : UIViewController
{
    @protected
    JPDashletType   _itemType;
    Faculty*        _faculty;
}



@property (nonatomic, assign) double distanceToHome;

@property (nonatomic, strong) School* school;
@property (nonatomic, strong) Program* program;


- (id)initWithProgram: (Program*)program;
- (id)initWithSchool:(School *)school;
- (id)initWithFaculty: (Faculty *)faculty;

- (NSArray*)getInformationArrayOfType: (NSString*)arrayType;


@end
