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
        // Initialization code
        
        slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 30, kiPhoneWidthPortrait-100, kCellHeight-30)];
        slider.tintColor = [JPStyle interfaceTintColor];
        slider.value = 0.5f;
        [slider addTarget:self action:@selector(sliderMoved) forControlEvents:UIControlEventValueChanged];
        [self addSubview:slider];
        
        leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 30, 30)];
        leftLabel.textColor = [JPStyle interfaceTintColor];
        leftLabel.text = [NSString stringWithFormat:@"%.00f", 100-slider.value*100];
        leftLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:25];
        [self addSubview:leftLabel];
        
        rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(kiPhoneWidthPortrait- 40, 30, 30, 30)];
        rightLabel.textColor = [JPStyle interfaceTintColor];
        rightLabel.text = [NSString stringWithFormat:@"%.00f", slider.value*100];
        rightLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:25];
        [self addSubview:rightLabel];
        
    }
    return self;
}


- (void)sliderMoved: (UISlider*)slider
{
    
    
    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
