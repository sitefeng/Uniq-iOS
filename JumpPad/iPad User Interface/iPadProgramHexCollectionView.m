//
//  iPadProgramHexCollectionView.m
//  Uniq
//
//  Created by Si Te Feng on 2014-05-31.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramHexCollectionView.h"

#import "iPadProgramHexView.h"

#import "UserInterfaceConstants.h"

@implementation iPadProgramHexCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        _frame = frame;
        
        
    }
    return self;
}


- (void)reloadData
{
    if(!_dataSource)
    {
        JPLog(@"Hex Collection View Data Source not set");
        return;
    }
    
    NSArray* subviews = self.subviews;
    for(UIView* hexView in subviews)
    {
        [hexView removeFromSuperview];
    }
    
    _yPosition = 20;
    _horizPositionInt = 0; //0, 1, or 2
    
    
    CGFloat horizIncrement = kHexWidth/2 + kGapWidth/2;
    CGFloat yIncrement = kHexHeight/3*2 + kGapWidth;
    
    
    NSUInteger numberOfCells = [self.dataSource numberOfCellsInHexCollectionView:self];
    
    for(int i=0; i<numberOfCells; i++)
    {
        iPadProgramHexView* hexView = [self.dataSource hexCollectionView:self hexViewForCellAtPosition:i];
        
        if( i % 3 == 0) //first hex horizontal position
        {
            _horizPositionInt = 0;
            _horizontalPosition = kGapWidth + _horizPositionInt*horizIncrement;
            
            hexView.frame = CGRectMake(_horizontalPosition, _yPosition, kHexWidth, kHexHeight);

        }
        else if( i%3 == 1) //third hex horiz position
        {
            _horizPositionInt = 2;
            _horizontalPosition = kGapWidth + _horizPositionInt*horizIncrement;
            
            hexView.frame = CGRectMake(_horizontalPosition, _yPosition, kHexWidth, kHexHeight);
            
            _yPosition += yIncrement + 36;
        }
        else //( i%3 == 2)  //second hex horiz position on the next row
        {
            _horizPositionInt = 1; // hex is in the middle
            _horizontalPosition = kGapWidth + _horizPositionInt*horizIncrement;

            hexView.frame = CGRectMake(_horizontalPosition, _yPosition, kHexWidth, kHexHeight);
            
            _yPosition += yIncrement + 36;
            
        }
        
        [self addSubview:hexView];
        
    }
    
    
    
    
    
    
    
    
}




- (void)setDataSource:(id<JPProgramHexCollectionViewDataSource>)dataSource
{
    
    _dataSource = dataSource;
    
    [self reloadData];
    
    
}








/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
