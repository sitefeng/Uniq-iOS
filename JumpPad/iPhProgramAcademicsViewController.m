//
//  iPhProgramAcademicsViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhProgramAcademicsViewController.h"
#import "Program.h"
#import "iPhAppProgressPanView.h"
#import "iPhProgramDetailView.h"
#import "JPProgramCoursesViewController.h"


@interface iPhProgramAcademicsViewController ()

@end

@implementation iPhProgramAcademicsViewController

- (instancetype)initWithProgram: (Program*)program
{
    self = [super initWithProgram:program];
    if (self) {

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
    
    _progressPanView = [[iPhAppProgressPanView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight - 240, kiPhoneWidthPortrait, 270)];
    
    _progressPanView.program = self.program;
    
    UIPanGestureRecognizer* panRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewPanned:)];
    [_progressPanView addGestureRecognizer:panRec];
    [self.view addSubview:_progressPanView];
    
    
    _detailView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight + 30, kiPhoneWidthPortrait, kiPhoneHeightPortrait - kiPhoneStatusBarHeight-kiPhoneNavigationBarHeight-kiPhoneTabBarHeight-30)];
    [self.view addSubview:_detailView];
    
    float currYPos = 5;
    
    iPhProgramDetailView* coursesView = [[iPhProgramDetailView alloc] initWithFrame:CGRectMake(5, currYPos, kiPhoneWidthPortrait-10, 200) title:@"Courses" program:self.program];
    coursesView.delegate = self;
    [_detailView addSubview:coursesView];
    

    
    [self.view bringSubviewToFront:_progressPanView];
    
}



- (void)courseYearPressedWithYear:(NSInteger)year
{
    
    JPProgramCoursesViewController* vc = [[JPProgramCoursesViewController alloc] initWithNibName:nil bundle:nil];
    vc.coursesYear = year;
    vc.programCourses = self.program.courses;
    
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:navController animated:YES completion:nil];
    
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
