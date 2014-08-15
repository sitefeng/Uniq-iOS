//
//  iPhProgramViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhProgramViewController.h"
#import "Program.h"
#import "iPhProgramHomeViewController.h"
#import "iPhProgramAcademicsViewController.h"
#import "iPhProgramContactViewController.h"
#import "JPCoreDataHelper.h"
#import "UserFavItem.h"
#import "iPhAppProgressPanView.h"
#import "iPhProgramRatingsViewController.h"


@interface iPhProgramViewController ()

@end

@implementation iPhProgramViewController

- (instancetype)initWithDashletUid: (NSUInteger)dashletUid
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
    
        
        UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        context = [delegate managedObjectContext];
        
        self.dashletUid = dashletUid;
        _helper = [[JPCoreDataHelper alloc] init];
        
        [self retrieveProgramInfo];
        self.title = self.program.name;
        
        UIBarButtonItem* dismissItem = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStyleDone target:self action:@selector(dismissButtonSelected:)];
        self.navigationItem.leftBarButtonItem = dismissItem;
        
        _favButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_favButton setImage:[UIImage imageNamed:@"favoriteIcon2Selected"] forState:UIControlStateSelected];
        [_favButton setImage:[UIImage imageNamed:@"favoriteIcon2"] forState:UIControlStateNormal];
        _favButton.selected = [_helper isFavoritedWithDashletUid:self.dashletUid];
        [_favButton addTarget:self action:@selector(favoriteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* favoriteItem = [[UIBarButtonItem alloc] initWithCustomView:_favButton];
        self.navigationItem.rightBarButtonItem = favoriteItem;
        
        iPhProgramHomeViewController* homeController = [[iPhProgramHomeViewController alloc] initWithProgram: self.program];
        
        homeController.tabBarItem.image = [UIImage imageNamed:@"home"];
        homeController.tabBarItem.title = @"Home";
        
        academicsController = [[iPhProgramAcademicsViewController alloc] initWithProgram:self.program];
        academicsController.tabBarItem.title = @"Academics";
        academicsController.tabBarItem.image = [UIImage imageNamed: @"academics"];
        
        iPhProgramContactViewController* contactController = [[iPhProgramContactViewController alloc] initWithProgram:self.program];
        contactController.tabBarItem.title = @"Contact";
        contactController.tabBarItem.image = [UIImage imageNamed:@"contact"];
        
        iPhProgramRatingsViewController* ratingsController = [[iPhProgramRatingsViewController alloc] initWithProgram:self.program];
        ratingsController.tabBarItem.title = @"Ratings";
        ratingsController.tabBarItem.image = [UIImage imageNamed:@"ratings"];
        
        self.viewControllers = @[homeController, academicsController, contactController, ratingsController];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
}


- (void)retrieveProgramInfo
{
    NSInteger programId = self.dashletUid%100000;
    NSInteger facultyId = self.dashletUid%10000000 / 100000;
    NSInteger schoolId = self.dashletUid/10000000;
    
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Program"];
    request.predicate = [NSPredicate predicateWithFormat: @"programId = %@ && faculty.facultyId = %@ && faculty.school.schoolId = %@", [NSNumber numberWithInteger:programId], [NSNumber numberWithInteger:facultyId], [NSNumber numberWithInteger:schoolId]];
    
    NSArray* programArray = [context executeFetchRequest: request error: nil];
    
    self.program = [programArray firstObject];
    
}
         

- (void)reloadFavoriteButtonState
{
    _favButton.selected = [_helper isFavoritedWithDashletUid:self.dashletUid];
}
         

- (void)dismissButtonSelected: (UIBarButtonItem*)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)favoriteButtonPressed: (UIButton*)button
{
    if(!button.selected)
    {
        button.selected = YES;
        [_helper addFavoriteWithDashletUid:self.dashletUid andType:JPDashletTypeProgram];
    }
    else
    {
        button.selected = NO;
        [_helper removeFavoriteWithDashletUid:self.dashletUid];
    }
    
    [academicsController.progressPanView selectCalendarButtonsFromCoreData];
 
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
