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

#define kDetailViewGap  10.0f
#define kDetailViewLRMargin  10.0f  //left right margin

#define kDetailViewWidth (kiPadWidthPortrait-2*kDetailViewLRMargin)

@implementation iPadProgramDetailView 

- (id)initWithFrame:(CGRect)frame andProgram: (Program*)prog
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
        self.program = prog;

        self.backgroundColor = [UIColor clearColor];
        
        _currentHeight = kDetailViewGap;
        
        //////////////////////////////////////////////////
        //Start Creating Views
        
        infoView = [[iPadProgramDetailInfoView alloc] initWithFrame:CGRectMake(kDetailViewLRMargin, _currentHeight, kDetailViewWidth, 700) title:@"About" paragraph:self.program.about];
        [infoView sizeToFit];
        _currentHeight = _currentHeight + infoView.frame.size.height + kDetailViewGap;
        
        
        //Graph Views
        graphViews = [NSMutableArray array];
        
        //340!!! 300 is the height of the actually graph, 20 is margin top and bottom
        iPadProgramDetailGraphView* tuitionView = [[iPadProgramDetailGraphView alloc] initWithFrame:CGRectMake(kDetailViewLRMargin, _currentHeight, kDetailViewWidth, 340) title:@"Tuition" program:self.program];
        
        [graphViews addObject:tuitionView];
        
        _currentHeight = _currentHeight + tuitionView.frame.size.height + kDetailViewGap;
        
        ///////****************************
        
        
        iPadProgramDetailGraphView* whyView = [[iPadProgramDetailGraphView alloc] initWithFrame:CGRectMake(kDetailViewLRMargin, _currentHeight, kDetailViewWidth, 420) title:@"Why" program:self.program];
        [graphViews addObject:whyView];
        
        _currentHeight = _currentHeight + whyView.frame.size.height + kDetailViewGap;
        
        ////////////////////////////
        
        iPadProgramDetailGraphView* ratingsView = [[iPadProgramDetailGraphView alloc] initWithFrame:CGRectMake(kDetailViewLRMargin, _currentHeight, kDetailViewWidth, 340) title:@"Ratings" program:self.program];
        [graphViews addObject:ratingsView];
        
        _currentHeight += ratingsView.frame.size.height + kDetailViewGap;
        
        
        ////////////////////////////////
        iPadProgramDetailGraphView* ratioView = [[iPadProgramDetailGraphView alloc] initWithFrame:CGRectMake(kDetailViewLRMargin, _currentHeight, kDetailViewWidth, 300) title:@"Ratio" program:self.program];
        [graphViews addObject:ratioView];
        
        
        _currentHeight += ratioView.frame.size.height + kDetailViewGap;
        
        self.contentSize = CGSizeMake(768, _currentHeight + 150);
        [self addSubview:infoView];
        [self addSubview:tuitionView];
        [self addSubview:whyView];
        [self addSubview:ratingsView];
        [self addSubview:ratioView];
            
    }
    return self;
}




- (void)reloadData
{
    for(iPadProgramDetailGraphView* graphView in graphViews)
    {
        [graphView reloadData];
    }
    
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
