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

@interface iPhSchoolHomeViewController ()

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
    
    _panImageView = [[iPhImagePanView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight - 240, kiPhoneWidthPortrait, 270) offset:0];
    
    if(self.type == JPDashletTypeFaculty)
        _panImageView.faculty = self.faculty;
    else
        _panImageView.school = self.school;
    
    UIPanGestureRecognizer* panRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewPanned:)];
    [_panImageView addGestureRecognizer:panRec];
    [self.view addSubview:_panImageView];
    
    
    UIScrollView* detailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait-30)];
    [self.view addSubview:detailScrollView];
    
    JPSchoolSummaryView* summaryView = [[JPSchoolSummaryView alloc] initWithFrame:CGRectMake(-10, 0, kiPhoneWidthPortrait+10, 280) isPhoneInterface:YES];
    summaryView.delegate = self;
    if(self.type == JPDashletTypeFaculty)
        summaryView.faculty=self.faculty;
    else
        summaryView.school=self.school;
    
    
    [detailScrollView addSubview:summaryView];
    
    
    
    [self.view bringSubviewToFront:_panImageView];
}



- (void)websiteButtonTapped
{
    NSURL* url = nil;
    if(self.type == JPDashletTypeFaculty)
        url = [NSURL URLWithString:self.faculty.website];
    else
        url = [NSURL URLWithString:self.school.website];
    [JPGlobal openURL:url];
}



- (void)facebookButtonTapped
{
    NSURL* url = nil;
    if(self.type == JPDashletTypeFaculty)
        url = [NSURL URLWithString:self.faculty.facebookLink];
    else
        url = [NSURL URLWithString:self.school.facebookLink];
    [JPGlobal openURL:url];
}


- (void)twitterButtonTapped
{
    NSURL* url = nil;
    if(self.type == JPDashletTypeFaculty)
        url = [NSURL URLWithString:self.faculty.twitterLink];
    else
        url = [NSURL URLWithString:self.school.twitterLink];
    
    [JPGlobal openURL:url];
}



- (void)favoriteButtonSelected:(BOOL)isSelected
{
    //NOT USING
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
