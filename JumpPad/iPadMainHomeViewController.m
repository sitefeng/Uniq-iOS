//
//  iPadMainHomeViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

//#import <CoreLocation/CoreLocation.h>

#import "iPadMainHomeViewController.h"
#import "JumpPadAppDelegate.h"
#import "Program.h"
#import "School.h"
#import "SchoolLocation.h"
#import "SchoolImageLink.h"


@interface iPadMainHomeViewController ()

@property (nonatomic, strong) NSManagedObjectContext* context;

@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, strong) UIButton* button;
@property (nonatomic, strong) UIButton* button3;
@property (nonatomic, strong) UIButton* button2;

@end

@implementation iPadMainHomeViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [JPStyle mainViewControllerDefaultBackgroundColor];
    
    JumpPadAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [appDelegate managedObjectContext];
    
    
    self.textView =[[UITextView alloc] initWithFrame:CGRectMake(50, 50, 700, 700)];
    self.textView.text = @"Stored Information: \n";
    self.textView.contentSize = CGSizeMake(300, 3300);
    [self.textView setUserInteractionEnabled:YES];
    self.textView.editable = NO;
    
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(100, 800, 100, 50)];
    self.button.tintColor = [UIColor blackColor];

    self.button.backgroundColor = [UIColor yellowColor];
    self.button.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.button setTitle:@"Sync" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.button addTarget:self action:@selector(sync:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.button2 = [[UIButton alloc] initWithFrame:CGRectMake(240, 800, 150, 50)];
    self.button2.tintColor = [UIColor blackColor];
    
    self.button2.backgroundColor = [UIColor yellowColor];
    self.button2.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.button2 setTitle:@"Display All Data" forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.button2 addTarget:self action:@selector(fetchStuff:) forControlEvents:UIControlEventTouchUpInside];
    
    self.button3 = [[UIButton alloc] initWithFrame:CGRectMake(430, 800, 100, 50)];
    self.button3.tintColor = [UIColor blackColor];
    
    self.button3.backgroundColor = [UIColor yellowColor];
    self.button3.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.button3 setTitle:@"Delete All" forState:UIControlStateNormal];
    [self.button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.button3 addTarget:self action:@selector(deleteAll:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.textView];
    [self.view addSubview:self.button];
    [self.view addSubview:self.button3];
    [self.view addSubview:self.button2];
    
}




