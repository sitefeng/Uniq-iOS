//
//  iPadDashletTitleView.h
//  JumpPad
//
//  Created by Si Te Feng on 12/10/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iOSDashletTitleView : UIScrollView
//Also Reused for item extended chart



@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, strong) UIImage* titleIconImage;
@property (nonatomic, strong) NSString* titleIconName;






@end
