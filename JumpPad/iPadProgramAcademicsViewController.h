//
//  iPadProgramAcademicsViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Program, iPadProgramLabelView, iOSDateView;
@interface iPadProgramAcademicsViewController : UIViewController
{
    iOSDateView*      _dateView;
    
    NSMutableArray*   _calButtonSelected;
    
    UILabel*         _calendarLabel;
}




@property (nonatomic, assign) NSUInteger dashletUid;
@property (nonatomic, strong) Program* program;



@property (nonatomic, strong) iPadProgramLabelView* labelView;








- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program;




@end
