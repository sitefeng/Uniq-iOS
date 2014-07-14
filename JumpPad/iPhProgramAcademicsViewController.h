//
//  iPhProgramAcademicsViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPhProgramAbstractViewController.h"
#import "iPhProgramDetailView.h"

@class Program, iPhAppProgressPanView;
@interface iPhProgramAcademicsViewController : iPhProgramAbstractViewController<JPCoursesDetailViewDelegate>
{
    iPhAppProgressPanView* _progressPanView;
    
    UIScrollView*          _detailView;
}




- (instancetype)initWithProgram: (Program*)program;







@end
