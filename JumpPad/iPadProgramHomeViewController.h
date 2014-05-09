//
//  iPadProgramHomeViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>



@class iPadProgramImagesViewController, iPadProgramLabelView, iPadProgramSummaryView, iPadProgramDetailView, Program;

@interface iPadProgramHomeViewController : UIViewController
{
    
    BOOL    _isOrientationPortrait;
    
    float   _screenWidth;
    
    NSManagedObjectContext* context;
    
}







@property (nonatomic, assign) NSInteger programId;
@property (nonatomic, strong) Program* program;



@property (nonatomic, strong) iPadProgramImagesViewController* imageController;

@property (nonatomic, strong) iPadProgramLabelView* labelView;
@property (nonatomic, strong) iPadProgramSummaryView* summaryView;
@property (nonatomic, strong) iPadProgramDetailView* detailView;









@end
