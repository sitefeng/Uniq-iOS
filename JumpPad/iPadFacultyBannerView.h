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
  
}



@property (nonatomic, strong) JPDashlet* dashlet;


@property (nonatomic, strong) UILabel* titleLabel;



- (id)initWithFrame:(CGRect)frame withDashlet: (JPDashlet*)dashlet;


@end
