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
    NSString* address = [NSString stringWithFormat:@"%@,\n%@, %@, %@\n%@", self.schoolLocation.streetName, self.schoolLocation.city, self.schoolLocation.region, self.schoolLocation.country, self.schoolLocation.postalCode];
    
    NSString* distanceToHomeString = @"-- kms Away";
    if(self.distanceToHome >= 0)
    {
        distanceToHomeString = [NSString stringWithFormat:@"%.00f kms Away", self.distanceToHome];
    }
    

    if(!self.program && !self.faculty && !self.school)
        return nil;
    
    if([arrayType isEqual:@"imageNames"])
    {
        return @[@"address-50", @"distance-50",@"phoneIcon", @"email",@"safariIcon",@"facebookIcon",@"twitterIcon", @"linkedinIcon"];
    }
    else if([arrayType isEqual:@"labelNames"])
    {
        return @[self.name, @"Distance",@"Phone",@"Email",@"Website",@"Facebook Group",@"Twitter", @"LinkedIn"];
    }
    else //Array of Values
    {
        NSString* phoneString = [self.contactInfo phone];
        if(![[self.contactInfo phoneExt] isEqual:@""])
            phoneString = [NSString stringWithFormat:@"%@ex.%@", [self.contactInfo phone], [self.contactInfo phoneExt]];
        
        return [NSArray arrayWithObjectsCount:8 replaceNilWithEmptyString:
                address,
                distanceToHomeString,
                phoneString,
                [self.contactInfo email],
                [self.contactInfo website],
                [self.contactInfo facebook],
                [self.contactInfo twitter],
                [self.contactInfo linkedin], nil];

    }
    
    
    return @[];
}




#pragma mark - Setter Methods

- (void)setSchool:(School *)school
{
    _school = school;
    _itemType = JPDashletTypeSchool;
    
    self.schoolLocation = school.location;
    NSArray* contacts = [school.contacts allObjects];
    self.contactInfo = [contacts firstObject];
    self.name = school.name;
}


- (void)setFaculty:(Faculty *)faculty
{
    _faculty = faculty;
    _itemType = JPDashletTypeFaculty;
    
    self.schoolLocation = _faculty.location;
    NSArray* contacts = [faculty.contacts allObjects];
    self.contactInfo = [contacts firstObject];
    self.name = faculty.name;
}


- (void)setProgram:(Program *)program
{
    _program = program;
    _itemType = JPDashletTypeProgram;
    
    self.schoolLocation = program.location;
    NSArray* contacts = [program.contacts allObjects];
    self.contactInfo = [contacts firstObject];
    self.name = program.name;
}


- (void)setSchoolLocation:(SchoolLocation *)schoolLocation
{
    _schoolLocation = schoolLocation;
    
    self.location = [[JPLocation alloc] initWithCooridinates:CGPointMake([schoolLocation.latitude floatValue], [schoolLocation.longitude floatValue]) city:schoolLocation.city province:schoolLocation.region];
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
