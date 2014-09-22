//
//  JPMainFeaturedViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPMainFeaturedViewController.h"
#import "Featured.h"
#import "JPDashlet.h"
#import "JBParallaxPhoneCell.h"
#import "JPCoreDataHelper.h"
#import "iPhProgramViewController.h"
#import "iPhSchoolViewController.h"
#import "UserFavItem.h"
#import "JPDataRequest.h"
#import "NSObject+JPConvenience.h"
#import "JPStyle.h"
#import "iPadProgramViewController.h"
#import "iPadSchoolHomeViewController.h"
#import "JBParallaxCell.h"


@interface JPMainFeaturedViewController ()

@end

@implementation JPMainFeaturedViewController

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
    
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    context = [delegate managedObjectContext];
    
    _helper = [[JPCoreDataHelper alloc] init];
    _dataReq = [[JPDataRequest alloc] init];
    _dataReq.delegate = self;
    _cloudFav = [[JPCloudFavoritesHelper alloc] init];
    _cloudFav.delegate = self;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight + kiPhoneNavigationBarHeight, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait) style:UITableViewStylePlain];
    if([JPStyle isiPad])
        self.tableView.frame = CGRectMake(0, kiPadStatusBarHeight + kiPadNavigationBarHeight, kiPadWidthPortrait, kiPadHeightPortrait-kiPadStatusBarHeight-kiPadNavigationBarHeight-kiPadTabBarHeight);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 150;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_dataReq requestAllFeaturedItems];
}


- (void)dataRequest:(JPDataRequest *)request didLoadAllFeaturedItems:(NSArray *)featuredDicts isSuccessful:(BOOL)success
{
    if(!success)
        return;
    
    self.featuredArray = featuredDicts;
    [self.tableView reloadData];
    
    if([JPStyle isiPad])
        [self reloadFeaturedFavNums];
}


- (void)reloadFeaturedFavNums
{
    self.featuredFavNums = [NSMutableArray array];
    
    for(NSDictionary* featured in self.featuredArray)
    {
        [self.featuredFavNums addObject:@0];
        
        NSInteger rowNum = [self.featuredArray indexOfObject:featured];
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:rowNum inSection:0];
        
        [_cloudFav getItemFavCountAsyncWithUid:[featured objectForKey:@"id"] indexPath:indexPath];
    }
}


- (void)cloudFavHelper:(JPCloudFavoritesHelper *)helper didGetItemFavCountWithUid:(NSString *)programUid cellIndexPath:(NSIndexPath *)indexPath countNumber:(NSInteger)count
{
    if(count >= 0 && count< 999999)
    {
        [self.featuredFavNums replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInteger:count]];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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
    JBParallaxPhoneCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(!cell)
    {
        cell = [[JBParallaxPhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell setFrame:CGRectMake(0, 0, kiPhoneWidthPortrait, 150)];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary* featureItem = self.featuredArray[indexPath.row];
    
    cell.delegate = self;
    cell.itemId = [featureItem objectForKey:@"id"];
    cell.titleLabel.text = [featureItem objectForKey:@"featuredTitle"];
    cell.subtitleLabel.text = [featureItem objectForKey:@"nameTitle"];
    cell.type = [self dashletTypeFromTypeString:[featureItem objectForKey:@"type"]];
    
    cell.separatorInset = UIEdgeInsetsMake(0, 1024, 0, 0);
    
    NSURL* imageUrl = [NSURL URLWithString:[featureItem objectForKey:@"imageLink"]];
    if(imageUrl)
        cell.asyncImageUrl = imageUrl;
    
    //Check if item is selected
    NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
    favReq.predicate = [NSPredicate predicateWithFormat:@"favItemId = %@", cell.itemId];
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
    if([JPStyle isiPad])
    {
        JBParallaxCell* cell = (JBParallaxCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        
        if(cell.type == JPDashletTypeProgram)
        {
            iPadProgramViewController* viewController =[[iPadProgramViewController alloc] initWithItemId:cell.itemId];
            [self presentViewController:viewController animated:YES completion:nil];
        }
        else
        {
            iPadSchoolHomeViewController* schoolViewController = [[iPadSchoolHomeViewController alloc] initWithItemId:cell.itemId type:cell.type];
            UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:schoolViewController];
            [self presentViewController:navController animated:YES completion:nil];
        }
    }
    else
    {
        JBParallaxPhoneCell* cell = (JBParallaxPhoneCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        
        id detailsViewController = nil;
        if(cell.type == JPDashletTypeProgram)
        {
            detailsViewController =[[iPhProgramViewController alloc] initWithItemId:cell.itemId];
        }
        else
        {
            detailsViewController = [[iPhSchoolViewController alloc] initWithItemId:cell.itemId itemType:cell.type];
        }
        [detailsViewController setTitle:cell.subtitle];
        
        UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:detailsViewController];
        [self presentViewController:navController animated:YES completion:nil];
    }
    
}




#pragma mark - JPFavoriteButtonDelegate

- (void)favoriteButtonSelected:(BOOL)selected forCell:(id)sender
{
    JBParallaxPhoneCell* cell = (JBParallaxPhoneCell*)sender;

    if(selected)
    {
        [_helper addFavoriteWithItemId:cell.itemId andType:cell.type];
        
    }
    else //deselected
    {
        [_helper removeFavoriteWithItemId:cell.itemId withType:cell.type];
    }
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *visibleCells = [self.tableView visibleCells];
    
    for (JBParallaxPhoneCell *cell in visibleCells) {
        [cell cellOnTableView:self.tableView didScrollOnView:self.view];
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
