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

- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program
{
    self = [super init];
    
    if (self != nil) {
        // Custom initialization
        
        self.tabBarItem.image = [UIImage imageNamed:@"home"];

        UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        context = [delegate managedObjectContext];
        
        self.program = program;
        self.dashletUid = dashletUid;

    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
    
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
    
    
    self.imageController.view.frame = CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight + 44, kProgramImageWidth, kProgramImageHeight);
    
    self.labelView = [[iPadProgramLabelView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, _screenWidth, 44) dashletNum:self.dashletUid program:self.program];
    
    
    //Init Summary View
    NSInteger schoolId = self.dashletUid / 1000000;
    
    NSFetchRequest* req = [[NSFetchRequest alloc] initWithEntityName:@"School"];
    req.predicate = [NSPredicate predicateWithFormat:@"schoolId = %i", schoolId];
    School* school = [[context executeFetchRequest:req error:nil] firstObject];
    
    CGPoint coord = jpp([school.location.lattitude floatValue], [school.location.longitude floatValue]);
    JPLocation* programLocation = [[JPLocation alloc] initWithCooridinates:coord city:school.location.city province:school.location.province];
    
    //Summary View
    self.summaryView = [[JPProgramSummaryView alloc] initWithFrame:CGRectMake(384, kiPadStatusBarHeight+kiPadNavigationBarHeight+44, kProgramImageWidth, kProgramImageHeight) program:self.program location:programLocation];
    self.summaryView.delegate = self;
    
    //Detail View
    float otherTopHeights = kiPadStatusBarHeight+kiPadNavigationBarHeight+44+kProgramImageHeight;
    self.detailView = [[iPadProgramDetailView alloc] initWithFrame:CGRectMake(0,otherTopHeights , _screenWidth, kiPadHeightPortrait - otherTopHeights) andProgram: self.program];
    
    
    [self addChildViewController:self.imageController];
    [self.view addSubview:self.imageController.view];
    
    [self.view addSubview:self.labelView];
    [self.view addSubview:self.summaryView];
    [self.view addSubview:self.detailView];

    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Check if program is favorited
    NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
    favReq.predicate = [NSPredicate predicateWithFormat:@"itemId = %@", [NSNumber numberWithInteger:self.dashletUid]];
    NSArray* result = [context executeFetchRequest:favReq error:nil];
    
    if(!result || [result count] == 0)
    {
        self.summaryView.isFavorited = NO;
    }
    else if(result.count == 1)
    {
        self.summaryView.isFavorited = YES;
    }
    else {
        self.summaryView.isFavorited = YES;
        NSLog(@"Error: TOO many results!");
    }
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


- (void)favoriteButtonSelected:(BOOL)isSelected
{
    if(isSelected)
    {
        NSEntityDescription* newFavItemDes = [NSEntityDescription  entityForName:@"UserFavItem" inManagedObjectContext:context];
        UserFavItem* newItem = (UserFavItem*)[[NSManagedObject alloc] initWithEntity:newFavItemDes insertIntoManagedObjectContext:context];
        
        newItem.itemId = [NSNumber numberWithInteger:self.dashletUid];
        newItem.type = [NSNumber numberWithInteger:JPDashletTypeProgram];
        
        [context insertObject:newItem];
        
        self.summaryView.isFavorited = YES;
    }
    else //deselected
    {
        NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
        favReq.predicate = [NSPredicate predicateWithFormat:@"itemId = %@", [NSNumber numberWithInteger:self.dashletUid]];
        NSArray* results = [context executeFetchRequest:favReq error:nil];
        
        for(UserFavItem* item in results)
        {
            [context deleteObject:item];
        }
        
        self.summaryView.isFavorited = NO;
    }
    
    NSError* error = nil;
    [context save:&error];
    if(error)
    {
        NSLog(@"fav error: %@\n", error);
    }
    
    
//    //Test adding Favorite to core data
//    NSFetchRequest* allfavReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
//    NSArray* allresults = [context executeFetchRequest:allfavReq error:nil];
//    
//    for(UserFavItem* item in allresults)
//    {
//        NSLog(@"ALL FAV#: [%@], type[%@] \n", item.itemId, item.type);
//    }
//    
//    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    
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
