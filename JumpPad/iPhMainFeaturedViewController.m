//
//  JPMainFeaturedViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhMainFeaturedViewController.h"
#import "Featured.h"
#import "JPDashlet.h"
#import "JBParallaxPhoneCell.h"
#import "JPCoreDataHelper.h"
#import "iPhProgramViewController.h"
#import "iPhSchoolViewController.h"
#import "UserFavItem.h"


@interface iPhMainFeaturedViewController ()

@end

@implementation iPhMainFeaturedViewController

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    context = [delegate managedObjectContext];
    
    _helper = [[JPCoreDataHelper alloc] init];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight + kiPhoneNavigationBarHeight, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait) style:UITableViewStylePlain];
    self.tableView.rowHeight = 150;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    
    self.featuredArray = [[_helper retrieveFeaturedItems] mutableCopy];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    
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
    
    Featured* featureItem = self.featuredArray[indexPath.row];
    JPDashlet* dashletItem = [[JPDashlet alloc] initWithDashletUid:[featureItem.linkedUid integerValue]];
    cell.delegate = self;
    cell.dashletUid = dashletItem.dashletUid;
    cell.titleLabel.text = [featureItem.title uppercaseString];
    cell.subtitleLabel.text = [dashletItem.featuredTitle uppercaseString];
    cell.type = dashletItem.type;
    
    cell.separatorInset = UIEdgeInsetsMake(0, 1024, 0, 0);
    
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
    JBParallaxPhoneCell* cell = (JBParallaxPhoneCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    id detailsViewController = nil;
    if(cell.type == JPDashletTypeProgram)
    {
        detailsViewController =[[iPhProgramViewController alloc] initWithDashletUid:cell.dashletUid];
    }
    else
    {
        detailsViewController = [[iPhSchoolViewController alloc] initWithDashletUid:cell.dashletUid itemType:cell.type];
    }
    
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:detailsViewController];
    [self presentViewController:navController animated:YES completion:nil];
}



#pragma mark - JPFavoriteButtonDelegate

- (void)favoriteButtonSelected:(BOOL)selected forCell:(id)sender
{
    JBParallaxPhoneCell* cell = (JBParallaxPhoneCell*)sender;
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
