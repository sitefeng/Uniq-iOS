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

@class Program, iPadProgramLabelView, JPDateView, iPadProgramRelatedView, UserFavItem;
@interface iPadProgramAcademicsViewController : UIViewController <JPProgramHexCollectionViewDataSource, JPProgramRelatedViewDataSource>
{
    NSManagedObjectContext* context;
    
    JPDateView*      _dateView;
    
    UILabel*         _calendarLabel;
    NSMutableArray*  _applicationButtons;
    
    CGFloat        _yPositionForScrollView;
    
    NSUInteger     _numHexViews;
    
    UserFavItem*    _userFav;
    
    UIView*        _calendarBackground;
}




@property (nonatomic, assign) NSUInteger dashletUid;
@property (nonatomic, strong) Program* program;


@property (nonatomic, strong) iPadProgramLabelView* labelView;


//Hex view
@property (nonatomic, strong) iPadProgramHexCollectionView* hexCollectionView;

@property (nonatomic, strong) iPadProgramRelatedView* relatedView;



- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program;




@end
