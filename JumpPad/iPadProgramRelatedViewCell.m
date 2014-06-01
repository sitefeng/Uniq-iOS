//
//  iPadProgramRelatedViewCell.m
//  Uniq
//
//  Created by Si Te Feng on 2014-06-01.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramRelatedViewCell.h"

#import "AsyncImageView.h"

@implementation iPadProgramRelatedViewCell



- (void)setImageURLString:(NSString *)imageURLString
{
    
    _imageURLString = imageURLString;
    
    NSURL* url = [NSURL URLWithString:_imageURLString];
    
    self.asyncImageView.imageURL = url;
    
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
