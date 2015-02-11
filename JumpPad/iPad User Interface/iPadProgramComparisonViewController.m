//
//  iPadProgramComparisonViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/4/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramComparisonViewController.h"

#import "Program.h"
#import "JPFont.h"

@interface iPadProgramComparisonViewController ()

@end

@implementation iPadProgramComparisonViewController

- (instancetype)initWithPrograms: (NSArray*)programs
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.programs = programs;
        
        
        
        
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UILabel* overviewLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, kiPadStatusBarHeight + kiPadNavigationBarHeight + 30, 500, 30)];
    [self.view addSubview:overviewLabel];
    
    self.descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, kiPadStatusBarHeight + kiPadNavigationBarHeight + 80, kiPadWidthPortrait - 100, 200)];
    self.descriptionTextView.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
    self.descriptionTextView.userInteractionEnabled = NO;
    self.descriptionTextView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.descriptionTextView];
    
    
    
    
}










#pragma mark - Setter Methods

- (void)setPrograms:(NSArray *)programs
{
    _programs = programs;
    _numPrograms = [_programs count];
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
