//
//  iPadDashletScrollView.h
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iPadDashletScrollView, JPDashlet;

@protocol JPDashletScrollViewDataSource <NSObject>

@required


- (NSUInteger)dashletScrollView:(iPadDashletScrollView*)scrollView numberOfDashletsInSection:(NSUInteger)section;
- (JPDashlet*)dashletScrollView: (iPadDashletScrollView*)scrollView dashletAtIndexPath: (NSIndexPath*)path;


   
@optional

- (NSUInteger)numberOfSectionsInDashletScrollView: (iPadDashletScrollView*)scrollView;
   
   
@end



@protocol JPDashletScrollViewDelegate <NSObject, UIScrollViewDelegate>

@optional

- (void)dashletScrollView: (iPadDashletScrollView*)scrollView didSelectDashletAtIndexPath: (NSIndexPath*)path;

@end





@interface iPadDashletScrollView : UIScrollView
{
    @private
    
    NSMutableArray*          _dashletViews; //An array of array of DashletViews
    NSUInteger           _numberOfDashlets;
    
    //Track the position of the dashlets
    CGFloat              _currentY;
    CGFloat              _currentX;
    
    
    
    
    
}



@property (nonatomic, assign) id<JPDashletScrollViewDataSource> dataSource;
@property (nonatomic, assign) id<JPDashletScrollViewDelegate> delegate;


@property (nonatomic, assign, getter = isEditing) BOOL editing;






- (void)loadDashlets;










@end
