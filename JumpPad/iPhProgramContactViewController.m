//
//  iPhProgramContactViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//


#import "iPhProgramContactViewController.h"
#import "Program.h"
#import "Faculty.h"
#import "School.h"
#import "JPFont.h"
#import "iPhMapPanView.h"

@interface iPhProgramContactViewController ()

@end

@implementation iPhProgramContactViewController

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
    
    _mapPanView = [[iPhMapPanView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight - 240, kiPhoneWidthPortrait, 270)];
    
    _mapPanView.school = self.program.faculty.school;
    
    UIPanGestureRecognizer* panRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewPanned:)];
    [_mapPanView addGestureRecognizer:panRec];
    [self.view addSubview:_mapPanView];
    
    
    
    
    
    [self.view bringSubviewToFront:_mapPanView];
    
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
