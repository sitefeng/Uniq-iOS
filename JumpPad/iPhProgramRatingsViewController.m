//
//  iPhProgramRatingsViewController.m
//  Uniq
//
//  Created by Si Te Feng on 8/14/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhProgramRatingsViewController.h"
#import "Program.h"
#import "iPhProgramRatingsTableCell.h"


@interface iPhProgramRatingsViewController ()

@end

@implementation iPhProgramRatingsViewController

- (instancetype)initWithProgram: (Program*)program
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
       
        self.program = program;
        
        _cellTitles = @[@"Overall Rating", @"Difficulty", @"Professor Quality", @"Schedule Packedness", @"Classmates", @"Social Enjoyment", @"Study Environment", @"Guy to Girl Ratio"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[iPhProgramRatingsTableCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self.view addSubview:self.tableView];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return [_cellTitles count];
    else
        return 1;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    iPhProgramRatingsTableCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    if(indexPath.section==0)
    {
        cell.textLabel.text = @"Submit";
    }
    
    cell.titleLabel.text = [_cellTitles objectAtIndex:indexPath.row];
    
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
        return kCellHeight;
    else
        return 40;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
