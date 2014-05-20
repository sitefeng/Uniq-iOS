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
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    JumpPadAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [delegate managedObjectContext];
    
    NSInteger schoolId = self.dashletUid / 1000000;
    
    NSFetchRequest* req = [[NSFetchRequest alloc] initWithEntityName:@"School"];
    req.predicate = [NSPredicate predicateWithFormat:@"schoolId = %i", schoolId];
    School* school = [[context executeFetchRequest:req error:nil] firstObject];
    
    SchoolLocation* location = school.location;
    CGPoint coord = jpp([location.lattitude floatValue], [location.longitude floatValue]);

    ////////////////////////////////////////
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(10, kiPadStatusBarHeight+kiPadNavigationBarHeight+44 + 10, 512 -20, 512 - 20)];
    
    self.mapView.mapType = MKMapTypeStandard;
    
    NSLog(@"COORD: %f, %f", coord.x, coord.y);
    CLLocationCoordinate2D mapCenter = CLLocationCoordinate2DMake(coord.x, coord.y);
    
    self.mapView.region = MKCoordinateRegionMakeWithDistance(mapCenter, 100, 100);
    
    
    
    
    
    
    
    
    [self.view addSubview:self.mapView];
    
    
    
    
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
