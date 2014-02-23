//
//  iPadDashletDetailsView.h
//  JumpPad
//
//  Created by Si Te Feng on 12/11/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iOSDashletDetailsView : UIScrollView


@property (nonatomic, strong) UIImage* starImage;

@property (nonatomic, strong) UIImageView* starImageView;

@property (nonatomic, strong) UILabel* label;

- (id)initWithFrame:(CGRect)frame andRating: (NSInteger)rating;



@end
