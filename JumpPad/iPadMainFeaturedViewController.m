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

#import "iPadProgramViewController.h"
#import "iPadSchoolHomeViewController.h"
#import "JPCoreDataHelper.h"

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
    
    _helper = [[JPCoreDataHelper alloc] init];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight + kiPadNavigationBarHeight, kiPadWidthPortrait, kiPadHeightPortrait-kiPadStatusBarHeight-kiPadNavigationBarHeight-kiPadTabBarHeight) style:UITableViewStylePlain];
    self.tableView.rowHeight = 250 + 20;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    

    self.featuredArray = [[_helper retrieveFeaturedItems] mutableCopy];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    
    //Prevent transparent tab bar
    self.tabBarController.tabBar.translucent = YES;
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
        NSEntityDescription* newFavItemDes = [NSEntityDescription  entityForName:@"UserFavItem" inManagedObjectContext:context];
        UserFavItem* newItem = (UserFavItem*)[[NSManagedObject alloc] initWithEntity:newFavItemDes insertIntoManagedObjectContext:context];
        
        newItem.itemId = [NSNumber numberWithInteger:dashletUid];
        newItem.type = [NSNumber numberWithInteger:cell.type];
        
        [context insertObject:newItem];
        
    }
    else //deselected
    {
        NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
        favReq.predicate = [NSPredicate predicateWithFormat:@"itemId = %@", [NSNumber numberWithInteger:dashletUid]];
        NSArray* results = [context executeFetchRequest:favReq error:nil];
        
        for(UserFavItem* item in results)
        {
            [context deleteObject:item];
        }
        
    }
    
    NSError* error = nil;
    [context save:&error];
    if(error)
    {
        NSLog(@"fav error: %@\n", error);
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
