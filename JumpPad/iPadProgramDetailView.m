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

#import "iPadProgramDetailInfoView.h"
#import "iPadProgramDetailGraphView.h"

#import "ApplicationConstants.h"


#define kProgramGraphBarOffset  0.1

@implementation iPadProgramDetailView 

- (id)initWithFrame:(CGRect)frame andProgram: (Program*)prog
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
        self.program = prog;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"whiteBackground"]];
    
        _currentHeight = 0;
        
        //////////////////////////////////////////////////
        //Start Creating Views
        
        iPadProgramDetailInfoView* infoView = [[iPadProgramDetailInfoView alloc] initWithFrame:CGRectMake(0, _currentHeight, kiPadWidthPortrait, kiPadWidthPortrait) title:@"About" paragraph:self.program.about];
        [infoView sizeToFit];
        _currentHeight = _currentHeight + infoView.frame.size.height;
        

        
        //340!!! 300 is the height of the actually graph, 20 is margin top and bottom
        iPadProgramDetailGraphView* tuitionView = [[iPadProgramDetailGraphView alloc] initWithFrame:CGRectMake(0, _currentHeight, kiPadWidthPortrait, 340) title:@"Tuition" program:self.program];
        
        _currentHeight = _currentHeight + tuitionView.frame.size.height;
        
        ///////****************************
        
        
        iPadProgramDetailGraphView* whyView = [[iPadProgramDetailGraphView alloc] initWithFrame:CGRectMake(0, _currentHeight, kiPadWidthPortrait, 420) title:@"Why" program:self.program];
        
        
        _currentHeight = _currentHeight + whyView.frame.size.height;
        
        ////////////////////////////
        
        iPadProgramDetailGraphView* ratingsView = [[iPadProgramDetailGraphView alloc] initWithFrame:CGRectMake(0, _currentHeight, kiPadWidthPortrait, 340) title:@"Ratings" program:self.program];
        
        
        
        _currentHeight += ratingsView.frame.size.height;
        
        
        
        iPadProgramDetailGraphView* ratioView = [[iPadProgramDetailGraphView alloc] initWithFrame:CGRectMake(0, _currentHeight, kiPadWidthPortrait, 300) title:@"Ratio" program:self.program];
        
        
        
        _currentHeight += ratioView.frame.size.height;
        
        
        
        
        
        self.contentSize = CGSizeMake(768, _currentHeight + 150);
        
        
        [self addSubview:infoView];
        [self addSubview:tuitionView];
        [self addSubview:whyView];
        [self addSubview:ratingsView];
        [self addSubview:ratioView];
            
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
