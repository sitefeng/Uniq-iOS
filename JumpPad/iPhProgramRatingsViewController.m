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
#import "JPProgramRatingHelper.h"
#import "JPStyle.h"
#import "JPFont.h"
#import "DejalActivityView.h"
#import "SVStatusHUD.h"
#import "JPRatings.h"


@interface iPhProgramRatingsViewController ()

@end

@implementation iPhProgramRatingsViewController

- (instancetype)initWithProgram: (Program*)program
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
       
        self.program = program;
        
        _ratingsHelper = [[JPProgramRatingHelper alloc] init];
        _ratingsHelper.delegate = self;
        
        _cellTitles = @[@"Overall Rating", @"Difficulty", @"Professor Quality", @"Schedule Packedness", @"Classmates", @"Social Enjoyment", @"Study Environment", @"Guy To Girl Ratio"];
        
        //TODO: get real value from Firebase
        _cellValues = [@[@50,@50,@50,@50,@50,@50,@50,@50] mutableCopy];
        
        _offlineMode = NO;
        
        
        [_ratingsHelper downloadRatingsWithProgramUid:[NSString stringWithFormat:@"%@",self.program.programId]];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight + kiPhoneNavigationBarHeight, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[iPhProgramRatingsTableCell class] forCellReuseIdentifier:@"ratingsCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"regularCell"];
    [self.view addSubview:self.tableView];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(_offlineMode)
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"downloadFailedHUD"] status:@"Currently Offline"];
}


#pragma mark - Table View Delegate

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
    iPhProgramRatingsTableCell* cell;
    
    if(indexPath.section == 0)
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"ratingsCell"];
    else
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"regularCell"];
    
    if(indexPath.section==1)
    {
        if(_prevRatingExists)
            cell.textLabel.text = @"Update Submission";
        else
            cell.textLabel.text = @"Submit";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [JPStyle colorWithName:@"green"];
    }
    else //Ratings cells
    {
        cell.delegate = self;
        
        cell.titleLabel.text = [_cellTitles objectAtIndex:indexPath.row];
        cell.percentage = [[_cellValues objectAtIndex:indexPath.row] doubleValue];
    
        if(indexPath.row == [_cellTitles indexOfObject:@"Guy To Girl Ratio"])
        {
            cell.invertLabelsForRatio = YES;
            cell.showsLeftLabel = YES;
        }
        
    }
    
    return cell;
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return @"Rate The Program";
    else
        return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
        return kCellHeight;
    else
        return 40;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0)
        return;
    
    JPRatings* ratings = [[JPRatings alloc] initWithOrderedArray:[_cellValues copy]];
    
    NSString* programId = [NSString stringWithFormat:@"%@", self.program.programId];
    [_ratingsHelper uploadRatingsWithProgramUid:programId ratings:ratings];
    
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return NO;
    else
        return YES;
}


#pragma mark - Program Ratings Cell Delegate

- (void)programRatingsCell:(iPhProgramRatingsTableCell *)cell sliderValueDidChangeToValue:(CGFloat)value
{
    //Do not respond when reloading cell
    if([self.tableView isDragging] || [self.tableView isDecelerating])
    {
        return;
    }
    
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    [_cellValues replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithDouble:value]];
    
}


#pragma mark - Program Ratings Helper Delegate

- (void)ratingHelper:(JPProgramRatingHelper *)helper didUploadRatingsForProgramUid:(NSString *)uid error:(NSError *)error
{
    _prevRatingExists = YES;
    
    NSIndexPath* submitCellPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[submitCellPath] withRowAnimation:UITableViewRowAnimationFade];
    
}


- (void)ratingHelper:(JPProgramRatingHelper *)helper didDownloadRatingsForProgramUid:(NSString *)uid ratings:(JPRatings *)ratings ratingExists:(BOOL)exists networkError:(NSError *)error
{
    if(error)
    {
        _offlineMode = YES;
        return;
    }
    
    _offlineMode = NO;
    _prevRatingExists = exists;
    if(!exists || !ratings) {
        return;
    }
    
    NSArray* cellRatingsArray = [ratings getOrderedArray];
    if(cellRatingsArray)
        _cellValues = [cellRatingsArray mutableCopy];
    
    [self.tableView reloadData];
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
