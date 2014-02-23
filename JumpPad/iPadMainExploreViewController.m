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

@interface iPadMainExploreViewController ()

@end

@implementation iPadMainExploreViewController


#pragma mark - View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    

    
    [self updateDashletsInfo];
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    
    //Creating all the Views with CGRectZero Frame Size
    ///////////////////////
    
    //UICollectionView
    self.cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight + kiPadNavigationBarHeight + 200 + kiPadFilterBarHeight, kiPadWidthPortrait, kiPadHeightPortrait-kiPadStatusBarHeight - kiPadNavigationBarHeight - 200 -kiPadFilterBarHeight)
                                 collectionViewLayout:layout];
    
    [self.cv registerClass:[iPadMainCollectionViewCell class] forCellWithReuseIdentifier:@"featuredItem"];
    
    self.cv.delegate = self;
    self.cv.dataSource = self;
    
    self.cv.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"greyBackground"]];
    
    //Search Bar
    self.searchBarView = [[iPadSearchBarView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight + 200, _screenWidth, 44)];
    
    //Banner View
    self.bannerView = [[iPadBannerView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, _screenWidth, 200)];
    
    
    
    //Adding subviews
    [self.view addSubview: self.cv];
    [self.view addSubview:self.searchBarView];
    [self.view addSubview:self.bannerView];
    
    
    //Display all subviews
    [self resizeFrames];
}

#pragma mark - Update Model
//Retrieving College info from Core Data and put into featuredDashelts
- (void)updateDashletsInfo
{
    //Just a MOCK-UP right now
    
    //This should be done for us in JPDashlet
    JPDashlet* d1 = [[JPDashlet alloc] initWithItemUID:@"0001000000"];
    d1.location.cityName = @"waterloo";
    d1.location.countryName = @"Canada";
    d1.location.coordinates = [JPLocation coordinatesForCity:@"toronto"];
    d1.title = @"University of Waterloo";
    d1.type= JPDashletTypeCollege;
    d1.backgroundImages = [@[[UIImage imageNamed:@"waterloo1"],[UIImage imageNamed:@"waterloo2"],[UIImage imageNamed:@"waterloo3"],[UIImage imageNamed:@"waterloo4"],[UIImage imageNamed:@"waterloo5"],[UIImage imageNamed:@"waterloo6"]] mutableCopy];
    d1.details = @{@"population":@32567,@"establishedin":@1864};
    d1.icon = [UIImage imageNamed:@"waterloo"];
    
    JPDashlet* d2 = [[JPDashlet alloc] initWithItemUID:@"0002000000"];
    d2.title = @"University of Toronto";
    d2.icon = [UIImage imageNamed:@"toronto"];
    
    d2.location.cityName = @"toronto";
    d2.location.countryName = @"Canada";
    d2.location.coordinates = [JPLocation coordinatesForCity:@"toronto"];
    
    d2.type= JPDashletTypeCollege;
    d2.backgroundImages = [@[[UIImage imageNamed:@"toronto1"],[UIImage imageNamed:@"toronto2"],[UIImage imageNamed:@"toronto3"]] mutableCopy];
    d2.details = @{@"population":@32567,@"establishedin":@1864};
    
    
    JPDashlet* d3 = [d1 copy];
    d3.title = @"University of Western Ontario";
    d3.backgroundImages = nil;
    d3.icon = [UIImage imageNamed:@"western"];
    
    JPDashlet* d4 = [d1 copy];
    d4.title = @"Ryerson University";
    d4.backgroundImages = [@[[UIImage imageNamed:@"ryerson1"],[UIImage imageNamed:@"ryerson2"],[UIImage imageNamed:@"ryerson3"]] mutableCopy];
    d4.icon = [UIImage imageNamed:@"ryerson"];
    
    NSMutableArray* dashletArray = [@[d1,d2,d3,d4] mutableCopy];
    
    self.featuredDashlets = dashletArray;
    
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
    return [self.featuredDashlets count];
    //    return 44;
    
}


- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    iPadMainCollectionViewCell* cell = [self.cv dequeueReusableCellWithReuseIdentifier:@"featuredItem" forIndexPath:indexPath];
    
    cell.dashletInfo = self.featuredDashlets[indexPath.item];
    
    return cell;
}

//Header and Footer
//-(UICollectionReusableView*) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//
//
//}



#pragma mark - UICollectionView Delegate FlowLayout

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









- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
