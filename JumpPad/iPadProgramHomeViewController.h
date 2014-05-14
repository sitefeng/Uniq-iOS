//
//  iPadProgramHomeViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iPadProgramSummaryView.h"
#import <MessageUI/MessageUI.h>



@class iPadProgramImagesViewController, iPadProgramLabelView, iPadProgramSummaryView, iPadProgramDetailView, Program;


@interface iPadProgramHomeViewController : UIViewController <JPProgramSummaryDelegate, MFMailComposeViewControllerDelegate>
{
    
    BOOL    _isOrientationPortrait;
    
    float   _screenWidth;
    
    NSManagedObjectContext* context;
    
    NSUInteger   _programId;
    
}





@property (nonatomic, assign) NSUInteger dashletUid;

@property (nonatomic, strong) Program* program;



@property (nonatomic, strong) iPadProgramImagesViewController* imageController;

@property (nonatomic, strong) iPadProgramLabelView* labelView;
@property (nonatomic, strong) iPadProgramSummaryView* summaryView;
@property (nonatomic, strong) iPadProgramDetailView* detailView;








@end
