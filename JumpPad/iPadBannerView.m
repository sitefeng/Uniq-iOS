//
//  iPadBannerView.m
//  JumpPad
//
//  Created by Si Te Feng on 2/23/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadBannerView.h"

@implementation iPadBannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.bannerArray = [NSMutableArray array];
        
        UIImage* img1 = [UIImage imageNamed:@"banner1"];
        UIImage* img2 = [UIImage imageNamed:@"banner2"];
        UIImage* img3 = [UIImage imageNamed:@"banner3"];
        UIImage* img4 = [UIImage imageNamed:@"banner4"];
        UIImage* img5 = [UIImage imageNamed:@"banner5"];

        self.imgArray = [@[img1, img2, img3, img4, img5] mutableCopy];
        
        for(int i=0; i< [self.imgArray count]; i++)
        {
            
            UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height)];
            
            imgView.image = self.imgArray[i];
            
            [self.bannerArray addObject:imgView];
            [self addSubview: self.bannerArray[i]];
            
        }
        
        self.showsHorizontalScrollIndicator = NO;
        
        self.contentInset = UIEdgeInsetsZero;
        self.pagingEnabled = YES;
        [self setContentSize:CGSizeMake(frame.size.width*[self.imgArray count], 200)];
        
        
        
    }
    return self;
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
