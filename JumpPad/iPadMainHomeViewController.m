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
#import "ImageLink.h"
#import "SchoolLocation.h"
#import "Banner.h"

#import "Faculty.h"


@interface iPadMainHomeViewController ()


@property (nonatomic, strong) NSManagedObjectContext* context;
@property (nonatomic, strong) NSDate* timeModified;


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
    
    
    self.textView =[[UITextView alloc] initWithFrame:CGRectMake(50, 50, 660, 700)];
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
    
    self.timeModified = [results lastObject];
    
    
}

- (void)saveBannerDataWithArray: (NSArray*)array
{
    for(NSDictionary* bannerDict in array)
    {
            NSFetchRequest* req = [[NSFetchRequest alloc] initWithEntityName:@"Banner"];
            req.sortDescriptors = @[ [[NSSortDescriptor alloc] initWithKey:@"bannerId" ascending:YES] ];
            req.propertiesToFetch = @[@"bannerId"];
            req.predicate = [NSPredicate predicateWithFormat:@"bannerId = %@",[bannerDict valueForKey:@"bannerId"]];

            NSArray* deleteBanners = [self.context executeFetchRequest:req error:nil];
            
            for(Banner* banner in deleteBanners)
            {
                [self.context deleteObject:banner];
            }

        if([[bannerDict valueForKey:@"toDelete"] isEqual:[NSNumber numberWithBool:false]])
        {
            Banner* newBanner = [NSEntityDescription insertNewObjectForEntityForName:@"Banner" inManagedObjectContext:self.context];
            
            newBanner.bannerId = [bannerDict valueForKey:@"bannerId"];
            newBanner.bannerLink = [bannerDict valueForKey:@"bannerLink"];
            newBanner.linkedUrl = [bannerDict valueForKey:@"linkedUrl"];
            newBanner.title = [bannerDict valueForKey:@"title"];
            
        }

    }
    
    NSError* error = nil;
    
    [self.context save:&error];
    if(error)
    {
        JPLog(@"ERROR:%@", error);
    }
    
}



#pragma mark - UIButton Target Action Methods

- (void)sync: (UIButton*)sender
{
    //Get banner information
    //Simulated Banner Data
    NSURL* bannerDataURL = [[NSBundle mainBundle] URLForResource:@"getAllBannersInfo" withExtension:@"json"];
    ////////////////
    NSData* bannerData = [NSData dataWithContentsOfURL:bannerDataURL];
    NSArray* parseBannerArray = [NSJSONSerialization JSONObjectWithData:bannerData options:0 error:nil];
    
    [self saveBannerDataWithArray:parseBannerArray];

    
    [self sendGetAllUniversitiesInfoRequestWithLastModifiedTime:self.timeModified];
    
    //Simulated Data
    NSURL* uniInfoURL = [[NSBundle mainBundle] URLForResource:@"getAllUniversitiesInfo" withExtension:@"json"];
    ////////////////
    NSData* uniInfoData = [NSData dataWithContentsOfURL:uniInfoURL];
    
    NSError* error = nil;
    
    NSArray* parsedObject = [NSJSONSerialization JSONObjectWithData:uniInfoData options:0 error:&error];
    
    if(error)
    {
        JPLog(@"error: %@", [error userInfo]);
    }
    
    
    [self saveAllUniversitiesFromArray:parsedObject];
    
    NSFetchRequest* universitiesRequest = [[NSFetchRequest alloc] initWithEntityName:@"School"];
    universitiesRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"schoolId" ascending:YES]];
    [universitiesRequest setPropertiesToFetch:@[@"schoolId",@"yearEstablished", @"population"]];
    
    NSArray* unis = [self.context executeFetchRequest:universitiesRequest error:nil];

    for(School* school in unis)
    {
        [self sendGetAllFacultiesInfoRequestWithLastModifiedTime:self.timeModified schoolId:school.schoolId];
        
        //Simulated Data
        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        NSURL* facultyURL = [[NSBundle mainBundle] URLForResource:@"getAllFacultiesInfo" withExtension:@"json"];
        NSData* facultyData = [NSData dataWithContentsOfURL:facultyURL];
        NSArray* facultyJSONArray = [NSJSONSerialization JSONObjectWithData:facultyData options:0 error:nil];
        
        if(![school.schoolId isEqual:[NSNumber numberWithInt:1]])
        {
            facultyJSONArray = [NSArray array];
        }
        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

        [self saveAllFacultiesInfoForSchool:school fromArray:facultyJSONArray];
        
        
        //Get all faculty instances and request for programs within the faculty to be updated/deleted
        NSFetchRequest* facultiesRequest = [[NSFetchRequest alloc] initWithEntityName:@"Faculty"];
        facultiesRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"facultyId" ascending:YES]];
        facultiesRequest.predicate = [NSPredicate predicateWithFormat:@"school.schoolId = %@", school.schoolId];
        
        NSArray* faculties = [self.context executeFetchRequest:facultiesRequest error:nil];
        
        for(Faculty* faculty in faculties)
        {
            [self sendGetAllProgramsInfoRequestWithLastModifiedTime:self.timeModified schoolId:school.schoolId facultyId:faculty.facultyId];
            
            //Simulated Data
            //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            NSURL* progURL = [[NSBundle mainBundle] URLForResource:@"getAllProgramsInfo" withExtension:@"json"];
            NSData* progData = [NSData dataWithContentsOfURL:progURL];
            NSArray* progJSONArray = [NSJSONSerialization JSONObjectWithData:progData options:0 error:nil];
            
            if(![faculty.facultyId isEqual:[NSNumber numberWithInt:1]])
            {
                progJSONArray = [NSArray array];
            }
            
            //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            
            
            [self saveAllProgramsInfoForSchool:school faculty:faculty fromArray:progJSONArray];
            
        }
    }
    
    NSError* facultySaveError = nil;
    [self.context save:&facultySaveError];
    if(facultySaveError)
    {
        JPLog(@"Faculty Save Error: %@, %@", facultySaveError, [facultySaveError userInfo]);
    }
    
    
}


