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
#import "iPadProgramSummaryView.h"
#import "iPadProgramDetailView.h"

#import "iPadProgramViewController.h"
#import "JPLocation.h"
#import "School.h"
#import "Faculty.h"
#import "SchoolLocation.h"
#import "UserFavItem.h"

#import "iPadProgramContactViewController.h"

@interface iPadSchoolHomeViewController ()

@end


static const float kProgramImageHeight = 308;
static const float kProgramImageWidth  = 384;


@implementation iPadSchoolHomeViewController


- (id)initWithDashletUid: (NSUInteger)dashletUid
{
    self = [super init];
    
    if(self)
    {
        // Custom initialization
        UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        context = [delegate managedObjectContext];
        
        //Navbar dismiss button
        UIBarButtonItem* dismissButton = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStyleDone target:self action:@selector(dismissButtonPressed:)];
        self.navigationItem.leftBarButtonItem = dismissButton;
        
        self.tabBarItem.image = [UIImage imageNamed:@"home"];
        
        _itemType = -1;
        //Getting School/Faculty Info based on dashletUid
        NSUInteger schoolInt = dashletUid/1000000;
        NSUInteger facultyInt = (dashletUid % 1000000) / 1000;
        
        if(facultyInt == 0) // item is a school
        {
            NSFetchRequest* schoolReq = [[NSFetchRequest alloc] initWithEntityName:@"School"];
            schoolReq.predicate = [NSPredicate predicateWithFormat:@"schoolId = %i", schoolInt];
            
            NSArray* schoolResults = [context executeFetchRequest:schoolReq error:nil];
            School* school = [schoolResults firstObject];
            self.school = school;

        }
        else //should be faculty, although a program is possible
        {
            NSFetchRequest* facultyReq = [[NSFetchRequest alloc] initWithEntityName:@"Faculty"];
            facultyReq.predicate = [NSPredicate predicateWithFormat:@"facultyId = %i", facultyInt];
            
            NSArray* facultyResults = [context executeFetchRequest:facultyReq error:nil];
            Faculty* faculty = [facultyResults firstObject];
            self.faculty = faculty;
        }
        
        
        //Set Properties
        self.dashletUid = dashletUid;
        
        if(_itemType == JPDashletTypeFaculty)
        {
            self.title = self.faculty.name;
        }
        else
        {
            self.title = self.school.name;
        }
        
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];

    self.imageController = [[iPadProgramImagesViewController alloc] init];
    self.imageController.school = self.school;
    
    self.imageController.view.frame = CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, kProgramImageWidth, kProgramImageHeight);
    
    
    //Init Summary View
    School* school = self.school;
    
    CGPoint coord = jpp([school.location.lattitude floatValue], [school.location.longitude floatValue]);
    _schoolLocation = [[JPLocation alloc] initWithCooridinates:coord city:school.location.city province:school.location.province];
    
    //Summary View
    self.summaryView = [[iPadSchoolSummaryView alloc] initWithFrame:CGRectMake(384, kiPadStatusBarHeight+kiPadNavigationBarHeight, kProgramImageWidth, kProgramImageHeight)];
    self.summaryView.delegate = self;
    if(_itemType == JPDashletTypeSchool)
        self.summaryView.school = self.school;
    else
        self.summaryView.faculty = self.faculty;
    
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
        NSLog(@"Error: TOO many favorite results!");
    }
    
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
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: self.school.twitterLink]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.school.twitterLink]];
    }
    else
    {
        [self showNoURLAlert];
    }
}


- (void)websiteButtonTapped
{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: self.school.website]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.school.website]];
    }
    else
    {
        [self showNoURLAlert];
    }
    
}


- (void)facebookButtonTapped
{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: self.school.facebookLink]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.school.facebookLink]];
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
        NSEntityDescription* newFavItemDes = [NSEntityDescription  entityForName:@"UserFavItem" inManagedObjectContext:context];
        UserFavItem* newItem = (UserFavItem*)[[NSManagedObject alloc] initWithEntity:newFavItemDes insertIntoManagedObjectContext:context];
        
        newItem.itemId = [NSNumber numberWithInteger:self.dashletUid];
        newItem.type = [NSNumber numberWithInteger:JPDashletTypeSchool];
        
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
