//
//  iPadHomeMarkTableViewCell.m
//  Uniq
//
//  Created by Si Te Feng on 6/23/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadHomeMarkTableViewCell.h"

#import "LDProgressView.h"
#import "JPFont.h"

@interface iPadHomeMarkTableViewCell()

@property (nonatomic, strong) LDProgressView* progressBar;
@property (nonatomic, strong) UILabel* percentageLabel;
@property (nonatomic, strong) UIImageView* courseImageView;


@end

@implementation iPadHomeMarkTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 8, 100, 28)];
        self.titleLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:23];
        [self addSubview:self.titleLabel];
        
        
        self.progressBar =  [[LDProgressView alloc] initWithFrame:CGRectMake(400, 10, 100, 20)];
        self.progressBar.tintColor = [JPStyle colorWithName:@"blue"];
        self.progressBar.flat = @true;
        self.progressBar.animate = @false;
        self.progressBar.type = LDProgressStripes;
        self.progressBar.showText = @false;
        
        [self addSubview:self.progressBar];
        
        
        
        
    }
    return self;
}









- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
