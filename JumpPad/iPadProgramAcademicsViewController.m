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
    
    
    UIScrollView* mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, kiPadWidthPortrait, kiPadHeightPortrait-44)];
    
    
    mainScrollView.backgroundColor = [UIColor yellowColor];
    mainScrollView.contentSize = CGSizeMake(kiPadWidthPortrait, 1000);
    
    mainScrollView.clipsToBounds = YES;
    
    _dateView = [[iOSDateView alloc] initWithFrame:CGRectMake(0, 0, 200, 140)];
    
    _dateView.month = [self.program.admissionDeadline monthIntegerValue];
    _dateView.date  = [self.program.admissionDeadline dateIntegerValue];
    
    [mainScrollView addSubview:_dateView];
    
    
    UIView* calendarBackground = [[UIView alloc] initWithFrame:CGRectMake(_dateView.frame.size.width, 0, kiPadWidthPortrait - _dateView.frame.size.width, _dateView.frame.size.height)];
    calendarBackground.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"whiteBackground"]];
    
    
    UILabel* calendarLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 14, 400, 40)];
    
    calendarLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:25];
    
    calendarLabel.textColor = [UIColor blackColor];
    
    calendarLabel.textAlignment = NSTextAlignmentLeft;
    calendarLabel.text = @"Application Process";
    
    [calendarBackground addSubview:calendarLabel];
    
    NSArray* processNames = [NSArray arrayWithObjects: @"Favorited",@"Researched",@"Applied",@"Response",@"Got Offer", nil];
    
    for(int i= 0; i<5; i++)
    {
        UIButton* processButton = [[UIButton alloc] initWithFrame:CGRectMake(30 + i*calendarBackground.frame.size.width/5, 65, 44, 44)];
        
        [processButton setBackgroundImage:[UIImage imageNamed:@"itemIncomplete"] forState:UIControlStateNormal];
        processButton.tag = i;
        
        [processButton addTarget:self action:@selector(calendarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [calendarBackground addSubview:processButton];
        
        
        UILabel* processLabel = [[UILabel alloc] initWithFrame:CGRectMake(processButton.frame.origin.x - 20, processButton.frame.origin.y + processButton.frame.size.height + 4, processButton.frame.size.width + 40, 20)];
        processLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:15];
        processLabel.textAlignment = NSTextAlignmentCenter;
        processLabel.text = [processNames objectAtIndex:i];
        [calendarBackground addSubview:processLabel];
    }
    
    
    UIView* blueBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, calendarBackground.frame.size.width, 5)];
    blueBar.backgroundColor = [JPStyle colorWithName:@"blue"];
    UIView* blueBar2 = [[UIView alloc] initWithFrame:CGRectMake(0, calendarBackground.frame.size.height - 5, calendarBackground.frame.size.width, 5)];
    blueBar2.backgroundColor = [JPStyle colorWithName:@"blue"];
    
    [calendarBackground addSubview:blueBar];
    [calendarBackground addSubview:blueBar2];
    
    
    [mainScrollView addSubview:calendarBackground];
    
    [self.view addSubview:mainScrollView];
    
    
    
    
    
    _calButtonSelected = [NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0, nil];
    
    
    
   
    
    
    
}


- (void)setProgram:(Program *)program
{
    _program = program;
    
    _dateView.month = [self.program.admissionDeadline monthIntegerValue];
    _dateView.date  = [self.program.admissionDeadline dateIntegerValue];
    
    
    
}


- (void)calendarButtonPressed: (UIButton*)button
{
    
    [UIView animateWithDuration:1500 animations:^{
        
        if([_calButtonSelected[button.tag] boolValue] == false)
        {
            [button setBackgroundImage:[UIImage imageNamed:@"itemComplete"] forState:UIControlStateNormal];
            [_calButtonSelected replaceObjectAtIndex:button.tag withObject:[NSNumber numberWithBool:YES]];
        }
        else
        {
            [button setBackgroundImage:[UIImage imageNamed:@"itemIncomplete"] forState:UIControlStateNormal];
            [_calButtonSelected replaceObjectAtIndex:button.tag withObject:[NSNumber numberWithBool:NO]];
        }
        
    } completion:nil];

    

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
