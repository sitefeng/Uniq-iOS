//
//  iPhProgramAbstractViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/13/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhProgramSchoolAbstractViewController.h"
#import "Program.h"

@implementation iPhProgramSchoolAbstractViewController

- (instancetype)initWithProgram: (Program*)program
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        self.program = program;
        
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _imageViewYBeforePan = kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight - 240;
}



- (void)imageViewPanned: (UIPanGestureRecognizer*)recognizer
{
    const float minPosition = -176;
    const float maxPosition = 64;
    
    UIView* pannedView = recognizer.view;
    CGRect  pastFrame = pannedView.frame;
    CGFloat yPosition = pastFrame.origin.y;
    
    if(recognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:pannedView];
        
        if((translation.y >= 0 && yPosition < 64) || (translation.y <= 0 && yPosition > -176)) //going down||going up
        {
            [pannedView setFrame:CGRectMake(pastFrame.origin.x, _imageViewYBeforePan + translation.y, pastFrame.size.width, pastFrame.size.height)];
        }
        
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        _imageViewYBeforePan = pannedView.frame.origin.y;
        
        if(fabs(_imageViewYBeforePan - 64) > 2 ||fabs(_imageViewYBeforePan - (-176)) > 2)
        {
            [UIView animateWithDuration:0.2 delay:0 options: UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 
                                 if (yPosition > minPosition + (maxPosition - minPosition)/2.0 + 30)
                                 {
                                     [pannedView setFrame:CGRectMake(pastFrame.origin.x, 64, pastFrame.size.width, pastFrame.size.height)];
                                 }
                                 else
                                 {
                                     [pannedView setFrame:CGRectMake(pastFrame.origin.x, -176, pastFrame.size.width, pastFrame.size.height)];
                                 }
                                 
                             } completion:nil];
        }
        
        _imageViewYBeforePan = pannedView.frame.origin.y;
        
    }
    
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
