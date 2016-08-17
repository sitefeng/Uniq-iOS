//
//  iPhSchoolHomeViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPhProgramSchoolAbstractViewController.h"
#import "JPSchoolSummaryView.h"
#import "iPhProgramDetailTableView.h"

@class School, Faculty, iPhImagePanView;
@interface iPhSchoolHomeViewController : iPhProgramSchoolAbstractViewController <JPSchoolSummaryDelegate,
    JPProgramDetailTableViewDataSource>


@property (nonatomic, assign) JPDashletType type;

@property (nonatomic, strong) School* school;
@property (nonatomic, strong) Faculty* faculty;


- (instancetype)initWithFaculty: (Faculty*)faculty;
- (instancetype)initWithSchool: (School*)school;


@end
