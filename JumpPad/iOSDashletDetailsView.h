//
//  iPadDashletDetailsView.h
//  JumpPad
//
//  Created by Si Te Feng on 12/11/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iOSDashletDetailsView : UIScrollView



@property (nonatomic, strong) UIImageView* starImageView;
@property (nonatomic, strong) UILabel* label;


@property (nonatomic, strong) UIImageView* imageView2;
@property (nonatomic, strong) UILabel* label2;


- (id)initWithFrame:(CGRect)frame value1:(id)val1 value2: (id)val2;



@end