- (void)fetchStuff: (UIButton*)sender
{
    self.textView.text = @"";
    
    //Test getAllFaculties
    if([sender.titleLabel.text isEqualToString: @"Display All Dat"])
    {
        NSFetchRequest* validationRequest = [[NSFetchRequest alloc] initWithEntityName:@"Faculty"];
        validationRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"facultyId" ascending:YES]];
        
        validationRequest.predicate = [NSPredicate predicateWithFormat:@"school.schoolId = %@", [NSNumber numberWithInt:1]];
        
        NSArray* valRes = [self.context executeFetchRequest:validationRequest error:nil];
        
        for(Faculty* faculty in valRes)
        {
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"F: Id: [%@]\n",faculty.facultyId]];
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    Name: [%@]\n", faculty.name]];
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    Population: [%@]\n", faculty.population]];
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    Web: [%@]\n", faculty.website]];
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    Logo: [%@]\n", faculty.logoUrl]];
        }

    }
    
    //Test getAllUniversities
    else if ([sender.titleLabel.text isEqualToString: @"Display All Dat"])
    {
        
        NSFetchRequest* validationRequest = [[NSFetchRequest alloc] initWithEntityName:@"School"];
        validationRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"schoolId" ascending:YES]];
        [validationRequest setPropertiesToFetch:@[@"schoolId", @"name",@"population",@"website"]];
        
        NSArray* valRes = [self.context executeFetchRequest:validationRequest error:nil];
        
        for(School* school in valRes)
        {
            NSArray* imgs = [school.images allObjects];
            ImageLink* img = [imgs firstObject];
            ImageLink* img2 = imgs[1];
            ImageLink* img3 = imgs[2];
            
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"S: img: [%@]\n",img.imageLink]];
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    img2: [%@]\n", img2.imageLink]];
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    img3: [%@]\n", img3.imageLink]];
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    Web: [%@]\n", school.website]];
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    timeModified: [%@]\n", school.timeModified]];
        }
        
    }
    
    //Test getAllUniversitiesImageLink
    else if ([sender.titleLabel.text isEqualToString: @"Display All Data"])
    {
        
        NSFetchRequest* validationRequest = [[NSFetchRequest alloc] initWithEntityName:@"ImageLink"];
        validationRequest.sortDescriptors = @[  [[NSSortDescriptor alloc] initWithKey:@"descriptor" ascending:YES]  ];
        validationRequest.propertiesToFetch = @[@"imageLink", @"descriptor"];
        
        NSArray* valRes = [self.context executeFetchRequest:validationRequest error:nil];
        
        for(ImageLink* img in valRes)
        {
//            NSArray* imgs = [school.images allObjects];
//            ImageLink* img = [imgs firstObject];
//            ImageLink* img2 = imgs[1];
//            ImageLink* img3 = imgs[2];
            
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"S: img: [%@]\n",img.imageLink]];
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    des: [%@]\n", img.descriptor]];
//            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    img3: [%@]\n", img3.imageLink]];
//            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    Web: [%@]\n", school.website]];
//            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    timeModified: [%@]\n", school.timeModified]];
        }
        
    }

    
    
    //Test Banner
    else if([sender.titleLabel.text isEqualToString: @"Display All Dat"])
    {
        NSFetchRequest* validationRequest = [[NSFetchRequest alloc] initWithEntityName:@"Banner"];
        validationRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"bannerId" ascending:YES]];
        [validationRequest setPropertiesToFetch:@[@"bannerId",@"bannerLink",@"linkedUrl",@"title"]];
        
        NSArray* valRes = [self.context executeFetchRequest:validationRequest error:nil];
        
        for(Banner* banner in valRes)
        {
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"B: Id: [%@]\n",banner.bannerId]];
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    link: [%@]\n", banner.bannerLink]];
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    url: [%@]\n", banner.linkedUrl]];
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    title: [%@]\n", banner.title]];

        }

        
    }
    
    //Test getAllProgram
    else
    {
        NSFetchRequest* validationRequest = [[NSFetchRequest alloc] initWithEntityName:@"Program"];
        validationRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"programId" ascending:YES]];
        
        validationRequest.predicate = [NSPredicate predicateWithFormat:@"(faculty.facultyId = %@)", [NSNumber numberWithInt:1], [NSNumber numberWithInt:221]];
        
        NSArray* valRes = [self.context executeFetchRequest:validationRequest error:nil];
        
        for(Program* program in valRes)
        {
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"P: Id: [%@]\n",program.programId]];
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    Name: [%@]\n", program.name]];
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    Population: [%@]\n", program.population]];
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    Web: [%@]\n", program.website]];
            self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"    Fav: [%@]\n", program.numFavorites]];
        }
    }
    
    
    
    
    [self.view setNeedsDisplay];
}


