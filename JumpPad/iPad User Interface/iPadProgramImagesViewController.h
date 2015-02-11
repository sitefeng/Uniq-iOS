//
//  iPadProgramImagesViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AsyncImageView, Program, School, Faculty;

@interface iPadProgramImagesViewController : UIViewController <UIScrollViewDelegate>
{
    NSInteger   _currentType;
    
    UILabel*    _noPhotoLabel;
}



@property (nonatomic, strong) Program* program;
@property (nonatomic, strong) School * school;
@property (nonatomic, strong) Faculty* faculty;




@property (nonatomic, strong) NSMutableArray* urls; //array of NSURL

@property (nonatomic, strong) NSMutableArray* asyncImageViews;

@property (nonatomic, strong) UIScrollView* scrollView;






@property (nonatomic, strong) UIPageControl* pageControl;




@end
