//
//  iPadProgramRatingsViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Program, iPadProgramLabelView, SFGaugeView;
@interface iPadProgramRatingsViewController : UIViewController
{
    UILabel* _saveLabel;
}



@property (nonatomic, assign) NSUInteger dashletUid;
@property (nonatomic, strong) Program* program;

@property (nonatomic, strong) iPadProgramLabelView* programLabel;



@property (nonatomic, strong) UIScrollView* ratingScrollView;

@property (nonatomic, strong) SFGaugeView* overallSelector;
@property (nonatomic, strong) NSMutableArray* categorySelectors; //array of volumebars




- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program;




@end
