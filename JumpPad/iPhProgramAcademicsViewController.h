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

@class Program, iPhAppProgressPanView;
@interface iPhProgramAcademicsViewController : iPhProgramSchoolAbstractViewController<JPCoursesDetailViewDelegate, JPAppProgressPanDelegate>
{
    
    UIScrollView*          _detailView;
}


@property (nonatomic, strong)iPhAppProgressPanView* progressPanView;

- (instancetype)initWithProgram: (Program*)program;







@end
