//
//  iPadDebugMainSyncViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-27.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadDebugMainSyncViewController.h"

#import "UniqAppDelegate.h"
#import "Program.h"
#import "School.h"
#import "ImageLink.h"
#import "SchoolLocation.h"
#import "Banner.h"

#import "Faculty.h"

#import "JPMainSync.h"

@interface iPadDebugMainSyncViewController ()

@property (nonatomic, strong) NSManagedObjectContext* context;

@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, strong) UIButton* button;
@property (nonatomic, strong) UIButton* button3;
@property (nonatomic, strong) UIButton* button2;


@end

@implementation iPadDebugMainSyncViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [JPStyle mainViewControllerDefaultBackgroundColor];
    
    UniqAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [appDelegate managedObjectContext];

    
    self.syncer = [[JPMainSync alloc] init];


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

}


#pragma mark - UIButton Target Action Methods

- (void)sync: (UIButton*)sender
{
    [self.syncer sync];
    
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



- (void)deleteAll: (UIButton*)button
{
    
    [self.syncer deleteAll];
    
    
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
