//
//  iPadMainFavoritesViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "iPadMainFavoritesViewController.h"
#import "JPDashlet.h"
#import "iPadSearchBarView.h"
#import "iPadMainCollectionViewCell.h"
#import "iPadBannerView.h"
#import "sortViewController.h"
#import "iPadFacultySelectViewController.h"

#import "iPadMainCollectionViewCell.h"
#import "School.h"
#import "Banner.h"
#import "UserFavItem.h"
#import "JPFont.h"

@interface iPadMainFavoritesViewController ()

@end

@implementation iPadMainFavoritesViewController



#pragma mark - View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
    self.sortType = JPSortTypeAlphabetical;
    
    //Core Data NS Managed Object Context
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    context = [delegate managedObjectContext];
    
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
    
    
    //UI Setup
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    
    //UICollectionView
    self.cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight + kiPadNavigationBarHeight + 200 + kiPadFilterBarHeight, kiPadWidthPortrait, kiPadHeightPortrait-kiPadStatusBarHeight - kiPadNavigationBarHeight - 200 -kiPadFilterBarHeight)
                                 collectionViewLayout:layout];
    
    [self.cv registerClass:[iPadMainCollectionViewCell class] forCellWithReuseIdentifier:@"featuredItem"];
    [self.cv registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"suppView"];
    
    self.cv.delegate = self;
    self.cv.dataSource = self;
    
    self.cv.backgroundColor = [UIColor clearColor];
    
    
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
    NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
    
    favReq.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"itemId" ascending:YES]];
    
    NSError* err = nil;
    NSArray* favResults = [context executeFetchRequest:favReq error:&err];
    if(err)
        JPLog(@"ERR: %@", err);
    
    NSMutableArray* dashletArray = [NSMutableArray arrayWithObjects:[@[] mutableCopy],[@[] mutableCopy],[@[] mutableCopy], nil];
    
    _dashletTypeCounts = [NSMutableArray arrayWithObjects:@0,@0,@0, nil];
    for(UserFavItem* favItem in favResults)
    {
        JPDashlet* dashlet = [[JPDashlet alloc] initWithDashletUid:[favItem.itemId integerValue]];
        
        //Knowing which type exists for displaying dashelts
        int typeCount = [[_dashletTypeCounts objectAtIndex:dashlet.type] integerValue];
        [_dashletTypeCounts replaceObjectAtIndex:dashlet.type withObject: [NSNumber numberWithInt:1+typeCount]];
        
        [dashletArray[dashlet.type] addObject:dashlet];
    }
    
    self.dashlets = dashletArray;
}


- (void)updateBannerInfo
{
    NSFetchRequest* bannerRequest = [NSFetchRequest fetchRequestWithEntityName:@"Banner"];
    bannerRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"bannerId" ascending:YES]];
    
    NSError* err = nil;
    NSArray* bannerArray = [context executeFetchRequest:bannerRequest error:&err];
    if(err)
        JPLog(@"ERR: %@", err);
    
    for(Banner* banner in bannerArray)
    {
        NSURL* bannerURL = [NSURL URLWithString:banner.bannerLink];
        [self.bannerURLs addObject: bannerURL];
    }
    
    [self.bannerView setImgArrayURL:self.bannerURLs];
    
}




#pragma mark - UICollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return [_dashletTypeCounts[section] integerValue];
}


- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    iPadMainCollectionViewCell* cell = [self.cv dequeueReusableCellWithReuseIdentifier:@"featuredItem" forIndexPath:indexPath];
    
    cell.dashletInfo = self.dashlets[indexPath.section][indexPath.item];
    cell.delegate = self;
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kiPadWidthPortrait, 35);
    
}


- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(kind != UICollectionElementKindSectionHeader)
    {
        return nil;
    }
    
    UICollectionReusableView* view = [self.cv dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"suppView" forIndexPath:indexPath];
    
    NSArray* headerStrings = @[@"Favorite Schools",@"Favorite Faculties",@"Favorite Programs"];
    
    UILabel* label = [[view subviews] firstObject];
    if(!label)
    {
        label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 500, view.frame.size.height)];
        label.font = [UIFont fontWithName:[JPFont defaultFont] size:17];
        label.textColor = [UIColor whiteColor];
        [view addSubview:label];
    
    }
    
    label.text = [headerStrings[indexPath.section] uppercaseString];
    
    return view;
}



#pragma mark - UICollectionView Delegate Methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    

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
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:3];
    
    for(int typeCnt = 0; typeCnt<3; typeCnt++)
    {
        for(int i=0; i<[self.dashlets[typeCnt] count]; i++)
        {
            JPDashlet* d = self.dashlets[typeCnt][i];
            if([d.title rangeOfString:query options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                [array[typeCnt] addObject:d];
            }
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
        
        for(int i=0; i<3;i++)
        {
            self.dashlets[i] = [[self.dashlets[i] sortedArrayUsingSelector:@selector(compareWithName:)] mutableCopy];
        }
        
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





#pragma mark - Editing Mode

- (IBAction)editBarButtonPressed:(id)sender {
    
    
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end