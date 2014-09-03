//
//  iPadProgramRatingsViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPProgramRatingHelper.h"


@class Program, iPadProgramLabelView, SFGaugeView, TLTiltSlider;
@interface iPadProgramRatingsViewController : UIViewController <JPProgramRatingHelperDelegate>
{
    JPProgramRatingHelper* _ratingsHelper;
    
    UILabel* _guyLabel;
    UILabel* _girlLabel;
    
    UIButton* submitButton;
}



@property (nonatomic, strong) Program* program;

@property (nonatomic, strong) iPadProgramLabelView* programLabel;



@property (nonatomic, strong) UIScrollView* ratingScrollView;

@property (nonatomic, strong) SFGaugeView* overallSelector;
@property (nonatomic, strong) NSMutableArray* categorySelectors; //array of volumebars
@property (nonatomic, strong) TLTiltSlider* tiltSlider;



- (id)initWithProgram: (Program*)program;




@end
