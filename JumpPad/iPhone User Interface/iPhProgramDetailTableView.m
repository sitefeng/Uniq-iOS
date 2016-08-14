//
//  iPhProgramDetailTableView.m
//  Uniq
//
//  Created by Si Te Feng on 9/7/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhProgramDetailTableView.h"
#import "iPhProgramDetailView.h"
#import "Program.h"
#import "JPFont.h"
#import "JPStyle.h"


@implementation iPhProgramDetailTableView

- (instancetype)initWithFrame:(CGRect)frame program:(Program*)program
{
    self = [super initWithFrame:frame];
    
    self.program = program;
    
    return self;
}


- (void)reloadData
{
    if(!self.dataSource)
    {
        NSLog(@"Give Program Detail Dashlet View a Data Source");
        return;
    }
    
    //Clear Views from Before
    _programDetailViews = [NSMutableArray array];
    for(UIView* view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    NSInteger numDashlets = [self.dataSource numberOfDashletsInProgramDetailTable:self];
    
    CGFloat currYPosition = 5;
    
    for(int i=0; i<numDashlets; i++)
    {
        NSString* dashletTitle = [self.dataSource programDetailTable:self dashletTitleForRow:i];
        
        UIView* dashletView = [[UIView alloc] initWithFrame:CGRectMake(5, currYPosition, self.frame.size.width-10, 200)];
        dashletView.backgroundColor = [JPStyle colorWithName:@"tWhite"];
        
        UILabel* dashletLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dashletView.frame.size.width, 30)];
        dashletLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:26];
        dashletLabel.text = dashletTitle;
        dashletLabel.textAlignment = NSTextAlignmentCenter;
        dashletLabel.backgroundColor = [JPStyle colorWithName:@"tWhite"];
        [dashletView addSubview:dashletLabel];

        iPhProgramDetailView* detailView = [[iPhProgramDetailView alloc] initWithFrame:CGRectMake(0, 30, dashletView.frame.size.width, dashletView.frame.size.height- 30) title:dashletTitle program: self.program];
        detailView.delegate = self.dataSource;
        [detailView reloadData];
        //Changing dashlet height dynamically
        CGRect dashletFrame = dashletView.frame;
        dashletFrame.size.height = detailView.viewHeight + dashletLabel.frame.size.height;
        dashletView.frame = dashletFrame;
        
        [dashletView addSubview:detailView];
        [_programDetailViews addObject:detailView];
        [self addSubview:dashletView];
        
        currYPosition += dashletFrame.size.height + 5;
        
    }
    
    if(self.scrollable) {
        self.contentSize = CGSizeMake(self.frame.size.width, currYPosition);
        
    }
    else {
        self.contentSize = CGSizeMake(self.frame.size.width, 0);
        CGRect tableFrame = self.frame;
        tableFrame.size.height = currYPosition;
        self.frame = tableFrame;
    }
    
    if([self.dataSource respondsToSelector:@selector(programDetailTable:didFindMaximumHeight:)])
        [self.dataSource programDetailTable:self didFindMaximumHeight:currYPosition];
    
    [self setNeedsDisplay];
}



- (iPhProgramDetailView*)dashletForRow:(NSInteger)row
{
    return _programDetailViews[row];
    
}



- (void)setDataSource:(id<JPProgramDetailTableViewDataSource>)dataSource
{
    _dataSource = dataSource;
    
    [self reloadData];
    
}





@end
