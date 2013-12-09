//
//  iPadDashletScrollView.h
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iPadDashletScrollView;

@protocol JPDashletScrollViewDataSource <NSObject>

@required


- (NSUInteger)dashletScrollView:(iPadDashletScrollView*)scrollView numberOfDashletsInSection: (NSUInteger)section;




   
@optional

- (NSUInteger)numberOfSectionsInDashletScrollView: (iPadDashletScrollView*)scrollView;
   
   
@end





@interface iPadDashletScrollView : UIScrollView

@end
