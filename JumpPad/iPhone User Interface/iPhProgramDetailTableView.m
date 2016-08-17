//
//  iPhProgramDetailTableView.m
//  Uniq
//
//  Created by Si Te Feng on 9/7/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhProgramDetailTableView.h"
#import "iPhProgramDetailView.h"
#import "iPhFacultyDetailView.h"
#import "iPhSchoolDetailView.h"
#import "Program.h"
#import "Faculty.h"
#import "School.h"
#import "JPFont.h"
#import "JPStyle.h"
#import "ProgramDetailViewGeneric.h"


static const CGFloat DashletVerticalGap = 15.0f;
static const CGFloat DashletTitleLabelHeight = 30.0f;

@implementation iPhProgramDetailTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _scrollable = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame program:(Program*)program {
    if (self = [self initWithFrame:frame]) {
        _type = JPDashletTypeProgram;
        _program = program;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame faculty:(Faculty*)faculty {
    if (self = [self initWithFrame:frame]) {
        _type = JPDashletTypeFaculty;
        _faculty = faculty;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame school:(School*)school {
    if (self = [self initWithFrame:frame]) {
        _type = JPDashletTypeSchool;
        _school = school;
    }
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
        dashletView.layer.cornerRadius = 10.0f;
        dashletView.layer.masksToBounds = YES;
        dashletView.backgroundColor = [JPStyle colorWithName:@"tWhite"];
        
        UILabel* dashletLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dashletView.frame.size.width, DashletTitleLabelHeight)];
        dashletLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:26];
        dashletLabel.text = dashletTitle;
        dashletLabel.textAlignment = NSTextAlignmentCenter;
        dashletLabel.backgroundColor = [JPStyle colorWithName:@"tWhite"];
        [dashletView addSubview:dashletLabel];
        
        
        // Initializing detail dashlet views
        UIView<ProgramDetailViewGeneric> *genericDetailView;
        
        if (self.type == JPDashletTypeProgram) {
            iPhProgramDetailView* programDetailView = [[iPhProgramDetailView alloc] initWithFrame:CGRectMake(0, DashletTitleLabelHeight, dashletView.frame.size.width, dashletView.frame.size.height- DashletTitleLabelHeight) title:dashletTitle program: self.program];
            programDetailView.delegate = self.dataSource;
            [programDetailView reloadData];
            
            genericDetailView = programDetailView;
            
        } else if (self.type == JPDashletTypeFaculty) {
            iPhFacultyDetailView* facultyDetailView = [[iPhFacultyDetailView alloc] initWithFrame:CGRectMake(0, DashletTitleLabelHeight, dashletView.frame.size.width, dashletView.frame.size.height- DashletTitleLabelHeight) title:dashletTitle faculty: self.faculty];
            
            genericDetailView = facultyDetailView;
            
        } else if (self.type == JPDashletTypeSchool) {
            iPhSchoolDetailView* schoolDetailView = [[iPhSchoolDetailView alloc] initWithFrame:CGRectMake(0, DashletTitleLabelHeight, dashletView.frame.size.width, dashletView.frame.size.height- DashletTitleLabelHeight) title:dashletTitle school: self.school];
            genericDetailView = schoolDetailView;
        }
        
        //Changing dashlet height dynamically
        CGRect dashletFrame = dashletView.frame;
        dashletFrame.size.height = genericDetailView.viewHeight + dashletLabel.frame.size.height;
        dashletView.frame = dashletFrame;
        
        [dashletView addSubview:genericDetailView];
        [_programDetailViews addObject:genericDetailView];
        [self addSubview:dashletView];
        
        currYPosition += dashletFrame.size.height + DashletVerticalGap;
        
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



- (iPhProgramDetailView*)dashletForRow:(NSInteger)row {
    return _programDetailViews[row];
}



- (void)setDataSource:(id<JPProgramDetailTableViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self reloadData];
}





@end
