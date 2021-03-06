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
#import "JPDataRequest.h"
#import "DejalActivityView.h"

#import "Uniq-Swift.h"

@interface iPhSchoolViewController () <JPDataRequestDelegate>

@property (nonatomic, strong) JPDataRequest *dataRequest;
@property (nonatomic, strong) JPOfflineDataRequest *offlineDataRequest;

@end

@implementation iPhSchoolViewController

- (instancetype)initWithItemId:(NSString*)itemId itemType: (JPDashletType)type schoolSlug: (NSString *)schoolSlug facultySlug: (NSString *)facultySlug
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.itemId=  itemId;
        self.type = type;
        _schoolSlug = schoolSlug;
        _facultySlug = facultySlug;
        
        _coreDataHelper = [[JPCoreDataHelper alloc] init];
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading" width:100];
        if (JPUtility.isOfflineMode) {
            _offlineDataRequest = [[JPOfflineDataRequest alloc] init];
            
            if (type == JPDashletTypeFaculty) {
                [_offlineDataRequest requestFacultyDetails:_schoolSlug facultySlug:_facultySlug itemUid:_itemId completion:^(BOOL success, NSDictionary<NSString *,id> * _Nonnull dataDict) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self finishedLoadingDetailsOfType:type dataDict:dataDict isSuccessful:success];
                    });
                }];
                            
            } else {
                [_offlineDataRequest requestSchoolDetails:_schoolSlug itemUid:_itemId completion:^(BOOL success, NSDictionary<NSString *,id> * _Nonnull dataDict) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self finishedLoadingDetailsOfType:type dataDict:dataDict isSuccessful:success];
                    });
                }];
            }
            
        } else {
            _dataRequest = [JPDataRequest request];
            _dataRequest.delegate = self;
            [_dataRequest requestItemDetailsWithId:itemId ofType:type];
        }
        
        //NavBar Items
        self.title = [self.schoolOrFaculty name];
        
        UIBarButtonItem* dismissButton = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStyleDone target:self action:@selector(dismissButtonPressed:)];
        self.navigationItem.leftBarButtonItem = dismissButton;
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}



- (void)dataRequest:(JPDataRequest *)request didLoadItemDetailsWithId:(NSString *)itemId ofType:(JPDashletType)type dataDict:(NSDictionary *)dict isSuccessful:(BOOL)success {
    [self finishedLoadingDetailsOfType:type dataDict:dict isSuccessful:success];
}

- (void)finishedLoadingDetailsOfType: (JPDashletType)type dataDict: (NSDictionary *)dict isSuccessful: (BOOL)success {
    if(!success) {
        return;
    }
    
    if(type == JPDashletTypeSchool)
    {
        self.schoolOrFaculty = [[School alloc] initWithDictionary:dict];
    }
    else if (type == JPDashletTypeFaculty)
    {
        self.schoolOrFaculty = [[Faculty alloc] initWithDictionary:dict];
    }
    
    //Nav Bar Item
    UIButton* favButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [favButton setImage:[UIImage imageNamed:@"favoriteIcon2Selected"] forState:UIControlStateSelected];
    [favButton setImage:[UIImage imageNamed:@"favoriteIcon2"] forState:UIControlStateNormal];
    favButton.selected = [_coreDataHelper isFavoritedWithItemId:self.itemId];
    [favButton addTarget:self action:@selector(favoriteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* favoriteItem = [[UIBarButtonItem alloc] initWithCustomView:favButton];
    self.navigationItem.rightBarButtonItem = favoriteItem;
    
    //Initializing the Home and Contact Controllers
    self.title = [self.schoolOrFaculty name];
    
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
    contactController.tabBarItem.image = [UIImage imageNamed:@"contact"];
    self.viewControllers = @[homeController, contactController];
    
    [DejalBezelActivityView removeViewAnimated:YES];
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
        [_coreDataHelper addFavoriteWithItemId:self.itemId andType:self.type schoolSlug:self.schoolSlug facultySlug:self.facultySlug programSlug:nil];
    }
    else
    {
        button.selected = NO;
        [_coreDataHelper removeFavoriteWithItemId:self.itemId withType:self.type];
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
