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
#import "Contact.h"
#import "iPhProgramDetailTableView.h"


@class Program, iPhImagePanView, iPhProgramDetailView;
@interface iPhProgramHomeViewController : iPhProgramSchoolAbstractViewController <JPProgramSummaryDelegate, MFMailComposeViewControllerDelegate, JPProgramDetailTableViewDataSource>
{
    iPhImagePanView*  _panImageView;
    
    UIScrollView*  _detailScrollView;
    
    iPhProgramDetailView* _highlighView;
    iPhProgramDetailView* _ratioView;
    NSArray*    _dashletTitles;
    
    
    MFMailComposeViewController* _mailController;

}



@property (nonatomic, strong) iPhProgramDetailTableView* dashletTableView;


- (instancetype)initWithProgram: (Program*)program;







@end

