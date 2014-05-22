//
//  iPadProgramCompareViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramCompareViewController.h"
#import "Program.h"
#import "Faculty.h"
#import "School.h"
#import "iPadMainCollectionViewCell.h"

#import "JPDashlet.h"
#import "JPFont.h"


@interface iPadProgramCompareViewController ()

@end

@implementation iPadProgramCompareViewController

- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program
{
    self = [super init];
    
    if (self) {
        // Custom initialization
        
        self.tabBarItem.image = [UIImage imageNamed:@"compare"];
        self.view.backgroundColor = [UIColor greenColor];
        
        self.program = program;
        self.dashletUid = dashletUid;
        
        
        
        
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUInteger facultyDashletId = self.dashletUid - [self.program.programId integerValue];
    
    JPDashlet* dashletInfo1 = [[JPDashlet alloc] initWithProgram:self.program fromFaculty:facultyDashletId];
    
    _squareView = [[iPadMainCollectionViewCell alloc] initWithFrame:CGRectMake(100, 100, kiPadDashletSizePortrait.width, kiPadDashletSizePortrait.height)];
    _squareView.dashletInfo = dashletInfo1;
    
    UILabel* square1Label = [[UILabel alloc] initWithFrame:CGRectMake(100+kiPadDashletSizePortrait.width + 20, 100, 300, 90)];
    square1Label.font = [UIFont fontWithName:[JPFont defaultThinFont] size:25];
    square1Label.numberOfLines = 2;
    square1Label.text = [NSString stringWithFormat:@"%@\n%@", self.program.name, self.program.faculty.school.name];
    
    
    UILabel* versusLabel = [[UILabel alloc] initWithFrame:CGRectMake(386, 470, 80, 50)];
    versusLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:30];
    versusLabel.text = @"VS";
    
    
    [self.view addSubview:_squareView];
    [self.view addSubview:square1Label];
    [self.view addSubview:versusLabel];
    
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
