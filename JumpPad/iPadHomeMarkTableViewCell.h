//
//  iPadHomeMarkTableViewCell.h
//  Uniq
//
//  Created by Si Te Feng on 6/23/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPadHomeMarkTableViewCell : UITableViewCell



@property (nonatomic, assign) float coursePercentage;

@property (nonatomic, strong, readonly) LDProgressView* progressBar;
@property (nonatomic, strong, readonly) UILabel* percentageLabel;

@property (nonatomic, strong, readonly) UIImageView* imageView;

@property (nonatomic, strong) UILabel* titleLabel;




@end
