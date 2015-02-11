//
//  iPadDashletImageView.m
//  JumpPad
//
//  Created by Si Te Feng on 2/21/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadDashletImageView.h"
#import "UIImage+ImageEffects.h"
#import "AsyncImageView.h"


@implementation iPadDashletImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialize the views first
        self.logoView = [[AsyncImageView alloc] initWithFrame:CGRectMake(frame.size.width/5.0, frame.size.height/7.6, frame.size.width*3/5, frame.size.height*6/7.6)];
        self.logoView.contentMode = UIViewContentModeScaleAspectFit;
    
        self.backgroundView = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
        self.backgroundView.image = [UIImage imageNamed:@"defaultSchoolBlurred"];
        self.backgroundView.clipsToBounds = YES;
        
        self.imageArray = [NSMutableArray array];
        
        //Setting the imageViews to default images first
        UIImage* logo = [UIImage imageNamed:@"unknown"];
        
        self.logo = logo;
        
        [self addSubview:self.backgroundView];
        [self insertSubview:self.logoView aboveSubview:self.backgroundView];
        
        [self setUserInteractionEnabled:NO];
        
        _whiteView = [[UIView alloc] initWithFrame:self.backgroundView.frame];
        _whiteView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.35];
        _whiteView.hidden = YES;
        [self insertSubview:_whiteView aboveSubview:self.backgroundView];
        
    }
    return self;
}



- (void)setImageURLs:(NSMutableArray *)imageUrls //NSURL array
{
    _imageURLs = imageUrls;
    _imagesToLoad = [imageUrls count];
    
    [self reloadImages];
}


- (void)reloadImages
{
    self.backgroundView.animationImages = nil;
    
    self.backgroundView.image = [UIImage imageNamed:@"defaultSchoolBlurred"];
    
    if([self.imageURLs count] > 0)
    {
        [[AsyncImageLoader sharedLoader] loadImageWithURL:[_imageURLs firstObject] target:self action:@selector(imageLoaded)];
    }
}



- (void)imageLoaded
{
    _imagesToLoad--;

    UIImage* image;
    
    if (self.imageURLs.count > 0)
    {
        image = [[[AsyncImageLoader sharedLoader] cache] objectForKey:[self.imageURLs objectAtIndex:0]];
    }
    else
        image = [UIImage imageNamed:@"defaultSchoolBlurred"];
    
    self.backgroundView.image = image;
    
//    UIColor* tintColor = [UIColor colorWithWhite:1 alpha:0.27];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        
//        __block UIImage* blurredImg = [image applyBlurWithRadius:2 tintColor: tintColor saturationDeltaFactor:0 maskImage:nil];
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.backgroundView.image = blurredImg;
//            [self setNeedsDisplay];
//            blurredImg = nil;
//        });
//    });
}



- (void)setLogoURL:(NSURL *)logoURL
{
    _logoURL = logoURL;
    
    if(!logoURL)
    {
        _whiteView.hidden = YES;
        self.logoView.image = nil;
        return;
    }
    
    _whiteView.hidden = NO;
    [[AsyncImageLoader sharedLoader] loadImageWithURL:_logoURL target:self action:@selector(logoLoaded)];
    
    [self setNeedsDisplay];
}



-(void) logoLoaded
{
    self.logoView.image = [[[AsyncImageLoader sharedLoader] cache] objectForKey:self.logoURL];
    
}



- (void)setFadeEffect:(BOOL)fadeEffect
{
    _fadeEffect = fadeEffect;
    
}



@end

/*
//Loading Multiple Blurred Images
//    NSMutableArray* blurredImages = [NSMutableArray array];
//    if(_imagesToLoad == 0)
//    {
//        if([self.imageURLs count] == 1)
//        {
//            self.backgroundView.animationImages = nil;
//
//            UIImage* image = [[[AsyncImageLoader sharedLoader] cache] objectForKey:[self.imageURLs objectAtIndex:0]];
//
//            self.backgroundView.image = [image applyBlurWithRadius:9 tintColor: tintColor saturationDeltaFactor:2.5 maskImage:nil];
//        }
//        else //[image count] >= 2
//        {
//            self.backgroundView.image = nil;
//
//            for(int i=0; i<[self.imageURLs count]; i++)
//            {
//
//                UIImage* image = [[[AsyncImageLoader sharedLoader] cache] objectForKey:[self.imageURLs objectAtIndex:0]];
//
//                UIImage* blurredImage = [image applyBlurWithRadius:9 tintColor:tintColor saturationDeltaFactor:2.5 maskImage:nil];
//
//                [blurredImages addObject:blurredImage];
//
//            }
//
//            self.backgroundView.animationImages = blurredImages;
//
//            //Setting to the image animation to an arbitrary value
//            self.backgroundView.animationDuration = arc4random() % 10 + 10;
//            self.backgroundView.animationRepeatCount = 0;
//
//            [self.backgroundView startAnimating];
//
//        }
//    }
*///Load Multiple Images