- (void)deleteAll:(UIButton*)but
{
    NSFetchRequest* validationRequest = [[NSFetchRequest alloc] initWithEntityName:@"School"];
    validationRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"schoolId" ascending:YES]];
    [validationRequest setPropertiesToFetch:@[@"schoolId"]];
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


#pragma mark - Core Data Saving Methods

- (void)saveAllUniversitiesFromArray: (NSArray*)array
{
    
    for(NSDictionary* dict in array)
    {
        if([(NSNumber*)[dict valueForKey:@"toDelete"] boolValue] == false) //Not to be deleted entity
        {
            
            //Delete the Entities to be updated if it already exists in Core Data DB
            NSFetchRequest* updateRequest = [NSFetchRequest fetchRequestWithEntityName:@"School"];
            updateRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"schoolId" ascending:YES]];
            updateRequest.fetchLimit = 100;
            updateRequest.predicate = [NSPredicate predicateWithFormat:@"schoolId = %@",[dict valueForKey:@"id"]];
            
            NSArray* schoolArray = [self.context executeFetchRequest:updateRequest error:nil];
            
            for(School* school in schoolArray)
            {
                [self.context deleteObject:school];
            }
            
            //Add the Entities
            NSEntityDescription* schoolDescription = [NSEntityDescription entityForName:@"School" inManagedObjectContext:self.context];
            
            NSManagedObject *newSchool = [[NSManagedObject alloc] initWithEntity:schoolDescription insertIntoManagedObjectContext:self.context];
            
            if([dict valueForKey:@"id"] != [NSNull null])
                [newSchool setValue:[dict valueForKey:@"id"] forKey:@"schoolId"];
            if([dict valueForKey:@"name"] != [NSNull null])
                [newSchool setValue:[dict valueForKey:@"name"] forKey:@"name"];
            if([dict valueForKey:@"population"] != [NSNull null])
                [newSchool setValue:[dict valueForKey:@"population"] forKey:@"population"];
            if([dict valueForKey:@"yearEstablished"] != [NSNull null])
                [newSchool setValue:[dict valueForKey:@"yearEstablished"] forKey:@"yearEstablished"];
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
            
            NSDictionary* locationDict = [dict valueForKey:@"location"];
            
            if([locationDict valueForKey:@"streetNum"] != [NSNull null])
                [newLocation setValue:[locationDict valueForKey:@"streetNum"] forKey:@"streetNum"];
            if([locationDict valueForKey:@"streetName"] != [NSNull null])
                [newLocation setValue:[locationDict valueForKey:@"streetName"] forKey:@"streetName"];
            if([locationDict valueForKey:@"apt"] != [NSNull null])
                [newLocation setValue:[locationDict valueForKey:@"apt"] forKey:@"apt"];
            if([locationDict valueForKey:@"unit"] != [NSNull null])
                [newLocation setValue:[locationDict valueForKey:@"unit"] forKey:@"unit"];
            if([locationDict valueForKey:@"city"] != [NSNull null])
                [newLocation setValue:[locationDict valueForKey:@"city"] forKey:@"city"];
            if([locationDict valueForKey:@"province"] != [NSNull null])
                [newLocation setValue:[locationDict valueForKey:@"province"] forKey:@"province"];
            if([locationDict valueForKey:@"country"] != [NSNull null])
                [newLocation setValue:[locationDict valueForKey:@"country"] forKey:@"country"];

                //TODO: fix this parsing to accommodate from integers in quotations
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            
            id lattitudeValue = [locationDict valueForKey:@"lattitude"];
            
            if(lattitudeValue != [NSNull null])
            {
                if([lattitudeValue isKindOfClass:[NSString class]])
                {
                    NSString* latString =(NSString*)lattitudeValue;
                    [newLocation setValue:[formatter numberFromString:latString] forKey:@"lattitude"];
                }
                
            }
            
            id longitudeValue = [locationDict valueForKey:@"longitude"];
            
            if(longitudeValue != [NSNull null])
            {
                if([longitudeValue isKindOfClass:[NSString class]])
                {
                    NSString* lonString =(NSString*)longitudeValue;
                    [newLocation setValue:[formatter numberFromString:lonString] forKey:@"longitude"];
                }
                
            }
            
            
            //****************************************************
            
            //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            //Sync Images
            
            id imagesArrayId = [dict valueForKey:@"images"];
        
            if(imagesArrayId != [NSNull null])
            {
                NSArray* imagesArray =(NSArray*)imagesArrayId;
                
                for(NSDictionary* imageDict in imagesArray)
                {
                    NSEntityDescription* imageDescription = [NSEntityDescription entityForName:@"ImageLink" inManagedObjectContext:self.context];
                    
                    NSManagedObject *newImage = [[NSManagedObject alloc] initWithEntity:imageDescription insertIntoManagedObjectContext:self.context];
                    
                    [newImage setValue:newSchool forKey:@"school"];
                    
                    if([dict valueForKey:@"imageLink"] != [NSNull null])
                        [newImage setValue:[imageDict valueForKey:@"imageLink"] forKey:@"imageLink"];
                    if([dict valueForKey:@"descriptor"] != [NSNull null])
                        [newImage setValue:[imageDict valueForKey:@"descriptor"] forKey:@"descriptor"];
                }
            }
            //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            
            //timeModified
            NSDate* today = [NSDate date];
            [newSchool setValue:today forKey:@"timeModified"];
            
            NSError *saveError = nil;
            [self.context save:&saveError];
            if(saveError)
            {
                JPLog(@"Save not Successful");
            }
            
        }
        else
        {
            NSError* deleteError = nil;
            
            NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"School"];
            request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"schoolId" ascending:YES]];
            request.predicate = [NSPredicate predicateWithFormat:@"(schoolId = %@)", [dict valueForKey:@"id"]];
            NSArray* deleteObjects = [self.context executeFetchRequest:request error:&deleteError];
            if (deleteError) {
                log(@"Deletion Error: %@", [deleteError userInfo]);
            }
            
            for(NSManagedObject* obj in deleteObjects)
            {
                [self.context deleteObject:obj];
            }

            NSError *saveError = nil;
            [self.context save:&saveError];
            if(saveError)
            {
                JPLog(@"Deletion Failed To Save");
            }
        }
    }
    
    NSError* schoolSaveError = nil;
    [self.context save:&schoolSaveError];
    
    if(schoolSaveError)
    {
        JPLog(@"Error Saving Deletion");
    }
    
    JPLog(@"synced");
    
}