- (void)sync: (UIButton*)sender
{

    NSError* timeModifiedError = nil;
    NSFetchRequest* timeModifiedRequest = [[NSFetchRequest alloc] initWithEntityName:@"School"];
    
    timeModifiedRequest.sortDescriptors = @[ [[NSSortDescriptor alloc] initWithKey:@"schoolId" ascending:YES] ];
    
    timeModifiedRequest.propertiesToFetch = @[@"timeModified"];
    timeModifiedRequest.predicate = [NSPredicate predicateWithValue:YES];
    
    NSArray* results =[self.context executeFetchRequest:timeModifiedRequest error:&timeModifiedError];
    
    if(!results || [results count] == 0)
    {
        results = @[[NSDate distantPast]];
    }
    
    NSDate* timeModified = [results lastObject];
    
    [self sendPostRequestWithName:@"getAllUniversitiesInfo" lastModifiedTime:timeModified];
    
    /////////////////
    //POST Request Sent
    //
    
    //Got the JSON file
    //Store the JSON file in Core Data
    
    //Simulated Data
    NSURL* uniInfoURL = [[NSBundle mainBundle] URLForResource:@"getAllUniversitiesInfo" withExtension:@"json"];
    ////////////////
    
    NSData* uniInfoData = [NSData dataWithContentsOfURL:uniInfoURL];
    
    NSError* error = nil;
    
    NSDictionary* parsedObject = [NSJSONSerialization JSONObjectWithData:uniInfoData options:0 error:&error];
    
    if(error)
    {
        log(@"error: %@", [error userInfo]);
    }
    else
    {
//        log(@"OBJ:%@", parsedObject);
        log(@"load JSON success");
    }
    
    NSArray* array = [parsedObject valueForKey:@"schools"];
    log(@"OBJ:%@", array);
    
    for(NSDictionary* dict in array)
    {
        
        if([(NSNumber*)[dict valueForKey:@"toDelete"] boolValue] == false) //Not to be deleted entity
        {
            NSEntityDescription* schoolDescription = [NSEntityDescription entityForName:@"School" inManagedObjectContext:self.context];
            
            NSManagedObject *newSchool = [[NSManagedObject alloc] initWithEntity:schoolDescription insertIntoManagedObjectContext:self.context];
            
            if([dict valueForKey:@"id"] != [NSNull null])
            [newSchool setValue:[dict valueForKey:@"id"] forKey:@"schoolId"];
            if([dict valueForKey:@"name"] != [NSNull null])
            [newSchool setValue:[dict valueForKey:@"name"] forKey:@"name"];
            if([dict valueForKey:@"population"] != [NSNull null])
            [newSchool setValue:[dict valueForKey:@"population"] forKey:@"schoolId"];
            if([dict valueForKey:@"yearEstablished"] != [NSNull null])
            [newSchool setValue:[dict valueForKey:@"yearEstablished"] forKey:@"schoolId"];
            if([dict valueForKey:@"numPrograms"] != [NSNull null])
            [newSchool setValue:[dict valueForKey:@"numPrograms"] forKey:@"numPrograms"];
            if([dict valueForKey:@"logoUrl"] != [NSNull null])
            [newSchool setValue:[dict valueForKey:@"logoUrl"] forKey:@"logoUrl"];
            if([dict valueForKey:@"website"] != [NSNull null])
            [newSchool setValue:[dict valueForKey:@"website"] forKey:@"website"];
            if([dict valueForKey:@"facebookLink"] != [NSNull null])
            [newSchool setValue:[dict valueForKey:@"facebookLink"] forKey:@"facebookLink"];
            if([dict valueForKey:@"twitterLink"] != [NSNull null])
            [newSchool setValue:[dict valueForKey:@"twitterLink"] forKey:@"twitterLink"];
            
            if([dict valueForKey:@"linkedinLink"] != [NSNull null])
            [newSchool setValue:[dict valueForKey:@"linkedinLink"] forKey:@"linkedinLink"];
            if([dict valueForKey:@"alumniNumber"] != [NSNull null])
            [newSchool setValue:[dict valueForKey:@"alumniNumber"] forKey:@"alumniNumber"];
            
            id totalFunding = [dict valueForKey:@"totalFunding"];
            if(totalFunding != [NSNull null])
            {
                if([totalFunding isKindOfClass:[NSNumber class]])
                    [newSchool setValue:[dict valueForKey:@"totalFunding"] forKey:@"totalFunding"];
                else if([totalFunding isKindOfClass:[NSString class]])
                {
                    NSString* fundString =(NSString*)totalFunding;
                    
                    NSNumberFormatter *form = [[NSNumberFormatter alloc] init];
                                [form setNumberStyle:NSNumberFormatterDecimalStyle];
                    
                    [newSchool setValue: [form numberFromString:fundString] forKey:@"totalFunding"];
                }
                else
                {
                    JPLog(@"Failed to save totalFunding!");
                    abort();
                }
            }
            
            //Ignore rankings for now
            
            //***********************************************
            // Sync Location
            NSEntityDescription* locationDescription = [NSEntityDescription entityForName:@"SchoolLocation" inManagedObjectContext:self.context];
            
            NSManagedObject *newLocation = [[NSManagedObject alloc] initWithEntity:locationDescription insertIntoManagedObjectContext:self.context];
            
            [newLocation setValue:newSchool forKey:@"school"];
            
            NSDictionary* locationDict = [newSchool valueForKey:@"locations"];
            
            if([dict valueForKey:@"streetNum"] != [NSNull null])
            [newLocation setValue:[locationDict valueForKey:@"streetNum"] forKey:@"streetNum"];
            if([dict valueForKey:@"streetName"] != [NSNull null])
            [newLocation setValue:[locationDict valueForKey:@"streetName"] forKey:@"streetName"];
            if([dict valueForKey:@"apt"] != [NSNull null])
            [newLocation setValue:[locationDict valueForKey:@"apt"] forKey:@"apt"];
            if([dict valueForKey:@"unit"] != [NSNull null])
            [newLocation setValue:[locationDict valueForKey:@"unit"] forKey:@"unit"];
            if([dict valueForKey:@"city"] != [NSNull null])
            [newLocation setValue:[locationDict valueForKey:@"city"] forKey:@"city"];
            if([dict valueForKey:@"province"] != [NSNull null])
            [newLocation setValue:[locationDict valueForKey:@"province"] forKey:@"province"];
            if([dict valueForKey:@"country"] != [NSNull null])
            [newLocation setValue:[locationDict valueForKey:@"country"] forKey:@"country"];
            
//            NSString* latString =[locationDict valueForKey:@"lattitude"];
//            
//            NSString* lonString =[locationDict valueForKey:@"longitude"];
//            
//            NSNumberFormatter *form = [[NSNumberFormatter alloc] init];
//            [form setNumberStyle:NSNumberFormatterDecimalStyle];
//            
//            
//            [newLocation setValue: [form numberFromString:latString] forKey:@"lattitude"];
//            [newLocation setValue: [form numberFromString:lonString] forKey:@"longitude"];
            
            [newLocation setValue:[locationDict valueForKey:@"lattitude"] forKey:@"lattitude"];
            [newLocation setValue:[locationDict valueForKey:@"longitude"] forKey:@"longitude"];
            
            
            //****************************************************
            
            
            //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            //Sync Images
            
            NSArray* imagesArray = [newSchool valueForKey:@"images"];
            
            for(NSDictionary* imageDict in imagesArray)
            {
                NSEntityDescription* imageDescription = [NSEntityDescription entityForName:@"SchoolImageLink" inManagedObjectContext:self.context];
            
                NSManagedObject *newImage = [[NSManagedObject alloc] initWithEntity:imageDescription insertIntoManagedObjectContext:self.context];
                
                [newImage setValue:newSchool forKey:@"school"];
                
                if([dict valueForKey:@"imageLink"] != [NSNull null])
                [newImage setValue:[imageDict valueForKey:@"imageLink"] forKey:@"imageLink"];
                if([dict valueForKey:@"descriptor"] != [NSNull null])
                [newImage setValue:[imageDict valueForKey:@"descriptor"] forKey:@"descriptor"];
                
            }
            
            //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            
            //timeModified
            NSDate* today = [NSDate date];
            [newSchool setValue:today forKey:@"timeModified"];
            
            NSError *saveError = nil;
            [self.context save:&saveError];
            if(!saveError)
            {
                JPLog(@"Save Successful");
            }
            
            
        }
        else
        {
            NSError* deleteError = nil;
            
            NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"School"];
            
            request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"schoolId" ascending:YES]];
            
            request.predicate = [NSPredicate predicateWithFormat:@"(schoolId contains %@)", [dict valueForKey:@"id"]];
            
            [self.context executeFetchRequest:request error:&deleteError];
            
            log(@">>>DELETE ERROR: %@", [deleteError userInfo]);
            
            NSError *saveError = nil;
            [self.context save:&saveError];
            if(!saveError)
            {
                JPLog(@"Save Successful");
            }
            
        }
        
    }
    
    
    JPLog(@"Finished Synchronizing Schools");
    

    
    
    
    
    
    
    
    
    
    
