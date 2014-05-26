//
//  iPadProgramAcademicsViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramAcademicsViewController.h"
#import "iPadProgramLabelView.h"
#import "NSString+JPDateStringParser.h"

#import "JPFont.h"
#import "JPStyle.h"

#import "iOSDateView.h"

#import "Program.h"


@interface iPadProgramAcademicsViewController ()

@end

@implementation iPadProgramAcademicsViewController

- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        self.tabBarItem.image = [UIImage imageNamed:@"academics"];
        self.view.backgroundColor = [UIColor brownColor];
        
        self.program = program;
        self.dashletUid = dashletUid;
        
        
        self.labelView = [[iPadProgramLabelView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, kiPadWidthPortrait, 44) dashletNum:self.dashletUid program:self.program];
        [self.view addSubview:self.labelView];

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIScrollView* mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, kiPadWidthPortrait, kiPadHeightPortrait-(44+kiPadTabBarHeight))];
    
    
    mainScrollView.backgroundColor = [UIColor yellowColor];
    mainScrollView.contentSize = CGSizeMake(kiPadWidthPortrait, 1000);
    
    mainScrollView.clipsToBounds = YES;
    
    _dateView = [[iOSDateView alloc] initWithFrame:CGRectMake(0, 0, 200, 140)];
    
    _dateView.month = [self.program.admissionDeadline monthIntegerValue];
    _dateView.date  = [self.program.admissionDeadline dateIntegerValue];
    
    [mainScrollView addSubview:_dateView];
    
    
    
    
    
    [self.view addSubview:mainScrollView];
    
    
}


- (void)setProgram:(Program *)program
{
    _program = program;
    
    _dateView.month = [self.program.admissionDeadline monthIntegerValue];
    _dateView.date  = [self.program.admissionDeadline dateIntegerValue];
    
    
    
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
