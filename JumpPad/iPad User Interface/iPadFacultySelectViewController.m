//
//  iPadFacultySelectViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-05.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadFacultySelectViewController.h"
#import "JPDashlet.h"
#import "iPadSearchBarView.h"
#import "iPadMainCollectionViewCell.h"
#import "iPadFacultyBannerView.h"
#import "sortViewController.h"
#import "iPadProgramSelectViewController.h"
#import "iPadSchoolHomeViewController.h"
#import "iPadMainCollectionViewCell.h"
#import "Faculty.h"
#import "JPDataRequest.h"
#import "DejalActivityView.h"


@interface iPadFacultySelectViewController ()

@end

@implementation iPadFacultySelectViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        UIBarButtonItem* infoItem = [[UIBarButtonItem alloc] initWithTitle:@"General Info" style:UIBarButtonItemStyleDone target:self action:@selector(schoolInfoPressed)];
        self.navigationItem.rightBarButtonItem = infoItem;

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"edgeBackground"]];
    //Getting current device orientation
    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation))
    {
        _isOrientationPortrait = YES;
        _screenWidth = kiPadWidthPortrait;
    }
    else
    {
        _isOrientationPortrait = NO;
        _screenWidth = kiPadWidthLandscape;
    }
    
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    
    //UICollectionView
    self.cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight + kiPadNavigationBarHeight + 200 + kiPadFilterBarHeight, kiPadWidthPortrait, 660)
                                 collectionViewLayout:layout];
    
    [self.cv registerClass:[iPadMainCollectionViewCell class] forCellWithReuseIdentifier:@"featuredItem"];
    
    self.cv.delegate = self;
    self.cv.dataSource = self;
    
    self.cv.backgroundColor = [UIColor clearColor];
    
    
    //Search Bar
    self.searchBarView = [[iPadSearchBarView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight + 200, _screenWidth, 44)];
    self.searchBarView.delegate = self;
    
    //Facuty Banner View
    self.bannerView = [[iPadFacultyBannerView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, _screenWidth, 200) withDashlet:self.schoolDashlet];
    
    
    //Adding subviews
    [self.view addSubview: self.cv];
    [self.view addSubview:self.searchBarView];
    [self.view addSubview:self.bannerView];
    
    //Display all subviews
    [self resizeFrames];
    
    
    
    
    //Sort
    self.sortType = JPSortTypeAlphabetical;
    
    
    //Keyboard Dismissal
    self.cv.backgroundView = [[UIImageView alloc] init];
    self.cv.backgroundView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewBackgroundTapped)];
    self.cv.backgroundView.gestureRecognizers = @[tapRecognizer];
    

    
    //Core Data NS Managed Object Context
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    self.context = [delegate managedObjectContext];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateDashletsInfo];
    
    //Prevent transparent tab bar
    self.tabBarController.tabBar.translucent = YES;
}


- (void)setSchoolDashlet:(JPDashlet *)schoolDashlet
{
    _schoolDashlet = schoolDashlet;
    
    self.bannerView.dashlet = schoolDashlet;
}



#pragma mark - Update From Core Data
//Retrieving College info from Core Data and put into featuredDashelts
- (void)updateDashletsInfo
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading" width:100];
    _dataRequest = [JPDataRequest request];
    _dataRequest.delegate = self;
    
    [_dataRequest requestAllFacultiesFromSchool:self.schoolId allFields:NO];
    
}


- (void)dataRequest:(JPDataRequest *)request didLoadAllItemsOfType:(JPDashletType)type allFields:(BOOL)fullFields withDataArray:(NSArray *)array isSuccessful:(BOOL)success
{
    [DejalBezelActivityView removeViewAnimated:YES];
    if(!success)
        return;
    
    self.dashlets = [NSMutableArray array];
    for (NSDictionary* facultyDict in array)
    {
        JPDashlet* dashlet = [[JPDashlet alloc] initWithDictionary:facultyDict ofDashletType:JPDashletTypeFaculty ];
        [self.dashlets addObject:dashlet];
    }
    
    self.originalDashlets = [self.dashlets copy];
    
    [self.cv reloadData];
}



#pragma mark - UICollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dashlets count];
}


- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    iPadMainCollectionViewCell* cell = [self.cv dequeueReusableCellWithReuseIdentifier:@"featuredItem" forIndexPath:indexPath];
    
    if([self.dashlets count]>indexPath.item)
    {
        cell.dashletInfo = self.dashlets[indexPath.item];
        
    }
    
    cell.delegate = self;
    
    return cell;
}

//Header and Footer
//-(UICollectionReusableView*) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//
//
//}

#pragma mark - UICollectionView Delegate

//Dashlet Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize;
    
    if(_isOrientationPortrait)
    {
        itemSize = kiPadDashletSizePortrait;
    }
    else
    {
        itemSize = kiPadDashletSizeLandscape;
    }
    
    return itemSize;
}

