//
//  iPadProgramHexCollectionView.h
//  Uniq
//
//  Created by Si Te Feng on 2014-05-31.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JPProgramHexCollectionViewDataSource;

@class iPadProgramHexView;
@interface iPadProgramHexCollectionView : UIView
{
    CGRect    _frame;
    
    CGFloat   _yPosition;
    
    NSUInteger   _horizPositionInt;
    
    CGFloat   _horizontalPosition;
    
}



@property (nonatomic, weak) id<JPProgramHexCollectionViewDataSource> dataSource;



- (void)reloadData;



@end


@protocol JPProgramHexCollectionViewDataSource <NSObject>

//only available for 2 cells in 1 row

@required

- (NSUInteger)numberOfCellsInHexCollectionView: (iPadProgramHexCollectionView*)cv;

- (iPadProgramHexView*)hexCollectionView: (iPadProgramHexCollectionView*)cv hexViewForCellAtPosition: (NSUInteger)position;





@end