- (void)saveAllFacultiesInfoForSchool: (School*)school fromArray: (NSArray*)array
{
    
    NSEntityDescription* facultyDescription = [NSEntityDescription entityForName:@"Faculty" inManagedObjectContext:self.context];
    NSManagedObject* newFaculty = [[NSManagedObject alloc] initWithEntity:facultyDescription insertIntoManagedObjectContext:self.context];
    
    
    for(NSDictionary* dict in array)
    {
        if([dict valueForKey:@"toDelete"] != [NSNumber numberWithBool:true])
        {
            
            //The file returned contains only Faculties to be updated, inserted, or deleted.
            //Delete any existing Faculties in Core Data first and add back in later for ones to be updated.
            
            NSFetchRequest* updateReq = [NSFetchRequest fetchRequestWithEntityName:@"Faculty"];
            
            updateReq.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"facultyId" ascending:YES]];

            updateReq.predicate = [NSPredicate predicateWithFormat:@"(school.schoolId = %@) && (facultyId = %@)", school.schoolId,[dict valueForKey:@"id"]];
            
            NSArray* deleteFaculties = [self.context executeFetchRequest:updateReq error:nil];
            
            for(Faculty* faculty in deleteFaculties)
            {
                [self.context deleteObject:faculty];
            }
        
            
            //Adding all objects with toDelete = false
            /////////////////////////////////////////
            if([dict valueForKey:@"id"] != [NSNull null])
            [newFaculty setValue:[dict valueForKey:@"id"] forKey:@"facultyId"];
            if([dict valueForKey:@"name"] != [NSNull null])
                [newFaculty setValue:[dict valueForKey:@"name"] forKey:@"name"];
            if([dict valueForKey:@"population"] != [NSNull null])
                [newFaculty setValue:[dict valueForKey:@"population"] forKey:@"population"];
            if([dict valueForKey:@"yearEstablished"] != [NSNull null])
                [newFaculty setValue:[dict valueForKey:@"yearEstablished"] forKey:@"yearEstablished"];
            if([dict valueForKey:@"numPrograms"] != [NSNull null])
                [newFaculty setValue:[dict valueForKey:@"numPrograms"] forKey:@"numPrograms"];
            if([dict valueForKey:@"logoUrl"] != [NSNull null])
                [newFaculty setValue:[dict valueForKey:@"logoUrl"] forKey:@"logoUrl"];
            if([dict valueForKey:@"alumniNumber"] != [NSNull null])
                [newFaculty setValue:[dict valueForKey:@"alumniNumber"] forKey:@"alumniNumber"];
            if([dict valueForKey:@"website"] != [NSNull null])
                [newFaculty setValue:[dict valueForKey:@"website"] forKey:@"website"];
            if([dict valueForKey:@"facebookLink"] != [NSNull null])
                [newFaculty setValue:[dict valueForKey:@"facebookLink"] forKey:@"facebookLink"];
            if([dict valueForKey:@"twitterLink"] != [NSNull null])
                [newFaculty setValue:[dict valueForKey:@"twitterLink"] forKey:@"twitterLink"];

            //This is used to accommodate different structures to prevent crashing
            id totalFunding = [dict valueForKey:@"totalFunding"];
            if(totalFunding != [NSNull null])
            {
                if([totalFunding isKindOfClass:[NSNumber class]])
                    [newFaculty setValue:[dict valueForKey:@"totalFunding"] forKey:@"totalFunding"];
                else if([totalFunding isKindOfClass:[NSString class]])
                {
                    NSString* fundString =(NSString*)totalFunding;
                    NSNumberFormatter *form = [[NSNumberFormatter alloc] init];
                    [form setNumberStyle:NSNumberFormatterDecimalStyle];
                    [newFaculty setValue: [form numberFromString:fundString] forKey:@"totalFunding"];
                }
                else
                {
                    JPLog(@"Failed to save totalFunding for Faculty");
                    abort();
                }
            }

            
            //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            //Sync Images
            
            id imagesArrayId = [dict valueForKey:@"images"];
            
            if(imagesArrayId != [NSNull null])
            {
                NSArray* imagesArray =(NSArray*)imagesArrayId;
                for(NSDictionary* imageDict in imagesArray)
                {
                    NSEntityDescription* imageDescription = [NSEntityDescription entityForName:@"ImageLink" inManagedObjectContext:self.context];
                    
                    NSManagedObject *newImage = [[NSManagedObject alloc] initWithEntity:imageDescription insertIntoManagedObjectContext:self.context];
                    
                    [newImage setValue:newFaculty forKey:@"faculty"];
                    
                    if([dict valueForKey:@"imageLink"] != [NSNull null])
                        [newImage setValue:[imageDict valueForKey:@"imageLink"] forKey:@"imageLink"];
                    if([dict valueForKey:@"descriptor"] != [NSNull null])
                        [newImage setValue:[imageDict valueForKey:@"descriptor"] forKey:@"descriptor"];
                }
            }
            
            //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
       
            [newFaculty setValue:school forKey: @"school"];
            
//            JPLog(@"Faculty: %@\n%@\n%@\n%@\n%@", [newFaculty valueForKey:@"facultyId"],[newFaculty valueForKey:@"name"],[newFaculty valueForKey:@"facebookLink"],[newFaculty valueForKey:@"yearEstablished"],[newFaculty valueForKey:@"school"]);
        }
        else
        {
            NSError* deleteError = nil;
            
            NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Faculty"];
            request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"facultyId" ascending:YES]];
            request.predicate = [NSPredicate predicateWithFormat:@"facultyId = %@", [dict valueForKey:@"id"]];
            NSArray* deleteObjects = [self.context executeFetchRequest:request error:&deleteError];
            if(deleteError)
            {
                JPLog(@"DELETION ERROR: %@", deleteError);
            }
            
            for(NSManagedObject* obj in deleteObjects)
            {
                [self.context deleteObject:obj];
            }
            
        }

    }
    
    NSError *saveError = nil;
    [self.context save:&saveError];
    if(saveError)
    {
        JPLog(@"Faculty Failed To Save");
    }

}





