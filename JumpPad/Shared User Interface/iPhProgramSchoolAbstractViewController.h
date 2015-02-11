//
//  iPhProgramAbstractViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/13/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Program;
@interface iPhProgramSchoolAbstractViewController : UIViewController
{
    CGFloat   _imageViewYBeforePan;
    
    
}



@property (nonatomic, strong) Program* program;


- (instancetype)initWithProgram: (Program*)program;

- (void)imageViewPanned: (UIPanGestureRecognizer*)recognizer;




@end
