//
//  iPadProgramHomeViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JPProgramSummaryView.h"
#import <MessageUI/MessageUI.h>
#import "JPCoreDataHelper.h"
#import "Contact.h"

@class iPadProgramImagesViewController, iPadProgramLabelView, JPProgramSummaryView, iPadProgramDetailView, Program, JPCoreDataHelper;


@interface iPadProgramHomeViewController : UIViewController <JPProgramSummaryDelegate, MFMailComposeViewControllerDelegate>
{
    NSManagedObjectContext* context;
    JPCoreDataHelper* _coreDataHelper;
    
    
    
}



@property (nonatomic, strong) Program* program;



@property (nonatomic, strong) iPadProgramImagesViewController* imageController;

//@property (nonatomic, strong) iPadProgramLabelView* labelView;
@property (nonatomic, strong) JPProgramSummaryView* summaryView;
@property (nonatomic, strong) iPadProgramDetailView* detailView;




- (id)initWithProgram: (Program*)program;


@end