- (void)saveAllProgramsInfoForSchool: (School*)school faculty: (Faculty*)faculty fromArray: (NSArray*) array
{
    
    NSEntityDescription* programDescription = [NSEntityDescription entityForName:@"Program" inManagedObjectContext:self.context];
    NSManagedObject* newProgram = [[NSManagedObject alloc] initWithEntity:programDescription insertIntoManagedObjectContext:self.context];
    
    
    for(NSDictionary* dict in array)
    {
        if([dict valueForKey:@"toDelete"] != [NSNumber numberWithBool:true])
        {
            
            //The file returned contains only Faculties to be updated, inserted, or deleted.
            //Delete any existing Faculties in Core Data first and add back in later for ones to be updated.
            
            NSFetchRequest* updateReq = [NSFetchRequest fetchRequestWithEntityName:@"Program"];
            updateReq.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"programId" ascending:YES]];
            
            updateReq.predicate = [NSPredicate predicateWithFormat:@"(faculty.facultyId = %@) && (programId = %@)", school.schoolId, faculty.facultyId, [dict valueForKey:@"id"]];
            
            NSArray* deletePrograms = [self.context executeFetchRequest:updateReq error:nil];
            
            for(Program* program in deletePrograms)
            {
                [self.context deleteObject:program];
            }
            
            
            //Adding all objects with toDelete = false
            /////////////////////////////////////////
            
            
            if([dict valueForKey:@"id"] != [NSNull null])
                [newProgram setValue:[dict valueForKey:@"id"] forKey:@"programId"];
            if([dict valueForKey:@"name"] != [NSNull null])
                [newProgram setValue:[dict valueForKey:@"name"] forKey:@"name"];
            if([dict valueForKey:@"population"] != [NSNull null])
                [newProgram setValue:[dict valueForKey:@"population"] forKey:@"population"];
            if([dict valueForKey:@"yearEstablished"] != [NSNull null])
                [newProgram setValue:[dict valueForKey:@"yearEstablished"] forKey:@"yearEstablished"];
            
            if([dict valueForKey:@"admissionDeadline"] != [NSNull null])
                [newProgram setValue:[dict valueForKey:@"admissionDeadline"] forKey:@"admissionDeadline"];
            if([dict valueForKey:@"email"] != [NSNull null])
                [newProgram setValue:[dict valueForKey:@"email"] forKey:@"email"];
            
            if([dict valueForKey:@"phone"] != [NSNull null])
                [newProgram setValue:[dict valueForKey:@"phone"] forKey:@"phone"];
            if([dict valueForKey:@"ext"] != [NSNull null])
                [newProgram setValue:[dict valueForKey:@"ext"] forKey:@"ext"];
            if([dict valueForKey:@"fax"] != [NSNull null])
                [newProgram setValue:[dict valueForKey:@"fax"] forKey:@"fax"];
            if([dict valueForKey:@"isCoop"] != [NSNull null])
                [newProgram setValue:[dict valueForKey:@"isCoop"] forKey:@"isCoop"];
            if([dict valueForKey:@"numFavorites"] != [NSNull null])
                [newProgram setValue:[dict valueForKey:@"numFavorites"] forKey:@"numFavorites"];
            if([dict valueForKey:@"website"] != [NSNull null])
                [newProgram setValue:[dict valueForKey:@"website"] forKey:@"website"];
            if([dict valueForKey:@"facebookLink"] != [NSNull null])
                [newProgram setValue:[dict valueForKey:@"facebookLink"] forKey:@"facebookLink"];
            if([dict valueForKey:@"twitterLink"] != [NSNull null])
                [newProgram setValue:[dict valueForKey:@"twitterLink"] forKey:@"twitterLink"];
            if([dict valueForKey:@"about"] != [NSNull null])
                [newProgram setValue:[dict valueForKey:@"about"] forKey:@"about"];
            
            
            //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            //Sync Images
            
            id imagesArrayId = [dict valueForKey:@"images"];
            
            if(imagesArrayId != [NSNull null])
            {
                NSArray* imagesArray =(NSArray*)imagesArrayId;
            
                for(NSDictionary* imageDict in imagesArray)
                {
                    NSEntityDescription* imageDescription = [NSEntityDescription entityForName:@"ImageLink" inManagedObjectContext:self.context];
                    
                    NSManagedObject *newImage = [[NSManagedObject alloc] initWithEntity:imageDescription insertIntoManagedObjectContext:self.context];
                    
                    [newImage setValue:newProgram forKey:@"program"];
                    
                    if([imageDict valueForKey:@"imageLink"] != [NSNull null])
                        [newImage setValue:[imageDict valueForKey:@"imageLink"] forKey:@"imageLink"];
                    if([imageDict valueForKey:@"descriptor"] != [NSNull null])
                        [newImage setValue:[imageDict valueForKey:@"descriptor"] forKey:@"descriptor"];
                }
            }
            
            /////////////////////////////////////////////
            

            
            if([dict valueForKey:@"rating"] != [NSNull null])
            {
                NSEntityDescription* ratingDescription = [NSEntityDescription entityForName:@"ProgramRating" inManagedObjectContext:self.context];
                NSManagedObject *newRating = [[NSManagedObject alloc] initWithEntity:ratingDescription insertIntoManagedObjectContext:self.context];
                [newRating setValue:newProgram forKey:@"program"];
                NSDictionary* ratingDict = [dict valueForKey:@"rating"];
                
                if([ratingDict valueForKey:@"ratingOverall"] != [NSNull null])
                    [newRating setValue:[ratingDict valueForKey:@"ratingOverall"] forKey:@"ratingOverall"];
                if([ratingDict valueForKey:@"professors"] != [NSNull null])
                    [newRating setValue:[ratingDict valueForKey:@"professors"] forKey:@"professor"];
                if([ratingDict valueForKey:@"difficulty"] != [NSNull null])
                    [newRating setValue:[ratingDict valueForKey:@"difficulty"] forKey:@"difficulty"];
                if([ratingDict valueForKey:@"schedule"] != [NSNull null])
                    [newRating setValue:[ratingDict valueForKey:@"schedule"] forKey:@"schedule"];
                if([ratingDict valueForKey:@"classmates"] != [NSNull null])
                    [newRating setValue:[ratingDict valueForKey:@"classmates"] forKey:@"classmates"];
                if([ratingDict valueForKey:@"socialEnjoyment"] != [NSNull null])
                    [newRating setValue:[ratingDict valueForKey:@"socialEnjoyment"] forKey:@"socialEnjoyments"];
                if([ratingDict valueForKey:@"studyEnv"] != [NSNull null])
                    [newRating setValue:[ratingDict valueForKey:@"studyEnv"] forKey:@"studyEnv"];
                if([ratingDict valueForKey:@"guyRatio"] != [NSNull null])
                    [newRating setValue:[ratingDict valueForKey:@"guyRatio"] forKey:@"guyToGirlRatio"];
            }
            
            //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            //TUITION
            if([dict valueForKey:@"domesticTuition"] != [NSNull null] || [dict valueForKey:@"internationalTuition"] != [NSNull null])
            {
                NSEntityDescription* tuitionDescription = [NSEntityDescription entityForName:@"ProgramYearlyTuition" inManagedObjectContext:self.context];
                NSManagedObject *newTuition = [[NSManagedObject alloc] initWithEntity:tuitionDescription insertIntoManagedObjectContext:self.context];
                [newTuition setValue:newProgram forKey:@"program"];
                ////////////////////////////
                
                NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
                [formatter setNumberStyle:NSNumberFormatterDecimalStyle];

                id domTuition = [dict valueForKey:@"domesticTuition"];
                if(domTuition != [NSNull null])
                {
                    if([domTuition isKindOfClass:[NSString class]])
                    {
                        NSNumber* tuition = [formatter numberFromString: domTuition];
                        [newTuition setValue:tuition forKey:@"domesticTuition"];
                    }
                    else
                    {
                        [newTuition setValue:[dict valueForKey:@"domesticTuition"] forKey:@"domesticTuition"];
                    }
                }
                
                id intTuition = [dict valueForKey:@"internationalTuition"];
                if(intTuition != [NSNull null])
                {
                    if([intTuition isKindOfClass:[NSString class]])
                    {
                        NSNumber* tuition = [formatter numberFromString: intTuition];
                        [newTuition setValue:tuition forKey:@"internationalTuition"];
                    }
                    else
                    {
                        [newTuition setValue:[dict valueForKey:@"internationalTuition"] forKey:@"internationalTuition"];
                    }
                    
                }
            
            }
            
            //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            
            id coursesDictId = [dict valueForKey:@"courses"];
            
            if(coursesDictId != [NSNull null])
            {
                NSDictionary* coursesDict =(NSDictionary*)coursesDictId;
                
                if([coursesDict valueForKey:@"firstYear"] != [NSNull null])
                {
                    NSArray* yearArray = [coursesDict valueForKey:@"firstYear"];
                    
                    
                    for(NSString* courseName in yearArray)
                    {
                        NSEntityDescription* courseDescription = [NSEntityDescription entityForName:@"ProgramCourse" inManagedObjectContext:self.context];
                        
                        NSManagedObject *newCourse = [[NSManagedObject alloc] initWithEntity:courseDescription insertIntoManagedObjectContext:self.context];
                        
                        [newCourse setValue:courseName forKey:@"courseName"];
                        
                        [newCourse setValue:newProgram forKey:@"program"];
                    }
                }
                    
                if([coursesDict valueForKey:@"secondYear"] != [NSNull null])
                {
                    NSArray* yearArray = [coursesDict valueForKey:@"secondYear"];
                    
                    for(NSString* courseName in yearArray)
                    {
                        NSEntityDescription* courseDescription = [NSEntityDescription entityForName:@"ProgramCourse" inManagedObjectContext:self.context];
                        
                        NSManagedObject *newCourse = [[NSManagedObject alloc] initWithEntity:courseDescription insertIntoManagedObjectContext:self.context];
                        
                        [newCourse setValue:courseName forKey:@"courseName"];
                        
                        [newCourse setValue:newProgram forKey:@"program"];
                    }
                }
                
                if([coursesDict valueForKey:@"thirdYear"] != [NSNull null])
                {
                    NSArray* yearArray = [coursesDict valueForKey:@"thirdYear"];
                    
                    
                    for(NSString* courseName in yearArray)
                    {
                        NSEntityDescription* courseDescription = [NSEntityDescription entityForName:@"ProgramCourse" inManagedObjectContext:self.context];
                        
                        NSManagedObject *newCourse = [[NSManagedObject alloc] initWithEntity:courseDescription insertIntoManagedObjectContext:self.context];
                        
                        [newCourse setValue:courseName forKey:@"courseName"];
                        
                        [newCourse setValue:newProgram forKey:@"program"];
                    }
                }
                
                if([coursesDict valueForKey:@"fourthYear"] != [NSNull null])
                {
                    NSArray* yearArray = [coursesDict valueForKey:@"fourthYear"];
                    
                    
                    for(NSString* courseName in yearArray)
                    {
                        NSEntityDescription* courseDescription = [NSEntityDescription entityForName:@"ProgramCourse" inManagedObjectContext:self.context];
                        
                        NSManagedObject *newCourse = [[NSManagedObject alloc] initWithEntity:courseDescription insertIntoManagedObjectContext:self.context];
                        
                        [newCourse setValue:courseName forKey:@"courseName"];
                        
                        [newCourse setValue:newProgram forKey:@"program"];
                    }
                }
            }
            
            
            //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            
            [newProgram setValue:faculty forKey: @"faculty"];
            
//            JPLog(@"Program: %@\n%@\n%@\n%@\n%@", [newProgram valueForKey:@"programId"],[newProgram valueForKey:@"name"],[newProgram valueForKey:@"facebookLink"],[newProgram valueForKey:@"yearEstablished"],[newProgram valueForKey:@"faculty"]);
        }
        else
        {
            NSError* deleteError = nil;
            
            NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Program"];
            request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"programId" ascending:YES]];
            request.predicate = [NSPredicate predicateWithFormat:@"programId = %@", [dict valueForKey:@"id"]];
            NSArray* deleteObjects = [self.context executeFetchRequest:request error:&deleteError];
            if(deleteError)
            {
                JPLog(@"DELETION ERROR: %@", deleteError);
            }
            
            for(NSManagedObject* obj in deleteObjects)
            {
                [self.context deleteObject:obj];
            }
            
        }
        
    }
    
    NSError *saveError = nil;
    [self.context save:&saveError];
    if(saveError)
    {
        JPLog(@"Program Failed To Save");
    }

}




#pragma mark - Sending Requests

- (void)sendGetAllUniversitiesInfoRequestWithLastModifiedTime:(NSDate*)date
{
    
    
    
    
}


- (void)sendGetAllFacultiesInfoRequestWithLastModifiedTime: (NSDate*)date schoolId: (NSNumber*)schoolId
{
    
    
    
}




- (void)sendGetAllProgramsInfoRequestWithLastModifiedTime: (NSDate*)date schoolId: (NSNumber*)schoolId facultyId: (NSNumber*)facultyId
{
    
    
    
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
