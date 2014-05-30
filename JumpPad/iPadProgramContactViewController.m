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

- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program
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
    
//    UIImage* backgroundImage = [[UIImage imageNamed:@"blueBackground"] applyBlurWithRadius:8 tintColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3]  saturationDeltaFactor:1.5 maskImage:nil];
    
    UIImage* backgroundImage = [UIImage imageNamed:@"blueBackground2"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
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
    
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(10, kiPadStatusBarHeight+kiPadNavigationBarHeight+44 + 10, 462 -20, 502 - 20)];
    self.mapView.layer.cornerRadius = 20;
    self.mapView.clipsToBounds = YES;
    self.mapView.mapType = MKMapTypeStandard;
    _mapCenterCoord = CLLocationCoordinate2DMake(coord.x, coord.y);
    
    self.mapView.region = MKCoordinateRegionMakeWithDistance(_mapCenterCoord, 1500, 1500);
    self.mapView.clipsToBounds = YES;
    
    [self.view addSubview:self.mapView];
    
    
    NSArray* imageNames = @[@"address-50", @"distance-50",@"phone-50",@"fax-50",@"email-50",@"safari-50",@"facebook-50",@"twitter-50"];
    NSArray* labelNames = @[_school.name, @"Distance",@"Phone",@"Fax",@"Email",@"Website",@"Facebook Group",@"Twitter"];
    
    
    NSString* address = [NSString stringWithFormat:@"%@ %@,\n%@, %@, %@\n",_schoolLocation.streetNum, _schoolLocation.streetName, _schoolLocation.city, _schoolLocation.province, _schoolLocation.country];
    //TODO: add Postal Code and unit/ apt
    
    NSArray* values   = @[address, @"35kms away", [NSString stringWithFormat:@"%i", [self.program.phone intValue]], [NSString stringWithFormat:@"%i", [self.program.fax intValue]], self.program.email, self.program.website, self.program.facebookLink, self.program.twitterLink];

    float y2 = 125;
    
    for(int i=2; i<[imageNames count]; i++)
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
        textView.font = [UIFont fontWithName:[JPFont defaultThinFont] size:15];
        [textView setEditable:NO];
        textView.text = values[i];
        textView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
        
        if(i>=2)
        {
            iconButton.frame = CGRectMake(470, y2 , 40, 40);
            label.frame = CGRectMake(524, y2-5, 210, 25);
            textView.frame  = CGRectMake(524, y2+16, 230, 95);
            textView.layer.cornerRadius = 10;
            textView.clipsToBounds = YES;
            [textView sizeToFit];
            
            float textViewHeight = textView.frame.size.height;
            y2 += 16 + textViewHeight + 15;
        }
        
        
        
        
        [self.view addSubview:iconButton];
        [self.view addSubview:label];
        [self.view addSubview:textView];
        
    }
    
    //*******************************************************************
    //white veil
    CGRect mapFrame = self.mapView.frame;

    _mapBarView = [[UIView alloc] initWithFrame:CGRectMake(0, mapFrame.size.height - 55, mapFrame.size.width, 150)];
    _mapBarView.layer.cornerRadius = 14;
    _mapBarView.clipsToBounds = YES;
    
    _mapBarPosition = _mapBarView.frame.origin.y;
    
    _mapBarView.backgroundColor = [JPStyle colorWithHex:@"FFFFFF" alpha:0.7];
    
    UIButton* iconButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
    [iconButton setImage:[UIImage imageNamed:[imageNames objectAtIndex:0]] forState:UIControlStateNormal];
    [iconButton setAccessibilityLabel:[labelNames objectAtIndex:0]];
    [iconButton addTarget:self action:@selector(iconTappedWithIndex:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* schoolLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, 280, 25)];
    schoolLabel.textColor = [UIColor blackColor];
    schoolLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:19];
    schoolLabel.text = labelNames[0];
    
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(55, 45, 330, 90)];
    textView.font = [UIFont fontWithName:[JPFont defaultThinFont] size:19];
    [textView setEditable:NO];
    textView.text = values[0];
    textView.backgroundColor = [UIColor clearColor];
    
    UIImageView* reorderImg = [[UIImageView alloc] initWithFrame:CGRectMake(mapFrame.size.width - 50, 5, 45, 45)];
    reorderImg.image = [UIImage imageNamed:@"reorder"];
    
    [_mapBarView addSubview:iconButton];
    [_mapBarView addSubview:schoolLabel];
    [_mapBarView addSubview:textView];
    [_mapBarView addSubview:reorderImg];
    
    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(mapDescriptionPan:)];
    [_mapBarView addGestureRecognizer:panRecognizer];
    
    
    UIButton* locate = [[UIButton alloc] initWithFrame:CGRectMake(self.mapView.frame.size.width - 100, 10, 40, 40)];
    [locate setImage:[UIImage imageNamed:@"locate-50"] forState:UIControlStateNormal];
    [locate addTarget:self action:@selector(locateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [_mapBarView addSubview:locate];
    
    // Other view
    UIView* distanceView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 100, 32)];
    distanceView.backgroundColor = _mapBarView.backgroundColor;
    distanceView.layer.cornerRadius = 14;
    distanceView.clipsToBounds = YES;
    
    UIImageView* distanceImg = [[UIImageView alloc] initWithFrame:CGRectMake(3, 1, 30, 30)];
    distanceImg.image = [UIImage imageNamed: imageNames[1]];
    
    UILabel* distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 6, 68, 22)];
    distanceLabel.textColor = [UIColor blackColor];
    distanceLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:15];
    distanceLabel.text = values[1];
    [distanceLabel sizeToFit];
    
    [distanceView addSubview:distanceImg];
    [distanceView addSubview:distanceLabel];

    [distanceView setFrame:CGRectMake(distanceView.frame.origin.x, distanceView.frame.origin.y, distanceLabel.frame.size.width + 32 + 10, distanceView.frame.size.height)];
    
    
    [self.mapView addSubview:_mapBarView];
    
    [self.mapView addSubview:distanceView];
    
    
    
    
}