//Dashlet Border
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(kiPadDashletMargin, kiPadDashletMargin, kiPadDashletMargin, kiPadDashletMargin);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    iPadProgramSelectViewController* viewController = [[iPadProgramSelectViewController alloc] init];
    
    JPDashlet* selectedDashlet = (JPDashlet*) self.dashlets[indexPath.row];
    
    viewController.title = selectedDashlet.title;
    viewController.facultyId = selectedDashlet.itemId;
    viewController.facultyDashlet = selectedDashlet;
    
    [self.navigationController pushViewController:viewController animated:YES];
}



#pragma mark - JPSearchBar Delegate Methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([searchText isEqual:@""] || !searchText)
    {
        self.dashlets = [self.originalDashlets copy];
        return;
    }
    
    NSInteger beforeCellCount = [self.dashlets count];
    
    NSMutableArray* array = [NSMutableArray array];
    
    for(int i=0; i<[self.originalDashlets count]; i++)
    {
        JPDashlet* d = self.originalDashlets[i];
        if([d.title rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [array addObject:d];
        }
    }
    
    self.dashlets = array;
    
    if(beforeCellCount != [self.dashlets count])
        [self.cv reloadData];
}


- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString* searchText = searchBar.text;
    
    [self searchBar:searchBar textDidChange:searchText];
    [self.searchBarView.searchBar resignFirstResponder];
}


- (void)sortButtonPressed:(UIButton*)button
{
    
    sortViewController* vc = [[sortViewController alloc] init];
    vc.delegate = self;
    vc.sortType = self.sortType;
    
    UIPopoverController* popover = [[UIPopoverController alloc] initWithContentViewController:vc];
    
    popover.popoverContentSize = CGSizeMake(220, 4 * 45);
    popover.delegate = self;
    
    self.localPopoverController = popover;
    
    [self.localPopoverController presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(self.sortType == indexPath.row)
    {
    }
    else
    {
        self.sortType = indexPath.row;
        
        //Add NSSortDescriptor Later!! only Alphabetically right now
        
        self.dashlets = [[self.dashlets sortedArrayUsingSelector:@selector(compareWithName:)] mutableCopy];
        
        [self.cv reloadData];
    }
    
    [self.localPopoverController dismissPopoverAnimated:YES];
}





#pragma mark - JPDashlet Info Delegate

- (void)infoButtonPressed:(iPadMainCollectionViewCell *)sender
{
    iPadSchoolHomeViewController* viewController = [[iPadSchoolHomeViewController alloc] initWithItemId:sender.dashletInfo.itemId type:JPDashletTypeFaculty schoolSlug:sender.dashletInfo.schoolSlug facultySlug:sender.dashletInfo.facultySlug];
    
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self presentViewController:navController animated:YES completion:nil];
}


- (void)schoolInfoPressed {
    
    iPadSchoolHomeViewController* viewController = [[iPadSchoolHomeViewController alloc] initWithItemId:self.schoolId type:JPDashletTypeSchool schoolSlug:self.schoolDashlet.schoolSlug facultySlug:nil];
    
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self presentViewController:navController animated:YES completion:nil];
    
    
}



////************************************************************************



#pragma mark - Handle View Frame Change

//when device rotated, resize all subviews
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
        _isOrientationPortrait = NO;
        _screenWidth = kiPadWidthLandscape;
    }
    else if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation))
    {
        _isOrientationPortrait = YES;
        _screenWidth = kiPadWidthPortrait;
    }
    
    [self resizeFrames];
}


//when device orientation changed and view just loaded, change dashlet frames for CGRectZero to a neat layout
- (void)resizeFrames
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         //using orientation iVar to track which orientation will the frame set for
                         if(_isOrientationPortrait)
                         {
                             self.cv.frame = CGRectMake(0, kiPadStatusBarHeight + kiPadNavigationBarHeight + 140 + kiPadFilterBarHeight, kiPadWidthPortrait, kiPadHeightPortrait-kiPadStatusBarHeight - kiPadNavigationBarHeight - 140 -kiPadFilterBarHeight);
                             
                             self.searchBarView.frame = CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight + 200, _screenWidth, 44);
                         }
                         else
                         {
                             self.cv.frame = CGRectMake(0, kiPadStatusBarHeight + kiPadNavigationBarHeight + 140 + kiPadFilterBarHeight, kiPadWidthLandscape, kiPadHeightLandscape-kiPadStatusBarHeight - kiPadNavigationBarHeight - 140 -kiPadFilterBarHeight);
                             self.searchBarView.frame = CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight + 200, _screenWidth, 44);
                         }
                         
                     } completion:^(BOOL finished) {
                         
                     }];
    
}


#pragma mark - Keyboard Dismissal

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)collectionViewBackgroundTapped
{
    [self.view endEditing:YES];
}


- (void)dismissKeyboard
{
    [self.searchBarView resignFirstResponder];
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
