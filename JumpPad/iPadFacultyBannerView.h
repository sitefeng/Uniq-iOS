  //
//  iPadFacultyBannerView.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-05.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@class JPDashlet;
@interface iPadFacultyBannerView : AsyncImageView
{
    JPDashlet*  _dashletInfo;
}



@property (nonatomic, assign) NSUInteger dashletUid;


@property (nonatomic, strong) UILabel* titleLabel;



- (id)initWithFrame:(CGRect)frame withPlaceholder: (BOOL)showPlaceholder;


@end
