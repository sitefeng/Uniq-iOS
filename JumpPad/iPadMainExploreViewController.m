//
//  iPadMainExploreViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//


#import "iPadMainExploreViewController.h"
#import "JPDashlet.h"
#import "iPadSearchBarView.h"
#import "iPadMainCollectionViewCell.h"
#import "iPadBannerView.h"
#import "sortViewController.h"
#import "iPadFacultySelectViewController.h"
#import "iPadCollegeViewController.h"
#import "iPadMainCollectionViewCell.h"
#import "School.h"
#import "Banner.h"

#import "AFNetworkReachabilityManager.h"


@interface iPadMainExploreViewController ()


@end

@implementation iPadMainExploreViewController


#pragma mark - View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sortType = JPSortTypeAlphabetical;
    
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

    
    _isReachable = false;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN)
        {
            [self networkAvailable];
        }
        else
        {
            _isReachable = false;
        }
    }];
    
    
    //UI Setup
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    
    //UICollectionView
    self.cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight + kiPadNavigationBarHeight + 200 + kiPadFilterBarHeight, kiPadWidthPortrait, kiPadHeightPortrait-kiPadStatusBarHeight - kiPadNavigationBarHeight - 200 -kiPadFilterBarHeight)
                                 collectionViewLayout:layout];
    
    [self.cv registerClass:[iPadMainCollectionViewCell class] forCellWithReuseIdentifier:@"featuredItem"];
    
    self.cv.delegate = self;
    self.cv.dataSource = self;
    
    self.cv.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"greyBackground"]];

    
    //Search Bar
    self.searchBarView = [[iPadSearchBarView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight + 200, _screenWidth, 44)];
    self.searchBarView.delegate = self;
    
    //Banner View
    self.bannerView = [[iPadBannerView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, _screenWidth, 200)];
    
    //Adding subviews
    [self.view addSubview: self.cv];
    [self.view addSubview:self.searchBarView];
    [self.view addSubview:self.bannerView];
    
    //Display all subviews
    [self resizeFrames];
    
    
    //Setting up cv background touch recognizer for keyboard dismissal
    self.cv.backgroundView = [[UIImageView alloc] init];
    self.cv.backgroundView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewBackgroundTapped)];
    self.cv.backgroundView.gestureRecognizers = @[tapRecognizer];
    
    

    //Core Data NS Managed Object Context
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    self.context = [delegate managedObjectContext];
    
    //Initialize banner
    self.bannerURLs = [NSMutableArray array];
    

    
    

    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [self updateDashletsInfo];
    [self.bannerView activateAutoscroll];
    [self.cv reloadData];
    [self updateBannerInfo];
}


- (void)dismissKeyboard
{
    [self.searchBarView resignFirstResponder];
}


- (void)setDashlets:(NSMutableArray *)dashlets
{
    if(!self.backupDashlets)
    {
        self.backupDashlets = [dashlets mutableCopy];
    }
    
    _dashlets = dashlets;
}



#pragma mark - Update From Core Data
//Retrieving College info from Core Data and put into featuredDashelts
- (void)updateDashletsInfo
{
    NSFetchRequest* dashletRequest = [NSFetchRequest fetchRequestWithEntityName:@"School"];
    dashletRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];

    NSError* err = nil;
    NSArray* schoolArray = [self.context executeFetchRequest:dashletRequest error:&err];
    if(err)
        JPLog(@"ERR: %@", err);
    
    NSMutableArray* dashletArray = [NSMutableArray array];
    
    for(School* school in schoolArray)
    {
        JPDashlet* dashlet = [[JPDashlet alloc] initWithSchool:school];
        [dashletArray addObject:dashlet];
    }
    
    self.dashlets = dashletArray;
}


