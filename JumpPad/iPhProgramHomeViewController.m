//
//  iPhProgramHomeViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhProgramHomeViewController.h"
#import "Program.h"
#import "Faculty.h"
#import "School.h"
#import "SchoolLocation.h"
#import "JPLocation.h"
#import "iPhImageScrollView.h"
#import "iPadProgramSummaryView.h"
#import "iPhProgramDetailView.h"


@interface iPhProgramHomeViewController ()

@end

@implementation iPhProgramHomeViewController

- (instancetype)initWithProgram: (Program*)program
{
    self = [super initWithProgram: program];
    if (self)
    {
        self.program = program;
        
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
    
    _panImageView = [[iPhImageScrollView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight - 240, kiPhoneWidthPortrait, 270)];
   
    _panImageView.program = self.program;
    
    UIPanGestureRecognizer* panRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewPanned:)];
    [_panImageView addGestureRecognizer:panRec];
    [self.view addSubview:_panImageView];
    
    
    _detailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 25, kiPhoneWidthPortrait, 620)];
    _detailScrollView.showsHorizontalScrollIndicator = NO;
    _detailScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_detailScrollView];

    JPLocation* programLocation = [[JPLocation alloc] initWithSchoolLocation:self.program.faculty.school.location];
    iPadProgramSummaryView* summaryView = [[iPadProgramSummaryView alloc] initWithFrame:CGRectMake(-10, 0, kiPhoneWidthPortrait, 308) program:self.program location:programLocation isPhoneInterface:YES];
    [_detailScrollView addSubview:summaryView];

    
    CGFloat currYPosition = CGRectGetMaxY(summaryView.frame) + 5;
    
    iPhProgramDetailView* aboutView = [[iPhProgramDetailView alloc] initWithFrame:CGRectMake(5, currYPosition, kiPhoneWidthPortrait - 10, 200) title:@"About" program:self.program];
    [_detailScrollView addSubview:aboutView];
    currYPosition += aboutView.frame.size.height + 5;
    
    iPhProgramDetailView* tuitionView = [[iPhProgramDetailView alloc] initWithFrame:CGRectMake(5, currYPosition, kiPhoneWidthPortrait - 10, 200) title:@"Tuition" program:self.program];
    [_detailScrollView addSubview:tuitionView];
    currYPosition += tuitionView.frame.size.height + 5;
    
    _highlighView = [[iPhProgramDetailView alloc] initWithFrame:CGRectMake(5, currYPosition, kiPhoneWidthPortrait - 10, 250) title:@"Highlight" program:self.program];
    [_detailScrollView addSubview:_highlighView];
    currYPosition += _highlighView.frame.size.height + 5;
    
    
    iPhProgramDetailView* ratingsView = [[iPhProgramDetailView alloc] initWithFrame:CGRectMake(5, currYPosition, kiPhoneWidthPortrait - 10, 250) title:@"Ratings" program:self.program];
    [_detailScrollView addSubview:ratingsView];
    currYPosition += ratingsView.frame.size.height + 5;
    
    
    _ratioView = [[iPhProgramDetailView alloc] initWithFrame:CGRectMake(5, currYPosition, kiPhoneWidthPortrait - 10, 200) title:@"Gals vs Guys Ratio" program:self.program];
    [_detailScrollView addSubview:_ratioView];
    currYPosition += _ratioView.frame.size.height + 5;
    
    [_detailScrollView setContentSize:CGSizeMake(_detailScrollView.frame.size.width, currYPosition + 130)];
    
    [self.view bringSubviewToFront:_panImageView];
}







- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_highlighView reloadData];
    [_ratioView reloadData];
}




- (void)setProgram:(Program *)program
{
    super.program = program;
    
    _panImageView.program = program;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
