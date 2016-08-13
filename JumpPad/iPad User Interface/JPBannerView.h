//
//  iPadBannerView.h
//  JumpPad
//
//  Created by Si Te Feng on 2/23/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPBannerView : UIScrollView <UIScrollViewDelegate>
{
    @private
    
    float          _bannerWidth;
    BOOL           _bannerRightIsSet;
    BOOL           _bannerLeftIsSet;
    
    NSTimer*       _scrollTimer;
    CGRect         _frame;
    
    BOOL           _isReachable;
    
}


//Array of NSURL: Mandatory
@property (nonatomic, strong) NSMutableArray* imgArrayURL;

//Array of NSString: Optional, if online images need to be replaced by offline images in case of offline mode
@property (nonatomic, strong) NSArray *imgFileNames;


//Array of UIImageView
@property (nonatomic, strong) NSMutableArray* bannerArray;



- (void)pauseAutoscroll;

- (void)activateAutoscroll; //Autoscroll by Default



@end
