//
//  iPadProgramRelatedViewCell.h
//  Uniq
//
//  Created by Si Te Feng on 2014-06-01.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AsyncImageView;
@interface iPadProgramRelatedViewCell : UIView





@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (weak, nonatomic) NSString*    imageURLString;
@property (weak, nonatomic) IBOutlet AsyncImageView *asyncImageView;




@end