- (void)updateBannerInfo
{
    NSFetchRequest* bannerRequest = [NSFetchRequest fetchRequestWithEntityName:@"Banner"];
    bannerRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"bannerId" ascending:YES]];
    
    NSError* err = nil;
    NSArray* bannerArray = [self.context executeFetchRequest:bannerRequest error:&err];
    if(err)
        JPLog(@"ERR: %@", err);
    
    for(Banner* banner in bannerArray)
    {
        NSURL* bannerURL = [NSURL URLWithString:banner.bannerLink];
        [self.bannerURLs addObject: bannerURL];
    }

    [self.bannerView setImgArrayURL:self.bannerURLs];
    
}





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
                             self.cv.frame = CGRectMake(0, kiPadStatusBarHeight + kiPadNavigationBarHeight + 200 + kiPadFilterBarHeight, kiPadWidthPortrait, kiPadHeightPortrait-kiPadStatusBarHeight - kiPadNavigationBarHeight - 200 -kiPadFilterBarHeight);
                             
                             self.searchBarView.frame = CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight + 200, _screenWidth, 44);
                         }
                         else
                         {
                             self.cv.frame = CGRectMake(0, kiPadStatusBarHeight + kiPadNavigationBarHeight + 200 + kiPadFilterBarHeight, kiPadWidthLandscape, kiPadHeightLandscape-kiPadStatusBarHeight - kiPadNavigationBarHeight - 200 -kiPadFilterBarHeight);
                             self.searchBarView.frame = CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight + 200, _screenWidth, 44);
                         }
                         
                     } completion:^(BOOL finished) {
                         
                     }];
    
}



#pragma mark - UICollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dashlets count];
    //    return 44;
    
}


- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    iPadMainCollectionViewCell* cell = [self.cv dequeueReusableCellWithReuseIdentifier:@"featuredItem" forIndexPath:indexPath];
    
    
    cell.dashletInfo = self.dashlets[indexPath.item];
    cell.delegate = self;
    
    return cell;
}

//Header and Footer
//-(UICollectionReusableView*) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath


#pragma mark - UICollectionView Delegate Methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    iPadFacultySelectViewController* viewController = [[iPadFacultySelectViewController alloc] init];
    
    JPDashlet* selectedDashlet = (JPDashlet*) self.dashlets[indexPath.row];
    
    viewController.title = selectedDashlet.title;
    viewController.schoolId = selectedDashlet.dashletUid;
    
    [self.navigationController pushViewController:viewController animated:YES];
}


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




#pragma mark - JPSearchBar Delegate Methods

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString* query = searchBar.text;
    NSMutableArray* array = [NSMutableArray array];
   
    for(int i=0; i<[self.dashlets count]; i++)
    {
        JPDashlet* d = self.dashlets[i];
        if([d.title rangeOfString:query options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [array addObject:d];
        }
    }
    
    self.dashlets = array;
    [self.cv reloadData];
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




#pragma mark - JPSearchBar Delegate Methods



- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if([searchText isEqual:@""])
    {
        //use self.sortType LATER!
        self.dashlets = [[self.backupDashlets sortedArrayUsingSelector:@selector(compareWithName:)] mutableCopy];
        [self.cv reloadData];
    }

}



#pragma mark - JPDashlet Info Delegate

- (void)infoButtonPressed:(iPadMainCollectionViewCell *)sender
{
    iPadCollegeViewController* viewController = [[iPadCollegeViewController alloc] initWithNibName:@"iPadCollegeViewController" bundle:[NSBundle mainBundle]];
    
    viewController.itemUid = sender.dashletInfo.dashletUid;
    
    [self presentViewController:viewController animated:YES completion:nil];
}



- (void)networkAvailable
{
    _isReachable = true;
    
    [self updateDashletsInfo];
    [self.cv reloadData];
    [self updateBannerInfo];
    
    JPLog(@"Reconnected to Internet");
}


#pragma mark - Keyboard Dismissal with touchRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    [self.view endEditing:YES];
}


- (void)collectionViewBackgroundTapped
{
    [self.view endEditing:YES];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self.bannerView pauseAutoscroll];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
