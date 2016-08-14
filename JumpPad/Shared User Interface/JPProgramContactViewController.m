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


static NSString *const NotAvailableString = @"Not Available";

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
    
    NSString *phoneNum = self.contactInfo.phoneNum;
    if (phoneNum.length == 0) { phoneNum = NotAvailableString; }
    
    NSString *email = self.contactInfo.email;
    if (email.length == 0) { email = NotAvailableString; }
    
    NSString *website = self.contactInfo.website;
    if (website.length == 0) { website = NotAvailableString; }
    
    NSString *facebook = self.contactInfo.facebook;
    if (facebook.length == 0) { facebook = NotAvailableString; }
    
    NSString *twitter = self.contactInfo.twitter;
    if (twitter.length == 0) { twitter = NotAvailableString; }
    
    NSString *linkedin = self.contactInfo.linkedin;
    if (linkedin.length == 0) { linkedin = NotAvailableString; }
    
    NSString *extraInfo = self.contactInfo.extraInfo;
    if (extraInfo.length == 0) { extraInfo = NotAvailableString; }
    
    NSMutableArray *dataArray = [@[ address,
                                    phoneNum,
                                    email,
                                    website,
                                    facebook,
                                    twitter,
                                    linkedin,
                                    extraInfo
                                  ] mutableCopy];
    
    if([arrayType isEqual:@"imageNames"])
    {
        return @[@"address-50", @"phoneIcon", @"email",@"safariIcon",@"facebookIcon",@"twitterIcon", @"linkedinIcon", @"info-75"];
    }
    else if([arrayType isEqual:@"labelNames"])
    {
        return @[self.name, @"Phone",@"Email",@"Website",@"Facebook Group",@"Twitter", @"LinkedIn", @"Extra Information"];
    }
    else if([arrayType isEqual:@"data"]) //eg to just get the phone number, as opposed to extension
    {
        return dataArray;
    }
    else //Array of Values
    {
        NSString* phoneString = self.contactInfo.phoneNum;
        if(![self.contactInfo.ext isEqual:@""])
            phoneString = [NSString stringWithFormat:@"%@ ex.%@", self.contactInfo.phoneNum, self.contactInfo.ext];
        
        [dataArray replaceObjectAtIndex:1 withObject:phoneString];
        return dataArray;
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
    
    _name = program.name;
    
    if (JPUtility.isOfflineMode) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            JPOfflineDataRequest *request = [[JPOfflineDataRequest alloc] init];
            __block JPLocation *newLocation = [request requestLocationForSchool:self.program.schoolSlug];
            __block JPContact *newContact = [request requestContactForFaculty:program.schoolSlug facultySlug:program.facultySlug];
            _location = newLocation;
            _contactInfo = newContact;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadViews];
            });
        });
    } else {
        //TODO request updated info form server
        
        // Implementation
    }
    
}


@end
