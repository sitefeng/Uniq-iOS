//
//  iPadProgramContactViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramContactViewController.h"
#import <MapKit/MapKit.h>

#import "Program.h"
#import "SchoolLocation.h"
#import "School.h"

#import "JPFont.h"
#import "JPStyle.h"

#import "iPadProgramLabelView.h"


@interface iPadProgramContactViewController ()

@end

@implementation iPadProgramContactViewController

- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program;
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        self.tabBarItem.image = [UIImage imageNamed:@"contact"];
        
        
        self.program = program;
        self.dashletUid = dashletUid;
        
        
        
        
        
        
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor lightGrayColor];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"greyBackground"]];
    self.view.backgroundColor = [JPStyle colorWithHex:@"D1FFDA" alpha:1];
    
    JumpPadAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [delegate managedObjectContext];
    
    NSInteger schoolId = self.dashletUid / 1000000;
    
    NSFetchRequest* req = [[NSFetchRequest alloc] initWithEntityName:@"School"];
    req.predicate = [NSPredicate predicateWithFormat:@"schoolId = %i", schoolId];
    School* school = [[context executeFetchRequest:req error:nil] firstObject];
    _school = school;
    SchoolLocation* location = school.location;
    _schoolLocation = location;
    CGPoint coord = jpp([location.lattitude floatValue], [location.longitude floatValue]);

    ////////////////////////////////////////
    
    
    self.labelView = [[iPadProgramLabelView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, kiPadWidthPortrait, 44) dashletNum:self.dashletUid program:self.program];
    
    [self.view addSubview:self.labelView];
    
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(10, kiPadStatusBarHeight+kiPadNavigationBarHeight+44 + 10, 512 -20, 512 - 20)];
    self.mapView.mapType = MKMapTypeStandard;
    CLLocationCoordinate2D mapCenter = CLLocationCoordinate2DMake(coord.x, coord.y);
    self.mapView.region = MKCoordinateRegionMakeWithDistance(mapCenter, 1500, 1500);
    
    [self.view addSubview:self.mapView];
    
    
    NSArray* imageNames = @[@"address-50", @"distance-50",@"phone-50",@"fax-50",@"email-50",@"safari-50",@"facebook-50",@"twitter-50"];
    NSArray* labelNames = @[@"Address", @"Distance",@"Phone",@"Fax",@"Email",@"Website",@"Facebook Group",@"Twitter"];
    
    
    NSString* address = [NSString stringWithFormat:@"%@ %@,\n%@, %@, %@\n",_schoolLocation.streetNum, _schoolLocation.streetName, _schoolLocation.city, _schoolLocation.province, _schoolLocation.country];
    //TODO: add Postal Code and unit/ apt
    
    NSArray* values   = @[address, @"35kms away", [NSString stringWithFormat:@"%i", [self.program.phone intValue]], [NSString stringWithFormat:@"%i", [self.program.fax intValue]], self.program.email, self.program.website, self.program.facebookLink, self.program.twitterLink];

    float y1 = 630;
    float y2 = 125;
    
    for(int i=0; i<[imageNames count]; i++)
    {
        UIButton* iconButton = [[UIButton alloc] init];
        [iconButton setImage:[UIImage imageNamed:[imageNames objectAtIndex:i]] forState:UIControlStateNormal];
        [iconButton setAccessibilityLabel:[labelNames objectAtIndex:i]];
        [iconButton addTarget:self action:@selector(iconTappedWithIndex:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel* label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont fontWithName:[JPFont defaultThinFont] size:19];
        label.text = labelNames[i];
        
        UITextView* textView = [[UITextView alloc] init];
        textView.font = [UIFont fontWithName:[JPFont defaultThinFont] size:19];
        [textView setEditable:NO];
        textView.text = values[i];
        textView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
        

        
        if(i<2)
        {
            iconButton.frame = CGRectMake(10, y1, 40, 40);
            label.frame = CGRectMake(60, y1-5, 430, 25);
            textView.frame  = CGRectMake(60, y1+16 , 430, 65);
            [textView sizeToFit];
            
            float textViewHeight = textView.frame.size.height;
            y1 += 16 + textViewHeight + 10;
        }
        else
        {
            iconButton.frame = CGRectMake(520, y2 , 40, 40);
            label.frame = CGRectMake(574, y2-5, 185, 25);
            textView.frame  = CGRectMake(574, y2+16, 185, 95);
            [textView sizeToFit];
            
            float textViewHeight = textView.frame.size.height;
            y2 += 16 + textViewHeight + 15;
        }
        
        
        
        
        [self.view addSubview:iconButton];
        [self.view addSubview:label];
        [self.view addSubview:textView];
        
    }
    
    
    
    
    
    
}



- (void)iconTappedWithIndex: (UIButton*) button
{
    
    
    
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
