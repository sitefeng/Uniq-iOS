//
//  iPadProgramAcademicsViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPadProgramHexCollectionView.h"
#import "iPadProgramRelatedView.h"
#import "JPProgramAcademicsViewController.h"

@class Program, iPadProgramLabelView, JPDateView, iPadProgramRelatedView, UserFavItem;
@interface iPadProgramAcademicsViewController : JPProgramAcademicsViewController <JPProgramHexCollectionViewDataSource, JPProgramRelatedViewDataSource>
{
 
    JPDateView*      _dateView;
    
    UILabel*         _calendarLabel;
    
    CGFloat        _yPositionForScrollView;
    
    NSUInteger     _numHexViews;
    
    
    UIView*        _calendarBackground;
}




//Hex view
@property (nonatomic, strong) iPadProgramHexCollectionView* hexCollectionView;

@property (nonatomic, strong) iPadProgramRelatedView* relatedView;



- (id)initWithProgram: (Program*)program;




@end
