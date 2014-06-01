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

@class Program, iPadProgramLabelView, iOSDateView, iPadProgramRelatedView;
@interface iPadProgramAcademicsViewController : UIViewController <JPProgramHexCollectionViewDataSource, JPProgramRelatedViewDataSource>
{
    iOSDateView*      _dateView;
    
    NSMutableArray*   _calButtonSelected;
    UILabel*         _calendarLabel;
    
    CGFloat        _yPositionForScrollView;
    
    NSUInteger     _numHexViews;
    
}




@property (nonatomic, assign) NSUInteger dashletUid;
@property (nonatomic, strong) Program* program;


@property (nonatomic, strong) iPadProgramLabelView* labelView;


//Hex view
@property (nonatomic, strong) iPadProgramHexCollectionView* hexCollectionView;

@property (nonatomic, strong) iPadProgramRelatedView* relatedView;



- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program;




@end
