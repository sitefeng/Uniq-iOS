//
//  iPhProgramRatingsTableCell.h
//  Uniq
//
//  Created by Si Te Feng on 8/14/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat kCellHeight = 60.0;


@interface iPhProgramRatingsTableCell : UITableViewCell 
{
    UISlider*  slider;
    
    UILabel*   leftLabel;
    UILabel*   rightLabel;
    
}



@property (nonatomic, strong, readonly) UILabel* titleLabel;





@end
