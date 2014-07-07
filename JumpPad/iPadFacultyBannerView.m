//
//  iPadFacultyBannerView.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-05.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadFacultyBannerView.h"
#import "AsyncImageView.h"
#import "JPDashlet.h"
#import "JPFont.h"
#import "JPStyle.h"

@implementation iPadFacultyBannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame withPlaceholder:NO];
    return self;
}


- (id)initWithFrame:(CGRect)frame withPlaceholder: (BOOL)showPlaceholder
{
    self = [super initWithFrame:frame withPlaceholderImgName:@"defaultProgram"];
    
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:50];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [JPStyle colorWithName:@"tBlack"];
        self.titleLabel.layer.masksToBounds = YES;
        self.titleLabel.layer.cornerRadius = 25;
        [self addSubview:self.titleLabel];
    }
    return self;
}



- (void)setDashletUid:(NSUInteger)dashletUid
{
    _dashletUid = dashletUid;
    _dashletInfo = [[JPDashlet alloc] initWithDashletUid:_dashletUid];
    
    if([_dashletInfo.backgroundImages count] > 0)
    {
        NSUInteger randomPhotoIndex = arc4random() % [_dashletInfo.backgroundImages count];
        self.imageURL = [_dashletInfo.backgroundImages objectAtIndex:randomPhotoIndex];
    }
    
    if(_dashletInfo.type == JPDashletTypeFaculty)
    {
        self.titleLabel.text = @" Select A Program ";
        self.titleLabel.frame = CGRectMake(360, 75, kiPadWidthPortrait-360, 50);
    }
    else
    {
        self.titleLabel.text = @" Select A Faculty ";
        self.titleLabel.frame = CGRectMake(390, 75, kiPadWidthPortrait-390, 50);
    }
    [self.titleLabel sizeToFit];
    
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
