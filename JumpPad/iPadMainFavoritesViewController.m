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
#import "JPBannerView.h"
#import "sortViewController.h"
#import "iPadFacultySelectViewController.h"
#import "iPadSchoolHomeViewController.h"
#import "iPadProgramViewController.h"
#import "iPadMainCollectionViewCell.h"
#import "School.h"
#import "Banner.h"

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
    self.cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    [self.cv registerClass:[iPadMainCollectionViewCell class] forCellWithReuseIdentifier:@"featuredItem"];
    [self.cv registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"suppView"];
    
    self.cv.delegate = self;
    self.cv.dataSource = self;
    
    self.cv.backgroundColor = [UIColor clearColor];
    
    
    //Search Bar
    self.searchBarView = [[iPadSearchBarView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight + 200, _screenWidth, 44)];
    self.searchBarView.delegate = self;
    
    //Banner View
    self.bannerView = [[JPBannerView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, _screenWidth, 200)];
    [self.view addSubview:self.bannerView];
//    self.bannerView.frame = CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, _screenWidth, 200);
    
    //Adding subviews
    [self.view addSubview: self.cv];
    [self.view addSubview:self.searchBarView];
    
    //Display all subviews
    [self resizeFrames];
    
    
    //Setting up cv background touch recognizer for keyboard dismissal
    self.cv.backgroundView = [[UIImageView alloc] init];
    self.cv.backgroundView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewBackgroundTapped)];
    self.cv.backgroundView.gestureRecognizers = @[tapRecognizer];

    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.cv reloadData];
    self.cv.frame = CGRectMake(0, kiPadStatusBarHeight + kiPadNavigationBarHeight + 200 + kiPadFilterBarHeight, kiPadWidthPortrait, 660);
    
    //Prevent transparent tab bar
    self.tabBarController.tabBar.translucent = YES;
}


- (void)dismissKeyboard
{
    [self.searchBarView resignFirstResponder];
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
    
    if(_isEditing)
        cell.showFavButton = YES;
    else
        cell.showFavButton = NO;
    
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
    if(_isEditing)
    {
        return;
    }
    
    iPadMainCollectionViewCell* dashlet = (iPadMainCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSUInteger dashletUid  = dashlet.dashletInfo.dashletUid;
    JPDashletType dashletType = dashlet.dashletInfo.type;

    if(dashletType == JPDashletTypeProgram)
    {
        iPadProgramViewController* programVC = [[iPadProgramViewController alloc] initWithDashletUid:dashletUid];
        [self presentViewController:programVC animated:YES
                         completion:nil];
    }
    else //dashlet is School or Faculty
    {
        iPadSchoolHomeViewController* schoolVC = [[iPadSchoolHomeViewController alloc] initWithDashletUid:dashletUid];
        UINavigationController* switchViewController = [[UINavigationController alloc] initWithRootViewController:schoolVC];
        [self presentViewController:switchViewController animated:YES completion:nil];
    }
    
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

#pragma mark - Editing Mode (JPDashletInfo Delegate: favButton)

- (IBAction)editBarButtonPressed:(id)sender {
    
    [super editBarButtonPressed: sender];
    [self.cv reloadData];
}


- (void)favButtonPressed: (iPadMainCollectionViewCell*)sender favorited: (BOOL)fav
{
    NSUInteger dashletUid = sender.dashletInfo.dashletUid;
    [super favButtonPressedIsFavorited: fav dashletUid: dashletUid];
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


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    //Prevent transparent tab bar
    self.tabBarController.tabBar.translucent = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end