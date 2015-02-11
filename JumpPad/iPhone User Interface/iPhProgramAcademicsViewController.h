//
//  iPhProgramAcademicsViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPhProgramSchoolAbstractViewController.h"
#import "iPhProgramDetailView.h"
#import "iPhAppProgressPanView.h"
#import "iPhProgramDetailTableView.h"

@class Program, iPhAppProgressPanView;
@interface iPhProgramAcademicsViewController : iPhProgramSchoolAbstractViewController<JPCoursesDetailViewDelegate, JPAppProgressPanDelegate, JPProgramDetailTableViewDataSource>
{
    NSArray*   _dashletTitles;
}


@property (nonatomic, strong) iPhAppProgressPanView* progressPanView;


@property (nonatomic, strong) iPhProgramDetailTableView* tableView;

- (instancetype)initWithProgram: (Program*)program;







@end
