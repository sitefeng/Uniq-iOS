//
//  iPadDashletImageView.m
//  JumpPad
//
//  Created by Si Te Feng on 2/21/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadDashletImageView.h"
#import "UIImage+ImageEffects.h"

@implementation iPadDashletImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialize the views first
        self.logoView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/5.0, frame.size.height/7.6, frame.size.width*3/5, frame.size.height*6/7.6)];
        
        self.backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        //Setting the imageViews to default images first
        UIImage* logo = [UIImage imageNamed:@"unknown"];
        
        self.logo = logo;
        
        [self addSubview:self.backgroundView];
        [self insertSubview:self.logoView aboveSubview:self.backgroundView];
        
        [self setUserInteractionEnabled:NO];
        
    }
    return self;
}



- (void)setImages:(NSMutableArray *)images
{
    _images = images;
    UIColor* tintColor = [UIColor colorWithWhite:1 alpha:0.27];
    NSMutableArray* blurredImages = [NSMutableArray array];
    
    if([images count] == 0 || !images)
    {
        self.backgroundView.animationImages = nil;
        self.backgroundView.image = [[UIImage imageNamed:@"defaultDashlet"] applyBlurWithRadius:8 tintColor: tintColor saturationDeltaFactor:1.8 maskImage:nil];
    }
    else if([images count] == 1)
    {
        self.backgroundView.animationImages = nil;
        self.backgroundView.image = [_images[0] applyBlurWithRadius:9 tintColor: tintColor saturationDeltaFactor:2.5 maskImage:nil];
    }
    else //[image count] >= 2
    {
        self.backgroundView.image = nil;
        
        for(int i=0; i<[images count]; i++)
        {
            UIImage* img = [_images[i] applyBlurWithRadius:9 tintColor:tintColor saturationDeltaFactor:2.5 maskImage:nil];
            [blurredImages addObject:img];
            
        }
        
        self.backgroundView.animationImages = blurredImages;
        
        //Setting to the image animation to an arbitrary value
        self.backgroundView.animationDuration = arc4random() % 10 + 10;
        self.backgroundView.animationRepeatCount = 0;
        
        [self.backgroundView startAnimating];
    }
   
}


//- (void)animateTransition: (NSInteger)num
//{
//    [UIView transitionWithView:self.backgroundView
//                      duration: arc4random() % 10 + 3.0
//                       options:UIViewAnimationOptionTransitionCrossDissolve
//                    animations:^{
//                        self.backgroundView.image = self.images[num];
//                        
//                    } completion:^(BOOL finished){
//                        if([self.images count] >= num+2)
//                        {
//                            [self animateTransition:num+1];
//                        }
//                        
//                    }];
//}



- (void)setLogo:(UIImage *)logo
{
    _logo = logo;
    
    self.logoView.image = _logo;
    
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