- (void)iconTappedWithIndex: (UIButton*) button
{
    
    
    
}




- (void)mapDescriptionPan: (UIPanGestureRecognizer*)recognizer
{
    CGRect  pastFrame = _mapBarView.frame;
    CGFloat yPosition = self.mapView.frame.size.height - pastFrame.origin.y;
    
    if(recognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:self.mapView];
        
        if((translation.y >= 0 && yPosition > 55) || (translation.y <= 0 && yPosition < 130)) //going down||going up
        {
            [_mapBarView setFrame:CGRectMake(pastFrame.origin.x, _mapBarPosition + translation.y, pastFrame.size.width, pastFrame.size.height)];
        }
        
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        _mapBarPosition = _mapBarView.frame.origin.y;
        
        if(fabs(_mapBarPosition - yPosition -55) > 2 ||fabs(_mapBarPosition - yPosition - 130) > 2)
        {
            [UIView animateWithDuration:0.2 delay:0 options: UIViewAnimationOptionCurveEaseOut
            animations:^{
                
                if (yPosition > 92)
                {
                    [_mapBarView setFrame:CGRectMake(pastFrame.origin.x, self.mapView.frame.size.height - 130, pastFrame.size.width, pastFrame.size.height)];
                }
                else
                {
                    [_mapBarView setFrame:CGRectMake(pastFrame.origin.x, self.mapView.frame.size.height - 55, pastFrame.size.width, pastFrame.size.height)];
                }
                
            } completion:nil];
        }
        
        _mapBarPosition = _mapBarView.frame.origin.y;
        
    }
    
    
    
}



- (void)locateButtonPressed: (UIButton*) button
{
    
    [self.mapView setCenterCoordinate:_mapCenterCoord animated:YES];
    
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(_mapCenterCoord, 1500, 1500) animated:YES];
    
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
