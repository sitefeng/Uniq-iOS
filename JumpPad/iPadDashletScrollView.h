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





@interface iPadDashletScrollView : UIScrollView









@end
