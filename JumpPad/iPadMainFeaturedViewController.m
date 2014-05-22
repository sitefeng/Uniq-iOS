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

#import "JBParallaxCell.h"

@interface iPadMainFeaturedViewController ()

@end

@implementation iPadMainFeaturedViewController

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Getting current device orientation
    if(UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation))
    {
        _isOrientationPortrait = YES;
    }
    else
    {
        _isOrientationPortrait = NO;
    }
    
    self.view.backgroundColor = [JPStyle mainViewControllerDefaultBackgroundColor];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight + kiPadNavigationBarHeight, kiPadWidthPortrait, kiPadHeightPortrait-kiPadStatusBarHeight-kiPadNavigationBarHeight-kiPadTabBarHeight) style:UITableViewStylePlain];
    
    self.tableView.rowHeight = 250 + 20;
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    
    [self.view addSubview:self.tableView];
    
    
    
    
    
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}




- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JBParallaxCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(!cell)
    {
        cell = [[JBParallaxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell setFrame:CGRectMake(0, 0, kiPadWidthPortrait, 270)];
    }
    
    NSInteger i = indexPath.row +1;
    cell.titleLabel.text = [@"Top in Engineering" uppercaseString];
    cell.subtitleLabel.text = [[NSString stringWithFormat:@"%i. University of Waterloo",i] uppercaseString];
    cell.parallaxImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"featured%i", i]];
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}











- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSArray *visibleCells = [self.tableView visibleCells];
    
    for (JBParallaxCell *cell in visibleCells) {
        [cell cellOnTableView:self.tableView didScrollOnView:self.view];
    }
    
    
}























@end
