//
//  iPhFacProgSelectViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhFacProgSelectViewController.h"
#import "JPDashlet.h"
#import "iPhMainTableViewCell.h"
#import "iPhSchoolViewController.h"
#import "iPhProgramViewController.h"
#import "Mixpanel.h"
#import "JPDataRequest.h"
#import "JPConnectivityManager.h"
#import "DejalActivityView.h"

#import "Uniq-Swift.h"


@interface iPhFacProgSelectViewController () <JPDataRequestDelegate, JPOfflineDataRequestDelegate>

@property (nonatomic, strong) JPDataRequest *dataRequest;
@property (nonatomic, strong) JPOfflineDataRequest *offlineDataRequest;

@end

@implementation iPhFacProgSelectViewController

- (instancetype)initWithItemId:(NSString*)itemId schoolSlug: (NSString *)schoolSlug facultySlug: (NSString *)facultySlug forSelectionType: (JPDashletType)type
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDashletsInfo) name:kNeedUpdateDataNotification object:nil];
        
        UniqAppDelegate* del = [[UIApplication sharedApplication] delegate];
        context = [del managedObjectContext];
        
        _type = type;
        _itemId = itemId;
        _schoolSlug = schoolSlug;
        _facultySlug = facultySlug;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem* infoButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Info" style:UIBarButtonItemStyleDone target:self action:@selector(infoButtonPressed:)];
    self.navigationItem.rightBarButtonItem = infoButtonItem;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[iPhMainTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self.view addSubview:self.tableView];
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateDashletsInfo];
    
}


#pragma mark - UI Table View Data Source and Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dashlets count];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    iPhMainTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    cell.separatorInset = UIEdgeInsetsZero;
    JPDashlet* dashlet = self.dashlets[indexPath.row];
    
    cell.dashletInfo = dashlet;
    
    return cell;
}



- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* headerString = @"Select An Item";
    
    if(self.type == JPDashletTypeSchool)
    {
        headerString = @"Select a Faculty";
    }
    else if(self.type == JPDashletTypeFaculty)
    {
        headerString = @"Select a Program";
    }
    
    return headerString;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 81;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JPDashlet* selectedDashlet = self.dashlets[indexPath.row];
    
    if(self.type == JPDashletTypeSchool)
    {
        iPhFacProgSelectViewController* programSelectVC = [[iPhFacProgSelectViewController alloc] initWithItemId:selectedDashlet.itemId schoolSlug:self.schoolSlug facultySlug:selectedDashlet.facultySlug forSelectionType:JPDashletTypeFaculty];
        
        programSelectVC.title = selectedDashlet.title;
        
        [self.navigationController pushViewController:programSelectVC animated:YES];
    }
    else if(self.type == JPDashletTypeFaculty)
    {
        iPhProgramViewController* programController = [[iPhProgramViewController alloc] initWithItemId:selectedDashlet.itemId schoolSlug:self.schoolSlug facultySlug:self.facultySlug programSlug:selectedDashlet.programSlug];
        [programController setTitle:selectedDashlet.title];
        
        //Mixpanel
        [[Mixpanel sharedInstance] track:@"Selected Program"
                              properties:@{@"Device Type": [JPStyle deviceTypeString], @"Cell Dashlet Title": selectedDashlet.title}];
        //////////////////////////////////
        
        UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:programController];
        
        [self presentViewController:navController animated:YES completion:nil];
    }
}


#pragma mark - Update Dashlet Info

- (void)updateDashletsInfo
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading" width:100];
    
    if (JPUtility.isOfflineMode) {
        _offlineDataRequest = [[JPOfflineDataRequest alloc] init];
        _offlineDataRequest.delegate = self;
        
        if(self.type == JPDashletTypeSchool)
            [_offlineDataRequest requestAllFacultiesFromSchool: self.schoolSlug];
        else
            [_offlineDataRequest requestAllProgramsFromFaculty:self.schoolSlug facultySlug:self.facultySlug];
    } else {
        _dataRequest = [JPDataRequest request];
        _dataRequest.delegate = self;
        
        if(self.type == JPDashletTypeSchool)
            [_dataRequest requestAllFacultiesFromSchool:self.itemId allFields:NO];
        else
            [_dataRequest requestAllProgramsFromFaculty:self.itemId allFields:NO];
    }
}


#pragma mark - Delegate Methods
- (void)offlineDataRequest:(JPOfflineDataRequest *)request didLoadAllItemsOfType:(JPDashletType)type dataArray:(NSArray *)dataArray isSuccessful:(BOOL)isSuccessful {
    [self finishedLoadingRequestWithType:type dataArray:dataArray isSuccess:isSuccessful];
}

- (void)dataRequest:(JPDataRequest *)request didLoadAllItemsOfType:(JPDashletType)type allFields:(BOOL)fullFields withDataArray:(NSArray *)array isSuccessful:(BOOL)success {
    
    [self finishedLoadingRequestWithType:type dataArray:array isSuccess:success];
}


- (void)finishedLoadingRequestWithType: (JPDashletType)type dataArray: (NSArray *)array isSuccess:(BOOL)success {
    
    [DejalBezelActivityView removeViewAnimated:YES];
    if(!success)
        return;
    
    self.dashlets = [NSMutableArray array];
    for(NSDictionary* itemDict in array)
    {
        JPDashlet* dashlet = [[JPDashlet alloc] initWithDictionary:itemDict ofDashletType:type];
        [self.dashlets addObject:dashlet];
    }
    
    [self.tableView reloadData];
}


#pragma mark - UI Navigation Item Callback Method
- (void)infoButtonPressed: (UIBarButtonItem*)sender
{
    iPhSchoolViewController* viewController = nil;
    
    viewController = [[iPhSchoolViewController alloc] initWithItemId:self.itemId itemType:self.type schoolSlug:_schoolSlug facultySlug:_facultySlug];
    
    viewController.title = self.title;
    
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navController animated:YES completion:nil];
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