//    NSEntityDescription* programDescription = [NSEntityDescription entityForName:@"Program" inManagedObjectContext:self.context];
//    
//    NSManagedObject *newProgram = [[NSManagedObject alloc] initWithEntity:programDescription insertIntoManagedObjectContext:self.context];
//    
//    [newProgram setValue:@"Mechatronics" forKey:@"name"];
//    [newProgram setValue:@"tron@yahoo.com" forKey:@"email"];
//    [newProgram setValue:[NSNumber numberWithInt:(int)(arc4random()%10000)] forKey:@"fax"];
//    
//    NSError* error;
//    
//    if(![self.context save:&error])
//    {
//        NSLog(@"Not saved");
//        
//    }
//    else
//    {
//        NSLog(@"saved");
//    }
//
    
    
    NSError* schoolSaveError = nil;
    [self.context save:&schoolSaveError];
    
    if(!error)
    {
       
    }
    else
    {
        JPLog(@"Error Deleting All Items");
    }
    
}


- (void)sendPostRequestWithName: (NSString*)requestName lastModifiedTime: (NSDate*)date
{
    
    
    
    
}




- (void)fetchStuff: (UIButton*)sender
{
    
    self.textView.text = @"";
    
    NSFetchRequest* validationRequest = [[NSFetchRequest alloc] initWithEntityName:@"School"];
    
    validationRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"schoolId" ascending:YES]];
    
    [validationRequest setPropertiesToFetch:@[@"schoolId",@"name",@"population",@"website"]];
    
    NSArray* valRes = [self.context executeFetchRequest:validationRequest error:nil];
    
    
    
    for(School* school in valRes)
    {
        self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"S: Id: [%@]\n",school.schoolId]];
        self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    Name: [%@]\n", school.name]];
        self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    Population: [%@]\n", school.population]];
        self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    Web: [%@]\n", school.website]];
    }

    
    
    
    
