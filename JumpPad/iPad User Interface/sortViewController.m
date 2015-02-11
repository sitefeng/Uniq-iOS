//
//  sortViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 2/23/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "sortViewController.h"

@interface sortViewController ()


@end

@implementation sortViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _sortOptions = @[@"Alphabetical",@"Closest",@"Highest Entry Avg",@"Largest College"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"sortTableViewCell"];
    
}

#pragma mark - TableView Delegate and Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}



- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"sortTableViewCell" forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sortTableViewCell"];
    }
   
    cell.textLabel.text = _sortOptions[indexPath.row];
    
    if(self.sortType==indexPath.row)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    [self.tableView reloadData];
    
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
