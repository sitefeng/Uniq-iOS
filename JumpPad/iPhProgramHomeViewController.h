//
//  iPhProgramHomeViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Program, iPhImageScrollView, iPhProgramDetailView;
@interface iPhProgramHomeViewController : UIViewController
{
    iPhImageScrollView*  _panImageView;
    
    CGFloat   _imageViewYBeforePan;
    
    UIScrollView*  _detailScrollView;
    
    iPhProgramDetailView* _highlighView;
    iPhProgramDetailView* _ratioView;
}


@property (nonatomic, strong) Program* program;




- (instancetype)initWithProgram: (Program*)program;


@end
