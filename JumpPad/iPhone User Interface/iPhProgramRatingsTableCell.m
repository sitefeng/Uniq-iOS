//
//  iPhProgramRatingsTableCell.m
//  Uniq
//
//  Created by Si Te Feng on 8/14/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhProgramRatingsTableCell.h"
#import "JPFont.h"
#import "JPStyle.h"


@interface iPhProgramRatingsTableCell()

@property (nonatomic, strong) UILabel* titleLabel;

@end


@implementation iPhProgramRatingsTableCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.showsLeftLabel = NO;
        self.invertLabelsForRatio = NO;
        self.percentage = 50;
        
        //UI Elements
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, kiPhoneWidthPortrait-10, 30)];
        self.titleLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
        [self addSubview:self.titleLabel];
        
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 30, kiPhoneWidthPortrait-100, kCellHeight-30)];
        _slider.tintColor = [JPStyle interfaceTintColor];
        _slider.value = self.percentage;
        [_slider addTarget:self action:@selector(sliderMoved:) forControlEvents:UIControlEventValueChanged | UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
        [self addSubview:_slider];
        
        leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 30, 46, 30)];
        leftLabel.textColor = [JPStyle interfaceTintColor];
        leftLabel.text = [NSString stringWithFormat:@"50"];
        leftLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:25];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        leftLabel.hidden = !self.showsLeftLabel;
        [self addSubview:leftLabel];
        
        rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(kiPhoneWidthPortrait- 48, 30, 46, 30)];
        rightLabel.textColor = [JPStyle interfaceTintColor];
        rightLabel.text = [NSString stringWithFormat:@"50"];
        rightLabel.textAlignment = NSTextAlignmentCenter;
        rightLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:25];
        
        [self addSubview:rightLabel];
        
    }
    return self;
}


- (void)sliderMoved: (UISlider*)slider
{
    CGFloat percent = _slider.value * 100.0;
    [self setLabels];
    
    [self.delegate programRatingsCell:self sliderValueDidChangeToValue:percent];
    
}


- (void)setLabels
{
    CGFloat percent = _slider.value * 100.0;
    
    NSString* percentText = [NSString stringWithFormat:@"%.00f", percent];
    NSString* invertText = [NSString stringWithFormat:@"%.00f", 100-percent];
    
    if(self.invertLabelsForRatio)
    {
        leftLabel.text = percentText;
        rightLabel.text = invertText;
    }
    else
    {
        leftLabel.text = invertText;
        rightLabel.text = percentText;
    }
}


#pragma mark - Setter Methods

- (void)setPercentage:(CGFloat)percentage
{
    _percentage = percentage;
    
    [_slider setValue:percentage/100.0];

    [self setLabels];
}


- (void)setPercentageAnimated:(CGFloat)percentage
{
    _percentage = percentage;
    
    [_slider setValue:percentage/100.0 animated:YES];
    [self setLabels];
}


- (void)setShowsLeftLabel:(BOOL)showsLeftLabel
{
    _showsLeftLabel = showsLeftLabel;
    
    if(_showsLeftLabel)
        leftLabel.hidden = NO;
    else
        leftLabel.hidden = YES;
    
}

- (void)setInvertLabelsForRatio:(BOOL)invertLabelsForRatio
{
    _invertLabelsForRatio = invertLabelsForRatio;
    [self sliderMoved:_slider];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}


- (void)prepareForReuse
{
    self.showsLeftLabel = NO;
    self.invertLabelsForRatio = NO;

    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    leftLabel.hidden = !self.showsLeftLabel;
    leftLabel.text = @"50";
    rightLabel.text = @"50";

    self.titleLabel.text = @"";
}

@end
