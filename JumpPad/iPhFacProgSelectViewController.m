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


@interface iPhFacProgSelectViewController ()

@end

@implementation iPhFacProgSelectViewController

- (instancetype)initWithDashletUid: (NSUInteger)dashletUid forSelectionType: (JPDashletType)type
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        UniqAppDelegate* del = [[UIApplication sharedApplication] delegate];
        context = [del managedObjectContext];
        
        self.type = type;
        self.dashletUid = dashletUid;
        
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
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kiPhoneWidthPortrait, kiPhoneHeightPortrait- kiPhoneStatusBarHeight-kiPhoneNavigationBarHeight-kiPhoneTabBarHeight) style:UITableViewStylePlain];
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
    
    if(self.type == JPDashletTypeFaculty)
    {
        headerString = @"Select a Faculty";
    }
    else if(self.type == JPDashletTypeProgram)
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
    JPDashlet* selectedDashlet = self.dashlets[indexPath.row];
    
    if(self.type == JPDashletTypeFaculty)
    {
        iPhFacProgSelectViewController* programSelectVC = [[iPhFacProgSelectViewController alloc] initWithDashletUid: selectedDashlet.dashletUid forSelectionType:JPDashletTypeProgram];
        programSelectVC.title = selectedDashlet.title;
        
        [self.navigationController pushViewController:programSelectVC animated:YES];
    }
    else //type == JP Dashlet type Program
    {
        iPhProgramViewController* programController = [[iPhProgramViewController alloc] initWithDashletUid:selectedDashlet.dashletUid];
        programController.title = selectedDashlet.title;
        
        UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:programController];
        
        [self presentViewController:navController animated:YES completion:nil];
        
    }
    
}





#pragma mark - Update From Core Data
//Retrieving Faculty info from Core Data and put into featuredDashelts
- (void)updateDashletsInfo
{
    NSMutableArray* dashletArray = [NSMutableArray array];
    //Core Data id and dashlet id are different
    NSInteger coreDataSchoolId = self.dashletUid / 1000000;
    
    if(self.type == JPDashletTypeFaculty)
    {
        NSFetchRequest* dashletRequest = [NSFetchRequest fetchRequestWithEntityName:@"Faculty"];
        dashletRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
        dashletRequest.predicate = [NSPredicate predicateWithFormat:@"school.schoolId = %@", [NSNumber numberWithInteger:coreDataSchoolId]];
        
        NSError* err = nil;
        NSArray* fArray = [context executeFetchRequest:dashletRequest error:&err];
        if(err)
            JPLog(@"ERR: %@", err);
        
        for(Faculty* faculty in fArray)
        {
            JPDashlet* dashlet = [[JPDashlet alloc] initWithFaculty:faculty fromSchool:self.dashletUid];
            [dashletArray addObject:dashlet];
        }
    }
    else //type == JPdashletTypeProgram
    {
        NSInteger coreDataFacultyId = self.dashletUid % 1000000 /1000;
        
        NSFetchRequest* dashletRequest = [NSFetchRequest fetchRequestWithEntityName:@"Program"];
        dashletRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
        dashletRequest.predicate = [NSPredicate predicateWithFormat:@"faculty.facultyId = %@ && faculty.school.schoolId = %@", [NSNumber numberWithInteger:coreDataFacultyId], [NSNumber numberWithInteger:coreDataSchoolId]];
        
        NSError* err = nil;
        NSArray* fArray = [context executeFetchRequest:dashletRequest error:&err];
        if(err)
            JPLog(@"ERR: %@", err);
        
        for(Program* program in fArray)
        {
            JPDashlet* dashlet = [[JPDashlet alloc] initWithProgram:program fromFaculty:self.dashletUid];
            [dashletArray addObject:dashlet];
        }

    }
    
    self.dashlets = dashletArray;
}



#pragma mark - UI Navigation Item Callback Method
- (void)infoButtonPressed: (UIBarButtonItem*)sender
{
    iPhSchoolViewController* viewController = nil;
    
    if(self.type == JPDashletTypeFaculty)
    {
        viewController = [[iPhSchoolViewController alloc] initWithDashletUid:self.dashletUid itemType:JPDashletTypeSchool];
    }
    else //type == JPdashlet Type Program
    {
        viewController = [[iPhSchoolViewController alloc] initWithDashletUid:self.dashletUid itemType:JPDashletTypeFaculty];
    }
    
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navController animated:YES completion:nil];
    
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
