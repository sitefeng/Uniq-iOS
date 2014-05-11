//
//  iPadProgramDetailView.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-08.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramDetailView.h"
#import "Program.h"

#import "JPStyle.h"
#import "JPFont.h"


@implementation iPadProgramDetailView 

- (id)initWithFrame:(CGRect)frame andProgram: (Program*)prog
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
        self.program = prog;
        self.backgroundColor = [UIColor lightGrayColor];
    
        _currentHeight = 0;
        
        //////////////////////////////////////////////////
        //Start Creating Views
        UITextView* aboutView = [[UITextView alloc] initWithFrame:CGRectMake(250, 20, 500, 200)];
        
        aboutView.font = [JPFont fontWithName:[JPFont defaultFont] size:15];
        aboutView.textColor = [UIColor blackColor];
        aboutView.userInteractionEnabled = NO;
        aboutView.editable = NO;
        
        aboutView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        aboutView.backgroundColor = [JPStyle colorWith8BitRed:0 green:0 blue:0 alpha:0.1];
        
        aboutView.text = self.program.about;
        
        if(aboutView.text == nil || [aboutView.text isEqualToString:@""])
        {
            aboutView.text = @"Description not available.";
        }
        
        [aboutView sizeToFit];
        
        CGSize aboutViewSize = aboutView.frame.size;
        
        
        float aboutLabelY = 20 + aboutViewSize.height/2.0 - 55/2.0 ;
        
        UILabel* aboutLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, aboutLabelY - 10, 136, 55)];
        aboutLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:55];
        aboutLabel.textColor = [JPStyle colorWithHex:@"6100CC" alpha:1];
        aboutLabel.text = @"About";
        
        [aboutLabel sizeToFit];

        UIImageView* aboutImgView = [[UIImageView alloc] initWithFrame:CGRectMake(16, aboutLabelY, 55, 55)];
        aboutImgView.contentMode = UIViewContentModeScaleToFill;
        aboutImgView.image = [UIImage imageNamed:@"academics"];
        
        if(aboutViewSize.height >= aboutLabel.frame.size.height)
        {
            _currentHeight = _currentHeight + 40 + aboutViewSize.height;
        }
        else
        {
            _currentHeight = _currentHeight + 40 + aboutLabel.frame.size.height;
        }
        
        
        
        
        
        
        
        
        
        
        self.contentSize = CGSizeMake(768, _currentHeight + 150) ;
        
        [self addSubview:aboutLabel];
        [self addSubview:aboutView];
        [self addSubview:aboutImgView];
    
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
