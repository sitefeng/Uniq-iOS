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
        self.backgroundView.clipsToBounds = YES;
        
        self.imageArray = [NSMutableArray array];
        
        //Setting the imageViews to default images first
        UIImage* logo = [UIImage imageNamed:@"unknown"];
        
        self.logo = logo;
        
        [self addSubview:self.backgroundView];
        [self insertSubview:self.logoView aboveSubview:self.backgroundView];
        
        [self setUserInteractionEnabled:NO];
        
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
    UIColor* tintColor = [UIColor colorWithWhite:1 alpha:0.27];
    self.backgroundView.animationImages = nil;
    self.backgroundView.image = [[UIImage imageNamed:@"defaultSchool"] applyBlurWithRadius:8 tintColor: tintColor saturationDeltaFactor:1.8 maskImage:nil];
    
    if([self.imageURLs count] != 0)
    {
        [[AsyncImageLoader sharedLoader] loadImageWithURL:[_imageURLs firstObject] target:self action:@selector(imageLoaded)];
    }
    
}


- (void)imageLoaded
{
    _imagesToLoad--;

    UIColor* tintColor = [UIColor colorWithWhite:1 alpha:0.27];
    NSMutableArray* blurredImages = [NSMutableArray array];
    
    UIImage* image = [[[AsyncImageLoader sharedLoader] cache] objectForKey:[self.imageURLs objectAtIndex:0]];
    
    self.backgroundView.image = [image applyBlurWithRadius:9 tintColor: tintColor saturationDeltaFactor:2.5 maskImage:nil];

    
    if(_imagesToLoad == 0)
    {
        if([self.imageURLs count] == 1)
        {
            self.backgroundView.animationImages = nil;
            
            UIImage* image = [[[AsyncImageLoader sharedLoader] cache] objectForKey:[self.imageURLs objectAtIndex:0]];
            
            self.backgroundView.image = [image applyBlurWithRadius:9 tintColor: tintColor saturationDeltaFactor:2.5 maskImage:nil];
        }
        else //[image count] >= 2
        {
            self.backgroundView.image = nil;
            
            for(int i=0; i<[self.imageURLs count]; i++)
            {
                
                UIImage* image = [[[AsyncImageLoader sharedLoader] cache] objectForKey:[self.imageURLs objectAtIndex:0]];
                
                UIImage* blurredImage = [image applyBlurWithRadius:9 tintColor:tintColor saturationDeltaFactor:2.5 maskImage:nil];
                
                [blurredImages addObject:blurredImage];
                
            }
            
            self.backgroundView.animationImages = blurredImages;
            
            //Setting to the image animation to an arbitrary value
            self.backgroundView.animationDuration = arc4random() % 10 + 10;
            self.backgroundView.animationRepeatCount = 0;
            
            [self.backgroundView startAnimating];
        
        }
        
        [self setNeedsDisplay];
    }
    
}






- (void)setLogoURL:(NSURL *)logoURL
{
    _logoURL = logoURL;
    
    [[AsyncImageLoader sharedLoader] loadImageWithURL:_logoURL target:self action:@selector(logoLoaded)];
    
    [self setNeedsDisplay];
}



-(void) logoLoaded
{
    self.logoView.image = [[[AsyncImageLoader sharedLoader] cache] objectForKey:self.logoURL];
    
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
