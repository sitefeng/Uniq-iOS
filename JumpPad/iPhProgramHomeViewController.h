//
//  iPhProgramHomeViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPhProgramSchoolAbstractViewController.h"
#import "JPProgramSummaryView.h"


@class Program, iPhImagePanView, iPhProgramDetailView;
@interface iPhProgramHomeViewController : iPhProgramSchoolAbstractViewController <JPProgramSummaryDelegate, MFMailComposeViewControllerDelegate>
{
    iPhImagePanView*  _panImageView;
    
    UIScrollView*  _detailScrollView;
    
    iPhProgramDetailView* _highlighView;
    iPhProgramDetailView* _ratioView;
    
    MFMailComposeViewController* _mailController;
    
}





- (instancetype)initWithProgram: (Program*)program;





@end
