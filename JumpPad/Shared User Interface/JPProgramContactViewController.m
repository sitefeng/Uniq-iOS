//
//  JPProgramContactViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/19/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPProgramContactViewController.h"
#import "School.h"
#import "Faculty.h"
#import "Program.h"
#import "JPLocation.h"
#import "SchoolLocation.h"
#import "User.h"
#import "Contact.h"
#import "JPCoreDataHelper.h"

#import "Uniq-Swift.h"

@interface JPProgramContactViewController ()

@end

@implementation JPProgramContactViewController

- (id)initWithProgram: (Program*)program
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"contact"];
        self.program = program;
        
        
    }
    return self;
}

- (id)initWithSchool:(School *)school
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"contact"];
        
        self.school = school;
    }
    return self;
}

- (id)initWithFaculty: (Faculty *)faculty
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"contact"];
        self.faculty = faculty;
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (NSArray*)getInformationArrayOfType: (NSString*)arrayType
{
    JPOfflineDataRequest *offlineRequest = [[JPOfflineDataRequest alloc] init];
    self.location = [offlineRequest requestLocationForSchool:self.program.schoolSlug];
    NSString* address = [self.location userVisibleAddressString];
    
    if(!self.program && !self.faculty && !self.school)
        return nil;
    
    if([arrayType isEqual:@"imageNames"])
    {
        return @[@"address-50", @"phoneIcon", @"email",@"safariIcon",@"facebookIcon",@"twitterIcon", @"linkedinIcon"];
    }
    else if([arrayType isEqual:@"labelNames"])
    {
        return @[self.name, @"Phone",@"Email",@"Website",@"Facebook Group",@"Twitter", @"LinkedIn"];
    }
    else if([arrayType isEqual:@"data"])
    {
        
        return [NSArray arrayWithObjectsCount:7 replaceNilWithEmptyString:
                address,
                self.contactInfo.phoneNum,
                self.contactInfo.email,
                self.contactInfo.website,
                self.contactInfo.facebook,
                self.contactInfo.twitter,
                self.contactInfo.linkedin,
                self.contactInfo.extraInfo, nil
                ];

    }
    else //Array of Values
    {
        NSString* phoneString = self.contactInfo.phoneNum;
        if(![self.contactInfo.ext isEqual:@""])
            phoneString = [NSString stringWithFormat:@"%@ ex.%@", self.contactInfo.phoneNum, self.contactInfo.ext];
        
        return [NSArray arrayWithObjectsCount:7 replaceNilWithEmptyString:
                address,
                phoneString,
                self.contactInfo.email,
                self.contactInfo.website,
                self.contactInfo.facebook,
                self.contactInfo.twitter,
                self.contactInfo.linkedin,
                self.contactInfo.extraInfo, nil
                ];

    }
    
    return @[];
}


- (void)reloadViews {
    NSAssert(false, @"Method Unimplemented");
}


#pragma mark - Setter Methods

- (void)setSchool:(School *)school
{
    _school = school;
    _itemType = JPDashletTypeSchool;
    
    NSArray* contacts = [school.contacts allObjects];
    self.contactInfo = [contacts firstObject];
    self.name = school.name;
}


- (void)setFaculty:(Faculty *)faculty
{
    _faculty = faculty;
    _itemType = JPDashletTypeFaculty;
    
    NSArray* contacts = [faculty.contacts allObjects];
    self.contactInfo = [contacts firstObject];
    self.name = faculty.name;
}


- (void)setProgram:(Program *)program
{
    _program = program;
    _itemType = JPDashletTypeProgram;
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        JPOfflineDataRequest *dataRequest = [[JPOfflineDataRequest alloc] init];
        __block JPContact *contact = [dataRequest requestContactForFaculty:program.schoolSlug facultySlug:program.facultySlug];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.contactInfo = contact;
            [self reloadViews];
        });
    });
    
    self.name = program.name;
}


- (void)setLocation:(JPLocation *)location
{
    _location = location;
    
    JPCoreDataHelper* coreDataHelper = [[JPCoreDataHelper alloc] init];
    self.distanceToHome = [coreDataHelper distanceToUserLocationWithLocation:location];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
