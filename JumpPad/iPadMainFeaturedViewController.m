//
//  iPadMainFeaturedViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 12/5/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "iPadMainFeaturedViewController.h"
#import "JPDashlet.h"
#import "iPadMainCollectionViewCell.h"
#import "Featured.h"
#import "JBParallaxCell.h"
#import "UserFavItem.h"
#import "JPGlobal.h"
#import "iPadProgramViewController.h"
#import "iPadSchoolHomeViewController.h"
#import "JPCoreDataHelper.h"
#import "JPCloudFavoritesHelper.h"

@interface iPadMainFeaturedViewController ()

@end

@implementation iPadMainFeaturedViewController

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    context = [delegate managedObjectContext];
    
    _coreDataHelper = [[JPCoreDataHelper alloc] init];
    
    _cloudFav = [[JPCloudFavoritesHelper alloc] init];
    _cloudFav.delegate = self;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight + kiPadNavigationBarHeight, kiPadWidthPortrait, kiPadHeightPortrait-kiPadStatusBarHeight-kiPadNavigationBarHeight-kiPadTabBarHeight) style:UITableViewStylePlain];
    self.tableView.rowHeight = 250 + 20;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    self.featuredArray = [[_coreDataHelper retrieveFeaturedItems] mutableCopy];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    
    //Prevent transparent tab bar
    self.tabBarController.tabBar.translucent = YES;
    
    [self reloadFeaturedFavNums];
}


- (void)reloadFeaturedFavNums
{
    self.featuredFavNums = [NSMutableArray array];
    
    for(Featured* featured in self.featuredArray)
    {
        [self.featuredFavNums addObject:@0];
        
        NSInteger rowNum = [self.featuredArray indexOfObject:featured];
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:rowNum inSection:0];
        
        NSUInteger itemUidInt = [JPGlobal itemIdWithDashletUid:[featured.linkedUid integerValue]];
        NSString* itemUid = [NSString stringWithFormat:@"%d", itemUidInt];
        [_cloudFav getItemFavCountAsyncWithUid:itemUid indexPath:indexPath];
    }
}


#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.featuredArray count];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JBParallaxCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(!cell)
    {
        cell = [[JBParallaxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell setFrame:CGRectMake(0, 0, kiPadWidthPortrait, 270)];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Featured* featureItem = self.featuredArray[indexPath.row];
    JPDashlet* dashletItem = [[JPDashlet alloc] initWithDashletUid:[featureItem.linkedUid integerValue]];
    
    cell.dashletUid = dashletItem.dashletUid;
    cell.delegate = self;
    cell.titleLabel.text = [featureItem.title uppercaseString];
    cell.subtitleLabel.text = [dashletItem.featuredTitle uppercaseString];
    cell.numFavorited = [[self.featuredFavNums objectAtIndex:indexPath.row] integerValue];
    
    cell.type = dashletItem.type;
    NSURL* imageUrl = [NSURL URLWithString:featureItem.imageLink];
    if(imageUrl)
        cell.asyncImageUrl = imageUrl;
    
    //Check if item is selected
    NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
    favReq.predicate = [NSPredicate predicateWithFormat:@"itemId = %@", [NSNumber numberWithInteger:cell.dashletUid]];
    NSArray* results = [context executeFetchRequest:favReq error:nil];
    if([results count] > 0)
    {
        cell.favoriteButton.selected = YES;
    }
    else cell.favoriteButton.selected = NO;
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JBParallaxCell* cell = (JBParallaxCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    if(cell.type == JPDashletTypeProgram)
    {
        iPadProgramViewController* viewController =[[iPadProgramViewController alloc] initWithDashletUid:cell.dashletUid];
        [self presentViewController:viewController animated:YES completion:nil];
    }
    else
    {
        iPadSchoolHomeViewController* schoolViewController = [[iPadSchoolHomeViewController alloc] initWithDashletUid:cell.dashletUid];
        UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:schoolViewController];
        [self presentViewController:navController animated:YES completion:nil];
    }
}


#pragma mark - JPFavoriteButtonDelegate

- (void)favoriteButtonSelected:(BOOL)selected forCell:(id)sender
{
    JBParallaxCell* cell = (JBParallaxCell*)sender;
    NSUInteger dashletUid = cell.dashletUid;
    
    if(selected)
    {
        [_coreDataHelper addFavoriteWithDashletUid:dashletUid andType:cell.type];
    }
    else //deselected
    {
        [_coreDataHelper removeFavoriteWithDashletUid:dashletUid];
    }
    
}



#pragma mark - Cloud Favorites Helper

- (void)cloudFavHelper:(JPCloudFavoritesHelper *)helper didGetItemFavCountWithUid:(NSString *)programUid cellIndexPath:(NSIndexPath*)indexPath countNumber:(NSInteger)count
{
    if(count >= 0 && count< 999999)
    {
        [self.featuredFavNums replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInteger:count]];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *visibleCells = [self.tableView visibleCells];
    
    for (JBParallaxCell *cell in visibleCells) {
        [cell cellOnTableView:self.tableView didScrollOnView:self.view];
    }
    
}


- (void)viewWillDisappear:(BOOL)animated
{
     //Prevent transparent tab bar
     self.tabBarController.tabBar.translucent = NO;
}






@end
