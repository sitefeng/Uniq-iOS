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
#import "Faculty.h"
#import "School.h"
#import "iPhProgramViewController.h"
#import "iPhProgramDetailTableView.h"


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

    self.progressPanView = [[iPhAppProgressPanView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight - 240, kiPhoneWidthPortrait, 270)];
    self.progressPanView.delegate = self;
    self.progressPanView.itemId = self.program.programId;
    
    UIPanGestureRecognizer* panRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewPanned:)];
    [self.progressPanView addGestureRecognizer:panRec];
    [self.view addSubview:self.progressPanView];
    
    
    //Program Detail Table View
    _dashletTitles = @[@"Courses", @"+"];
    
    self.tableView = [[iPhProgramDetailTableView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight + 30, kiPhoneWidthPortrait, kiPhoneHeightPortrait - kiPhoneStatusBarHeight-kiPhoneNavigationBarHeight-kiPhoneTabBarHeight-30) program:self.program];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight + 30, kiPhoneWidthPortrait, kiPhoneHeightPortrait - kiPhoneStatusBarHeight-kiPhoneNavigationBarHeight-kiPhoneTabBarHeight-30);
    
   
    
    
    
    [self.view bringSubviewToFront:_progressPanView];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
}


#pragma mark - Program Detail Table View Data Source

- (NSInteger)numberOfDashletsInProgramDetailTable:(iPhProgramDetailTableView *)tableView
{
    return [_dashletTitles count];
}


- (NSString*)programDetailTable:(iPhProgramDetailTableView *)tableView dashletTitleForRow:(NSInteger)row
{
    return _dashletTitles[row];
}




#pragma mark - Callback Methods

- (void)courseTermPressed:(NSString*)term
{
    
    JPProgramCoursesViewController* vc = [[JPProgramCoursesViewController alloc] initWithNibName:nil bundle:nil];
    vc.program = self.program;
    vc.programTerm = term;
    
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:navController animated:YES completion:nil];
    
}



- (void)appProgressDidPressFavoriteButton
{
    iPhProgramViewController* tabController = (iPhProgramViewController*)self.tabBarController;
    [tabController reloadFavoriteButtonState];
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
