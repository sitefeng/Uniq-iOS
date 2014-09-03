//
//  iPadSchoolHomeViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadSchoolHomeViewController.h"

#import "School.h"
#import "JPFont.h"
#import "JPStyle.h"

#import "iPadProgramImagesViewController.h"
#import "iPadProgramLabelView.h"
#import "JPProgramSummaryView.h"
#import "iPadProgramDetailView.h"

#import "iPadProgramViewController.h"
#import "JPLocation.h"
#import "School.h"
#import "Faculty.h"
#import "SchoolLocation.h"
#import "UserFavItem.h"

#import "iPadProgramContactViewController.h"
#import "ManagedObjects+JPConvenience.h"



@interface iPadSchoolHomeViewController ()

@end


static const float kProgramImageHeight = 308;
static const float kProgramImageWidth  = 384;


@implementation iPadSchoolHomeViewController


- (id)initWithItemId:(NSString *)itemId type:(JPDashletType)type
{
    self = [super init];
    
    if(self)
    {
        // Custom initialization
        UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        context = [delegate managedObjectContext];
        
        _coreDataHelper = [[JPCoreDataHelper alloc] init];
        
        self.itemId = itemId;
        
        //Navbar dismiss button
        UIBarButtonItem* dismissButton = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStyleDone target:self action:@selector(dismissButtonPressed:)];
        self.navigationItem.leftBarButtonItem = dismissButton;
        
        self.tabBarItem.image = [UIImage imageNamed:@"home"];
        
        JPDataRequest* dataReq = [JPDataRequest sharedRequest];
        dataReq.delegate = self;
        
        [dataReq requestItemDetailsWithId:itemId ofType:type];
        
    }
    return self;
}


- (void)dataRequest:(JPDataRequest *)request didLoadItemDetailsWithId:(NSString *)itemId ofType:(JPDashletType)type dataDict:(NSDictionary *)dict isSuccessful:(BOOL)success
{
    _itemType = type;
    
    if(type == JPDashletTypeSchool) // item is a school
    {
        School* school = [[School alloc] initWithDictionary:dict];
        self.school = school;
        
    }
    else if(type == JPDashletTypeFaculty)
    {
        Faculty* faculty = [[Faculty alloc] initWithDictionary:dict];
        self.faculty = faculty;
    }
    
    
    //Set Properties

    if(_itemType == JPDashletTypeFaculty)
    {
        self.title = self.faculty.name;
    }
    else
    {
        self.title = self.school.name;
    }

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];

    self.imageController = [[iPadProgramImagesViewController alloc] init];
    if(_itemType == JPDashletTypeSchool)
        self.imageController.school = self.school;
    else if(_itemType == JPDashletTypeFaculty)
        self.imageController.faculty = self.faculty;
    
    self.imageController.view.frame = CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, kProgramImageWidth, kProgramImageHeight);
    
    
    //Init Summary View
    School* school = self.school;
    
    CGPoint coord = jpp([school.location.latitude floatValue], [school.location.longitude floatValue]);
    _schoolLocation = [[JPLocation alloc] initWithCooridinates:coord city:school.location.city province:school.location.region];
    
    //Summary View
    self.summaryView = [[JPSchoolSummaryView alloc] initWithFrame:CGRectMake(384, kiPadStatusBarHeight+kiPadNavigationBarHeight, kProgramImageWidth, kProgramImageHeight)];
    self.summaryView.delegate = self;
    if(_itemType == JPDashletTypeSchool)
        self.summaryView.school = self.school;
    else
        self.summaryView.faculty = self.faculty;
    
    //Check if program is favorited
    self.summaryView.isFavorited = [_coreDataHelper isFavoritedWithItemId:self.itemId];
    
    
    [self addChildViewController:self.imageController];
    [self.view addSubview:self.imageController.view];
    [self.view addSubview:self.summaryView];

    
    //**********************************************
    //Map View Controller
    if(_itemType == JPDashletTypeFaculty)
    {
        self.contactVC = [[iPadProgramContactViewController alloc] initWithFaculty:_faculty];
    }
    else {
        self.contactVC = [[iPadProgramContactViewController alloc] initWithSchool:self.school];
    }
    
    self.contactVC.view.frame = CGRectMake(0, CGRectGetMaxY(self.summaryView.frame), kiPadWidthPortrait, kiPadHeightPortrait-CGRectGetMaxY(self.summaryView.frame));
    
    [self.view addSubview:self.contactVC.view];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //TODO: reload data for changed favorite button
}




#pragma mark - JPProgramSummaryView Delegate methods

- (void)twitterButtonTapped
{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: [[self.school.contacts anyObject] twitter]]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[self.school.contacts anyObject] twitter]]];
    }
    else
    {
        [self showNoURLAlert];
    }
}


- (void)websiteButtonTapped
{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: [[self.school.contacts anyObject] website]]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[self.school.contacts anyObject] website]]];
    }
    else
    {
        [self showNoURLAlert];
    }
    
}


- (void)facebookButtonTapped
{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: [[self.school.contacts anyObject] facebook]]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[self.school.contacts anyObject] facebook]]];
    }
    else
    {
        [self showNoURLAlert];
    }
}


- (void)showNoURLAlert
{
    [[[UIAlertView alloc] initWithTitle:@"Cannot Open Webpage" message:@"URL information might not be available" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
}


- (void)favoriteButtonSelected:(BOOL)isSelected
{
    if(isSelected)
    {
        [_coreDataHelper addFavoriteWithItemId:self.itemId andType:_itemType];
        self.summaryView.isFavorited = YES;
    }
    else //deselected
    {
        [_coreDataHelper removeFavoriteWithItemId:self.itemId];
        self.summaryView.isFavorited = NO;
    }
    
}


- (void)dismissButtonPressed: (id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - Setter Methods
- (void)setSchool:(School *)school
{
    _school = school;
    _itemType = JPDashletTypeSchool;
}

- (void)setFaculty:(Faculty *)faculty
{
    _faculty = faculty;
    _itemType = JPDashletTypeFaculty;
    _school = faculty.school;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