//    self.textView.text = @"";
//    
//    NSError* error = nil;
//    
//    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Program"];
//    
//    request.fetchLimit =30;
//    request.predicate = [NSPredicate predicateWithFormat:@"name contains %@", @"tron"];
//    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
//    
//    NSArray* results = [self.context executeFetchRequest:request error:&error];
//    
//    for(Program* program in results)
//    {
//        self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"P: Name: [%@]\n",program.name]];
//        self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    Email: [%@]\n", program.email]];
//        self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    Fax: [%@]\n", program.fax]];
//    }
    
    [self.view setNeedsDisplay];
    

}


- (void)deleteAll:(UIButton*)but
{
    NSFetchRequest* validationRequest = [[NSFetchRequest alloc] initWithEntityName:@"School"];
    
    validationRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"schoolId" ascending:YES]];
    
    [validationRequest setPropertiesToFetch:@[@"schoolId",@"name",@"population",@"website"]];
    validationRequest.predicate = [NSPredicate predicateWithValue:YES];

    NSError* fetchError = nil;
    NSArray* valRes = [self.context executeFetchRequest:validationRequest error:&fetchError];
    
    if(fetchError)
    {
        JPLog(@"Fetch Error: %@, %@", fetchError, [fetchError userInfo]);
    }
    
    for(School* school in valRes)
    {
        [self.context deleteObject:school];
    }
    
    
    JPLog(@"Finished Deleting Items");
    
    NSError* error = nil;
    [self.context save:&error];
    
    if(!error)
    {
        [self.view setNeedsDisplay];
    }
    else
    {
        JPLog(@"Error Deleting All Items");
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - location services
//- (void)startStandardUpdates
//{
//    // Create the location manager if this object does not
//    // already have one.
//    if (nil == locationManager)
//        locationManager = [[CLLocationManager alloc] init];
//
//        locationManager.delegate = self;
//        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
//
//        // Set a movement threshold for new events.
//        locationManager.distanceFilter = 500; // meters
//
//        [locationManager startUpdatingLocation];
//}


// Delegate method from the CLLocationManagerDelegate protocol.
//- (void)locationManager:(CLLocationManager *)manager
//didUpdateLocations:(NSArray *)locations {
//    // If it's a relatively recent event, turn off updates to save power.
//    CLLocation* location = [locations lastObject];
//    NSDate* eventDate = location.timestamp;
//    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
//    if (abs(howRecent) < 15.0) {
//        // If the event is recent, do something with it.
//        NSLog(@"latitude %+.6f, longitude %+.6f\n",
//              location.coordinate.latitude,
//              location.coordinate.longitude);
//    }
//}
@end
