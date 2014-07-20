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
        self.school = program.faculty.school;

        _itemType = JPDashletTypeProgram;
        
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
        
        _faculty = faculty;
        self.school  = faculty.school;
        _itemType = JPDashletTypeFaculty;
        
    }
    return self;
}

- (void)setSchool:(School *)school
{
    _school = school;
    _itemType = JPDashletTypeSchool;
    
    JPLocation* schoolLocation = [[JPLocation alloc] initWithCooridinates:CGPointMake([school.location.lattitude floatValue], [school.location.longitude floatValue]) city:school.location.city province:school.location.province];
    
    UniqAppDelegate* delegate= (UniqAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [delegate managedObjectContext];
    NSFetchRequest* userRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSArray* userArray = [context executeFetchRequest:userRequest error:nil];
    User* user = nil;
    if([userArray count] >0)
    {
        user = [userArray firstObject];
        if([user.latitude floatValue] == 0 || [user.longitude floatValue] == 0)
            self.distanceToHome = -1;
        else
            self.distanceToHome = [schoolLocation distanceToCoordinate:CGPointMake([user.latitude doubleValue], [user.longitude doubleValue])];
    }
    else
    {
        self.distanceToHome = -1;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}




- (NSArray*)getInformationArrayOfType: (NSString*)arrayType
{
    NSString* address = [NSString stringWithFormat:@"%@ %@,\n%@, %@, %@\n",self.school.location.streetNum, self.school.location.streetName, self.school.location.city, self.school.location.province, self.school.location.country];
    //TODO: add Postal Code and unit/ apt
    
    NSString* distanceToHomeString = @"-- kms Away";
    if(self.distanceToHome >= 0)
    {
        distanceToHomeString = [NSString stringWithFormat:@"%.00f kms Away", self.distanceToHome];
    }
    
    if(_itemType == JPDashletTypeProgram)
    {
        if([arrayType isEqual:@"imageNames"])
        {
            return @[@"address-50", @"distance-50",@"phoneIcon",@"faxIcon",@"email",@"safariIcon",@"facebookIcon",@"twitterIcon"];
        }
        else if([arrayType isEqual:@"labelNames"])
        {
            return @[_school.name, @"Distance",@"Phone",@"Fax",@"Email",@"Website",@"Facebook Group",@"Twitter"];
        }
        else //Array of Values
        {
            return @[address, distanceToHomeString, [NSString stringWithFormat:@"%i", [self.program.phone intValue]], [NSString stringWithFormat:@"%i", [self.program.fax intValue]], self.program.email, self.program.website, self.program.facebookLink, self.program.twitterLink];
        }
        
    }
    else if(_itemType == JPDashletTypeSchool)
    {
        if([arrayType isEqual:@"imageNames"])
        {
            return @[@"address-50", @"distance-50",@"safariIcon",@"facebookIcon",@"twitterIcon"];
        }
        else if([arrayType isEqual:@"labelNames"])
        {
            return @[_school.name, @"Distance",@"Website",@"Facebook Group",@"Twitter"];
        }
        else //Array of Values
        {
            return @[address, distanceToHomeString, _school.website, _school.facebookLink, _school.twitterLink];
        }
        
    }
    else // type faculty
    {
        if([arrayType isEqual:@"imageNames"])
        {
            return @[@"address-50", @"distance-50",@"safariIcon",@"facebookIcon",@"twitterIcon"];
        }
        else if([arrayType isEqual:@"labelNames"])
        {
            return @[_school.name, @"Distance",@"Website",@"Facebook Group",@"Twitter"];
        }
        else //Array of Values
        {
            return @[address, distanceToHomeString, _faculty.website, _faculty.facebookLink, _faculty.twitterLink];
        }
        
    }
    
    return @[];
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
