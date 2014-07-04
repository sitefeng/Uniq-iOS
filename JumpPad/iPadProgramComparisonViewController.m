//
//  iPadProgramComparisonViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/4/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramComparisonViewController.h"

#import "Program.h"

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
