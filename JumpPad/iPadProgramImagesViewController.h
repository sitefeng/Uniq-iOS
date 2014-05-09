//
//  iPadProgramImagesViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AsyncImageView, Program;

@interface iPadProgramImagesViewController : UIViewController <UIScrollViewDelegate>
{
    
    
}



@property (nonatomic, assign) Program* program;



@property (nonatomic, strong) NSMutableArray* urls; //array of NSURL

@property (nonatomic, strong) NSMutableArray* asyncImageViews;

@property (nonatomic, strong) UIScrollView* scrollView;






@property (nonatomic, strong) UIPageControl* pageControl;




@end
