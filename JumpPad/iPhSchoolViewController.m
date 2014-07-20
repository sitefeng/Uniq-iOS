//
//  iPhSchoolViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/20/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhSchoolViewController.h"
#import "iPhSchoolHomeViewController.h"
#import "iPhProgramContactViewController.h"
#import "JPCoreDataHelper.h"



@interface iPhSchoolViewController ()

@end

@implementation iPhSchoolViewController

- (instancetype)initWithDashletUid: (NSUInteger)dashletUid itemType: (NSUInteger)type
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.dashletUid=  dashletUid;
        self.type = type;
        
        UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        context = [delegate managedObjectContext];
        
        NSNumber* schoolId = [NSNumber numberWithInteger:self.dashletUid/1000000];
        NSNumber* facultyId = [NSNumber numberWithInteger:self.dashletUid%1000000/1000];
        
        if(self.type ==  JPDashletTypeSchool)
        {
            NSFetchRequest* req = [NSFetchRequest fetchRequestWithEntityName:@"School"];
            req.predicate = [NSPredicate predicateWithFormat:@"schoolId = %@", schoolId];
            NSArray* schoolArray = [context executeFetchRequest:req error:nil];
            self.schoolOrFaculty = [schoolArray firstObject];
        }
        else {
            NSFetchRequest* req = [NSFetchRequest fetchRequestWithEntityName:@"Faculty"];
            req.predicate = [NSPredicate predicateWithFormat:@"facultyId = %@", facultyId];
            NSArray* facultyArray = [context executeFetchRequest:req error:nil];
            self.schoolOrFaculty = [facultyArray firstObject];
        }
        
        _coreDataHelper = [[JPCoreDataHelper alloc] init];
        
        //NavBar Items
        self.title = [self.schoolOrFaculty name];
        
        UIBarButtonItem* dismissButton = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStyleDone target:self action:@selector(dismissButtonPressed:)];
        self.navigationItem.leftBarButtonItem = dismissButton;
        
        UIButton* favButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [favButton setImage:[UIImage imageNamed:@"favoriteIcon2Selected"] forState:UIControlStateSelected];
        [favButton setImage:[UIImage imageNamed:@"favoriteIcon2"] forState:UIControlStateNormal];
        favButton.selected = [_coreDataHelper isFavoritedWithDashletUid:self.dashletUid];
        [favButton addTarget:self action:@selector(favoriteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* favoriteItem = [[UIBarButtonItem alloc] initWithCustomView:favButton];
        self.navigationItem.rightBarButtonItem = favoriteItem;
        
        
        iPhSchoolHomeViewController* homeController = nil;
        iPhProgramContactViewController* contactController = nil;
        
        //Initializing View Controllers
        if(self.type == JPDashletTypeSchool)
        {
            homeController = [[iPhSchoolHomeViewController alloc] initWithSchool:self.schoolOrFaculty];
            contactController = [[iPhProgramContactViewController alloc] initWithSchool:self.schoolOrFaculty];
        }
        else
        {
            homeController = [[iPhSchoolHomeViewController alloc] initWithFaculty:self.schoolOrFaculty];
            contactController = [[iPhProgramContactViewController alloc] initWithFaculty:self.schoolOrFaculty];
        }
        
        homeController.tabBarItem.title = @"Home";
        homeController.tabBarItem.image = [UIImage imageNamed:@"home"];
        
        contactController.tabBarItem.title = @"Contact";
        contactController.tableView.frame = CGRectMake(0, contactController.tableView.frame.origin.y - kiPhoneNavigationBarHeight-kiPhoneStatusBarHeight, kiPhoneWidthPortrait, contactController.tableView.frame.size.height);
        contactController.tabBarItem.image = [UIImage imageNamed:@"contact"];
        
        self.viewControllers = @[homeController, contactController];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}




#pragma mark - Navigation Bar Item Callbacks
- (void)dismissButtonPressed: (UIBarButtonItem*)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)favoriteButtonPressed: (UIButton*)button
{
    if(!button.selected)
    {
        button.selected = YES;
        [_coreDataHelper addFavoriteWithDashletUid:self.dashletUid andType:self.type];
    }
    else
    {
        button.selected = NO;
        [_coreDataHelper removeFavoriteWithDashletUid:self.type];
    }
    
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
