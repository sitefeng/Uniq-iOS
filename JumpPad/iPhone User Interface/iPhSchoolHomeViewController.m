//
//  iPhSchoolHomeViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhSchoolHomeViewController.h"
#import "Faculty.h"
#import "School.h"
#import "iPhImagePanView.h"
#import "JPSchoolSummaryView.h"

#import "JPGlobal.h"
#import "Contact.h"

@interface iPhSchoolHomeViewController ()

@property (nonatomic, strong) UIScrollView *detailScrollView;
@property (nonatomic, strong) iPhImagePanView *panImageView;
@property (nonatomic, strong) iPhProgramDetailTableView *detailTableView;

@property (nonatomic, strong) NSArray *detailViewTitles;

@end

@implementation iPhSchoolHomeViewController

- (instancetype)initWithFaculty: (Faculty*)faculty
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.faculty = faculty;
        self.school = faculty.school;
        self.type = JPDashletTypeFaculty;
    }
    return self;
}

- (instancetype)initWithSchool: (School*)school
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.school = school;
        self.type = JPDashletTypeSchool;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initializing properties
    self.detailViewTitles = @[@"About", @"Application Process"];
    
    // Setup View
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
    
    _panImageView = [[iPhImagePanView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight - 240, kiPhoneWidthPortrait, 270) offset:0];
    
    if(self.type == JPDashletTypeFaculty)
        _panImageView.faculty = self.faculty;
    else
        _panImageView.school = self.school;
    
    UIPanGestureRecognizer* panRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewPanned:)];
    [_panImageView addGestureRecognizer:panRec];
    [self.view addSubview:_panImageView];
    
    
    self.detailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 30, kiPhoneContentHeightPortrait, kiPhoneContentHeightPortrait-30)];
    [self.view addSubview:self.detailScrollView];
    
    JPSchoolSummaryView* summaryView = [[JPSchoolSummaryView alloc] initWithFrame:CGRectMake(-10, 0, kiPhoneWidthPortrait+10, 280) isPhoneInterface:YES];
    summaryView.delegate = self;
    if(self.type == JPDashletTypeFaculty)
        summaryView.faculty=self.faculty;
    else
        summaryView.school=self.school;
    
    [self.detailScrollView addSubview:summaryView];
    
    
    self.detailTableView = [[iPhProgramDetailTableView alloc] initWithFrame:CGRectMake(0, 310, self.view.frame.size.width, 500) program:self.program];
    self.detailTableView.scrollable = NO;
    self.detailTableView.dataSource = self;
    [self.detailScrollView addSubview:self.detailTableView];
    
    [self.view bringSubviewToFront:_panImageView];
}


#pragma mark - Summary View Callbacks

- (void)websiteButtonTapped
{
    
    NSURL* url = nil;
    if(self.type == JPDashletTypeFaculty)
    {
        Contact* contact = [self.faculty.contacts anyObject];
        url = [NSURL URLWithString:contact.website];
    }
    else
    {
        Contact* contact = [self.school.contacts anyObject];
        url = [NSURL URLWithString:contact.website];

    }
    
    [JPGlobal openURL:url];
}



- (void)facebookButtonTapped
{
    NSURL* url = nil;
    if(self.type == JPDashletTypeFaculty)
    {
        Contact* contact = [self.faculty.contacts anyObject];
        url = [NSURL URLWithString:contact.facebook];
    }
    else
    {
        Contact* contact = [self.school.contacts anyObject];
        url = [NSURL URLWithString:contact.facebook];
    }
    
    [JPGlobal openURL:url];
}


- (void)twitterButtonTapped
{
    NSURL* url = nil;
    if(self.type == JPDashletTypeFaculty)
    {
        Contact* contact = [self.faculty.contacts anyObject];
        url = [NSURL URLWithString:contact.twitter];
    }
    else
    {
        Contact* contact = [self.school.contacts anyObject];
        url = [NSURL URLWithString:contact.twitter];
    }
    
    [JPGlobal openURL:url];
}

- (void)favoriteButtonSelected:(BOOL)isSelected {
    //NOT USING
}


#pragma mark - Program detail table view data source

- (NSInteger)numberOfDashletsInProgramDetailTable:(iPhProgramDetailTableView*)tableView {
    return self.detailViewTitles.count;
}

- (NSString*)programDetailTable:(iPhProgramDetailTableView*)tableView dashletTitleForRow:(NSInteger)row {
    return self.detailViewTitles[row];
}

- (void)programDetailTable: (iPhProgramDetailTableView*)tableView didFindMaximumHeight: (CGFloat)height {
    self.detailScrollView.contentSize = CGSizeMake(self.view.frame.size.width, height);
}


@end
