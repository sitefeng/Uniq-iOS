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
#import "JPLocation.h"
#import "School.h"
#import "SchoolLocation.h"

#import <MessageUI/MessageUI.h>


@interface iPadProgramHomeViewController ()

@end




const float kProgramImageHeight = 308;
const float kProgramImageWidth  = 384;


@implementation iPadProgramHomeViewController

- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        self.tabBarItem.image = [UIImage imageNamed:@"home"];
        self.view.backgroundColor = [JPStyle colorWith8BitRed:50 green:0 blue:0 alpha:1];
        
        self.program = program;
        self.dashletUid = dashletUid;
        
        
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
        
        self.labelView = [[iPadProgramLabelView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, _screenWidth, 44) dashletNum:self.dashletUid program:self.program];
        
        
        
        //Init Summary View
        NSInteger schoolId = self.dashletUid / 1000000;
        
        NSFetchRequest* req = [[NSFetchRequest alloc] initWithEntityName:@"School"];
        req.predicate = [NSPredicate predicateWithFormat:@"schoolId = %i", schoolId];
        School* school = [[context executeFetchRequest:req error:nil] firstObject];
        
        CGPoint coord = jpp([school.location.lattitude floatValue], [school.location.longitude floatValue]);
        JPLocation* programLocation = [[JPLocation alloc] initWithCooridinates:coord city:school.location.city province:school.location.province];
        
        self.summaryView = [[iPadProgramSummaryView alloc] initWithFrame:CGRectMake(384, kiPadStatusBarHeight+kiPadNavigationBarHeight+44, kProgramImageWidth, kProgramImageHeight) program:self.program location:programLocation];
        self.summaryView.delegate =self;
        
        
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


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.detailView reloadData];
}





#pragma mark - JPProgramSummaryView Delegate methods

- (void)emailButtonTapped
{
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        
        NSString* recipient = self.program.email;
        
        [controller setToRecipients: @[recipient]];
        
        [self presentViewController:controller animated:YES completion:nil];
        
        
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Cannot Send Mail" message:@"Please Add a mail account in Settings app and ensure valid Internet Connection" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
    }

}



- (void)websiteButtonTapped
{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: self.program.website]])
    {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.program.website]];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Cannot Open Webpage" message:@"URL information might not be available" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
    }
    
}



- (void)facebookButtonTapped
{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: self.program.facebookLink]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.program.facebookLink]];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Cannot Open Webpage" message:@"URL information might not be available" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
    }
}


- (void)favoriteButtonTapped
{
    [self.detailView reloadData];
    
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






- (void)viewWillAppear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}



- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}










@end
