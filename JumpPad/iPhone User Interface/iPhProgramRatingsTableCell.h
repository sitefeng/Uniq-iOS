//
//  iPhProgramRatingsTableCell.h
//  Uniq
//
//  Created by Si Te Feng on 8/14/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat kCellHeight = 65.0;

@protocol JPProgramRatingsCellDelegate;
@interface iPhProgramRatingsTableCell : UITableViewCell 
{

    UISlider*  _slider;
    
    UILabel*   leftLabel;
    UILabel*   rightLabel;
    
}

@property (nonatomic, weak) id<JPProgramRatingsCellDelegate>delegate;

@property (nonatomic, strong, readonly) UILabel* titleLabel;
@property (nonatomic, assign) CGFloat percentage;

@property (nonatomic, assign) BOOL showsLeftLabel;
@property (nonatomic, assign) BOOL invertLabelsForRatio;

- (void)setPercentageAnimated:(CGFloat)percentage;

@end

@protocol JPProgramRatingsCellDelegate <NSObject>

//0-100 always gives the slider position* 100
- (void)programRatingsCell: (iPhProgramRatingsTableCell*)cell sliderValueDidChangeToValue: (CGFloat)value;

@end