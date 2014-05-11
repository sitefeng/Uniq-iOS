//
//  iPadProgramHomeViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramHomeViewController.h"

#import "JPFont.h"
#import "JPStyle.h"

#import "iPadProgramImagesViewController.h"
#import "iPadProgramLabelView.h"
#import "iPadProgramSummaryView.h"
#import "iPadProgramDetailView.h"

#import "iPadProgramViewController.h"

#import "Program.h"



@interface iPadProgramHomeViewController ()

@end




const float kProgramImageHeight = 308;
const float kProgramImageWidth  = 384;


@implementation iPadProgramHomeViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        self.tabBarItem.image = [UIImage imageNamed:@"home"];
        self.view.backgroundColor = [UIColor greenColor];
        
        
//        iPadProgramViewController* tabController = (iPadProgramViewController*)self.tabBarController;
//        self.programId = tabController.programId;
        
        self.programId = 221;
        
        
        JumpPadAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        context = [delegate managedObjectContext];
        
        
        //Update Program Info from Core Data
        [self updateProgram];
        
        
        
        
        //Getting current device orientation
        if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation))
        {
            _isOrientationPortrait = YES;
            _screenWidth = kiPadWidthPortrait;
        }
        else
        {
            _isOrientationPortrait = NO;
            _screenWidth = kiPadWidthLandscape;
        }
        
        
        self.imageController = [[iPadProgramImagesViewController alloc] init];
        self.imageController.program = self.program;
        
        
        if(_isOrientationPortrait)
        {
            self.imageController.view.frame = CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight + 44, kProgramImageWidth, kProgramImageHeight);
        }
        else
        {
            self.imageController.view.frame = CGRectMake(0, kiPadStatusBarHeight+ kiPadNavigationBarHeight, kProgramImageWidth, kProgramImageHeight);
        }
        
        self.labelView = [[iPadProgramLabelView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, _screenWidth, 44)];
        self.labelView.program = self.program;
        
        
        self.summaryView = [[iPadProgramSummaryView alloc] initWithFrame:CGRectMake(384, kiPadStatusBarHeight+kiPadNavigationBarHeight+44, kProgramImageWidth, kProgramImageHeight)];
        self.summaryView.program = self.program;
        
        
        float otherTopHeights = kiPadStatusBarHeight+kiPadNavigationBarHeight+44+kProgramImageHeight;
        
        self.detailView = [[iPadProgramDetailView alloc] initWithFrame:CGRectMake(0,otherTopHeights , _screenWidth, kiPadHeightPortrait - otherTopHeights) andProgram: self.program];
        
        
        [self addChildViewController:self.imageController];
        [self.view addSubview:self.imageController.view];
        
        [self.view addSubview:self.labelView];
        [self.view addSubview:self.summaryView];
        [self.view addSubview:self.detailView];


        
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}





- (void)updateProgram
{
    self.program = nil;
    
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Program"];
    request.predicate = [NSPredicate predicateWithFormat:@"programId = %i", self.programId];
    
    NSError* error = nil;
    NSArray* results = [context executeFetchRequest:request error:&error];
    if(error)
    {
        JPLog(@"update Program ERROR: %@", error);
    }
    
    self.program = results[0];
    
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
