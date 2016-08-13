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
#import "JPStyle.h"
#import "JPDataRequest.h"
#import "ManagedObjects+JPConvenience.h"
#import "DejalActivityView.h"



@interface iPhProgramViewController ()

@end

@implementation iPhProgramViewController

- (instancetype)initWithItemId: (NSString*)itemId
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        context = [delegate managedObjectContext];
        
        self.itemId = itemId;
        _helper = [[JPCoreDataHelper alloc] init];
        
        UIBarButtonItem* dismissItem = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStyleDone target:self action:@selector(dismissButtonSelected:)];
        self.navigationItem.leftBarButtonItem = dismissItem;
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading" width:100];
        [self retrieveProgramInfo];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
 
}




- (void)retrieveProgramInfo
{
    _dataRequest = [JPDataRequest request];
    _dataRequest.delegate = self;
    [_dataRequest requestItemDetailsWithId:self.itemId ofType:JPDashletTypeProgram];

}


- (void)dataRequest:(JPDataRequest *)request didLoadItemDetailsWithId:(NSString *)itemId ofType:(JPDashletType)type dataDict:(NSDictionary *)dict isSuccessful:(BOOL)success
{
    if(!success) {
        return;
    }
    
    self.program = [[Program alloc] initWithDictionary:dict];
    
    self.title = self.program.name;
    
    _favButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [_favButton setImage:[UIImage imageNamed:@"favoriteIcon2Selected"] forState:UIControlStateSelected];
    [_favButton setImage:[UIImage imageNamed:@"favoriteIcon2"] forState:UIControlStateNormal];
    _favButton.selected = [_helper isFavoritedWithItemId:self.itemId];
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
    
    [self.view setNeedsDisplay];
    [DejalBezelActivityView removeViewAnimated:YES];
}


- (void)reloadFavoriteButtonState
{
    _favButton.selected = [_helper isFavoritedWithItemId:self.itemId];
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
        [_helper addFavoriteWithItemId:self.itemId andType:JPDashletTypeProgram];
        
        //Mixpanel
        [[Mixpanel sharedInstance] track:@"Program Favorited"
             properties:@{@"Device Type": [JPStyle deviceTypeString]}];
    }
    else
    {
        button.selected = NO;
        [_helper removeFavoriteWithItemId:self.itemId withType:JPDashletTypeProgram];
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
