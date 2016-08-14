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
#import "JPProgramSummaryView.h"
#import "iPadProgramDetailView.h"

#import "iPadProgramViewController.h"

#import "Program.h"
#import "JPLocation.h"
#import "School.h"
#import "SchoolLocation.h"
#import "UserFavItem.h"

#import <MessageUI/MessageUI.h>


@interface iPadProgramHomeViewController ()

@end




static const float kProgramImageHeight = 308;
static const float kProgramImageWidth  = 384;


@implementation iPadProgramHomeViewController

- (id)initWithProgram: (Program*)program
{
    self = [super init];
    
    if (self != nil) {
        // Custom initialization
        
        self.tabBarItem.image = [UIImage imageNamed:@"home"];

        UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        context = [delegate managedObjectContext];
        
        _coreDataHelper = [[JPCoreDataHelper alloc] init];
        
        self.program = program;

    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
    
    self.imageController = [[iPadProgramImagesViewController alloc] init];
    self.imageController.program = self.program;
    self.imageController.view.frame = CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, kProgramImageWidth, kProgramImageHeight);
    
    //Summary View
    self.summaryView = [[JPProgramSummaryView alloc] initWithFrame:CGRectMake(384, kiPadStatusBarHeight+kiPadNavigationBarHeight, kProgramImageWidth, kProgramImageHeight) program:self.program];
    self.summaryView.delegate = self;
    
    //Detail View
    float otherTopHeights = kiPadStatusBarHeight+kiPadNavigationBarHeight+kProgramImageHeight;
    self.detailView = [[iPadProgramDetailView alloc] initWithFrame:CGRectMake(0,otherTopHeights , kiPadWidthPortrait, kiPadHeightPortrait - otherTopHeights) andProgram: self.program];
    
    
    [self addChildViewController:self.imageController];
    [self.view addSubview:self.imageController.view];
    [self.view addSubview:self.summaryView];
    [self.view addSubview:self.detailView];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Check if program is favorited
    
    self.summaryView.isFavorited = [_coreDataHelper isFavoritedWithItemId:self.program.programId];
    
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
        Contact* contact = [self.program.contacts anyObject];
        NSString* recipient = contact.email;
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
    Contact* contact = [self.program.contacts anyObject];
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: contact.website]])
    {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:contact.website]];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Cannot Open Webpage" message:@"URL information might not be available" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
    }
    
}



- (void)facebookButtonTapped
{
    Contact* contact = [self.program.contacts anyObject];
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: contact.facebook]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:contact.facebook]];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Cannot Open Webpage" message:@"URL information might not be available" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
    }
}


- (void)favoriteButtonSelected:(BOOL)isSelected
{
    if(isSelected)
    {
        [_coreDataHelper addFavoriteWithItemId:self.program.programId andType:JPDashletTypeProgram schoolSlug:self.program.slug facultySlug:nil programSlug:nil];
        
        self.summaryView.isFavorited = YES;
    }
    else //deselected
    {
        [_coreDataHelper removeFavoriteWithItemId:self.program.programId withType:JPDashletTypeProgram];
        
        self.summaryView.isFavorited = NO;
    }
    
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
