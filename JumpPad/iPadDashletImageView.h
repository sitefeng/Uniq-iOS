//
//  iPadDashletImageView.h
//  JumpPad
//
//  Created by Si Te Feng on 2/21/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AsyncImageView;

@interface iPadDashletImageView : UIView
{
    int   _imagesToLoad;
}

@property (nonatomic, strong) NSURL* logoURL; // set this
@property (nonatomic, strong) UIImage* logo;
@property (nonatomic, strong) NSMutableArray* imageURLs; // set this
@property (nonatomic, strong) NSMutableArray* imageArray;


@property (nonatomic, strong) UIImageView* logoView;
@property (nonatomic, strong) UIImageView* backgroundView;






@end
