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
#import "JBParallaxSharedCell.h"
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

#import "Uniq-Swift.h"

@interface JPMainFeaturedViewController ()

@property (nonatomic, strong) JPDataRequest *dataReq;
@property (nonatomic, strong) JPOfflineDataRequest *offlineDataRequest;
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
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight + kiPhoneNavigationBarHeight, self.view.frame.size.width, kiPhoneContentHeightWithHeight([UIScreen mainScreen].bounds.size.height)) style:UITableViewStylePlain];
    self.tableView.rowHeight = [JBParallaxSharedCell requiredHeight];
    
    if([JPStyle isiPad])
    {
        self.tableView.frame = CGRectMake(0, kiPadStatusBarHeight + kiPadNavigationBarHeight, kiPadWidthPortrait, kiPadHeightPortrait-kiPadStatusBarHeight-kiPadNavigationBarHeight-kiPadTabBarHeight);
    }
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (JPUtility.isOfflineMode) {
        _offlineDataRequest = [[JPOfflineDataRequest alloc] init];
        NSArray *items = [_offlineDataRequest requestAllFeaturedItems];
        [self finishedLoadItems:items isSuccessful:true];
    } else {
        [_dataReq requestAllFeaturedItems];
    }
}


- (void)dataRequest:(JPDataRequest *)request didLoadAllFeaturedItems:(NSArray *)featuredDicts isSuccessful:(BOOL)success {
    [self finishedLoadItems:featuredDicts isSuccessful:success];
}

- (void)finishedLoadItems: (NSArray *)featuredDicts isSuccessful: (BOOL)success {
    
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
        __block NSIndexPath* indexPath = [NSIndexPath indexPathForRow:rowNum inSection:0];
        
        [_cloudFav getItemFavCountAsyncWithUid:featured[@"id"] completionHandler:^(BOOL success, NSInteger favoriteCount) {
            if(favoriteCount >= 0)
            {
                [self.featuredFavNums replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInteger:favoriteCount]];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
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
    JBParallaxSharedCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(!cell)
    {
        cell = [[JBParallaxSharedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell setFrame:CGRectMake(0, 0, kiPhoneWidthPortrait, 150)];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary* featureItem = self.featuredArray[indexPath.row];
    
    cell.delegate = self;
    cell.itemId = [featureItem objectForKey:@"id"];
    cell.schoolSlug = [featureItem objectForKey:@"schoolSlug"];
    cell.facultySlug = [featureItem objectForKey:@"facultySlug"];
    cell.programSlug = [featureItem objectForKey:@"programSlug"];
    
    cell.title = [featureItem objectForKey:@"featuredTitle"];
    cell.subtitle = [featureItem objectForKey:@"nameTitle"];
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
            iPadProgramViewController* viewController =[[iPadProgramViewController alloc] initWithItemId:cell.itemId slug:cell.programSlug];
            viewController.title = cell.subtitle;
            [self presentViewController:viewController animated:YES completion:nil];
        }
        else
        {
            iPadSchoolHomeViewController* schoolViewController = [[iPadSchoolHomeViewController alloc] initWithItemId:cell.itemId type:cell.type schoolSlug:cell.schoolSlug facultySlug:cell.facultySlug];
            UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:schoolViewController];
            [self presentViewController:navController animated:YES completion:nil];
        }
    }
    else
    {
        JBParallaxSharedCell* cell = (JBParallaxSharedCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        
        id detailsViewController = nil;
        if(cell.type == JPDashletTypeProgram)
        {
            detailsViewController =[[iPhProgramViewController alloc] initWithItemId:cell.itemId schoolSlug:cell.schoolSlug facultySlug:cell.facultySlug programSlug:cell.facultySlug];
        }
        else
        {
            detailsViewController = [[iPhSchoolViewController alloc] initWithItemId:cell.itemId itemType:cell.type schoolSlug:cell.schoolSlug facultySlug:cell.facultySlug];
        }
        [detailsViewController setTitle:cell.subtitle];
        
        UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:detailsViewController];
        [self presentViewController:navController animated:YES completion:nil];
    }
}



#pragma mark - JPFavoriteButtonDelegate

- (void)favoriteButtonSelected:(BOOL)selected forCell:(id)sender
{
    JBParallaxSharedCell* cell = (JBParallaxSharedCell*)sender;

    if(selected)
    {
        [_helper addFavoriteWithItemId:cell.itemId andType:cell.type schoolSlug:cell.schoolSlug facultySlug:cell.facultySlug programSlug:cell.programSlug];
        
    }
    else //deselected
    {
        [_helper removeFavoriteWithItemId:cell.itemId withType:cell.type];
    }
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *visibleCells = [self.tableView visibleCells];
    
    for (JBParallaxSharedCell *cell in visibleCells) {
        [cell cellOnTableView:self.tableView didScrollOnView:self.view];
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
