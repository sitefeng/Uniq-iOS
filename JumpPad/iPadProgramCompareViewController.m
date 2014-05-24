//
//  iPadProgramCompareViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramCompareViewController.h"
#import "Program.h"
#import "Faculty.h"
#import "School.h"
#import "iPadMainCollectionViewCell.h"

#import "JPDashlet.h"
#import "JPFont.h"
#import "DXAlertView.h"


@interface iPadProgramCompareViewController ()

@end

@implementation iPadProgramCompareViewController

- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program
{
    self = [super init];
    
    if(self)
    {
        // Custom initialization
        
        self.tabBarItem.image = [UIImage imageNamed:@"compare"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
        
        self.program = program;
        self.dashletUid = dashletUid;
        
        
        NSLog(@"self.program: %@[%@]", self.program, self.program.name);
        NSLog(@"prog Uid: %i", self.dashletUid);
        
    }
        
    
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self reloadDashlets];
    
    [self reloadLabels];
    
    
    UIButton* compareButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 425, 270, 50)];
    [compareButton setBackgroundImage:[UIImage imageWithColor:[JPStyle colorWithName:@"green"]] forState:UIControlStateNormal];
    
    compareButton.layer.cornerRadius = 10;
    compareButton.clipsToBounds = YES;
    
    [compareButton setTitle:@"Compare" forState:UIControlStateNormal];
    compareButton.titleLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
    [compareButton setTintColor:[UIColor whiteColor]];
    [compareButton setShowsTouchWhenHighlighted:NO];
    [compareButton addTarget:self action:@selector(compareButtonPressed:event:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [compareButton setEnabled:YES];
    
    
    //Blue Middle Line
    UIView*  blueLine = [[UIView alloc] initWithFrame:CGRectMake(0, 450, kiPadWidthPortrait, 6)];
    blueLine.backgroundColor = [JPStyle colorWithName:@"blue"];
    [self.view addSubview:blueLine];
    
    for(int i = 0; i<2; i++)
    {
        UILabel* progIcon = [[UILabel alloc] initWithFrame:CGRectMake(150 + 450*i, -18, 40, 40)];
        progIcon.backgroundColor = [JPStyle colorWithName:@"blue"];
        progIcon.layer.cornerRadius = progIcon.frame.size.width/2;
        progIcon.clipsToBounds = YES;
        
        progIcon.textAlignment = NSTextAlignmentCenter;
        progIcon.textColor = [UIColor whiteColor];
        progIcon.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
        
        if(i == 0)
        {
            progIcon.text = @"M";
        }
        else
        {
            progIcon.text = @"?";
        }
        
        [blueLine addSubview:progIcon];
    }
    
    
    
    _squareView2 = [[iPadMainCollectionViewCell alloc] initWithFrame:CGRectMake(_squareView1.frame.origin.x, 550, kiPadDashletSizePortrait.width, kiPadDashletSizePortrait.height)];
    JPDashlet* dashletInfo2 = [[JPDashlet alloc] initWithDashletUid:0];
    _squareView2.dashletInfo = dashletInfo2;
    
    
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(350, 570, 300, 50)];
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.tintColor = [UIColor whiteColor];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"Program Name";
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeWords;
    

    _searchBar.showsSearchResultsButton = YES;
    [self.view addSubview: _searchBar];
    
    
    UILabel* promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(_searchBar.frame.origin.x + 15, _searchBar.frame.origin.y-15, 300, 20)];
    promptLabel.textColor = [UIColor whiteColor];
    promptLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:14];
    promptLabel.text = @"Search for Programs to Compare";
    
    [self.view addSubview:promptLabel];
    
    
    UIButton* searchButton = [[UIButton alloc] initWithFrame:CGRectMake(_searchBar.frame.origin.x + _searchBar.frame.size.width, _searchBar.frame.origin.y + 3, 44, 44)];
    [searchButton setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: searchButton];
    
    
    
    
    [self.view addSubview:_squareView1];
    [self.view addSubview:_squareView2];

    [self.view addSubview:compareButton];
    
}


- (void)setProgram:(Program *)program
{
    if(_program == program)
    {
        return;
    }
    
    _program = program;
        
    [self reloadDashlets];
    [self reloadLabels];
    
}

- (void)reloadDashlets
{
    //Dashlet 1
    NSUInteger facultyDashletId = self.dashletUid - [self.program.programId integerValue];
    JPDashlet* dashletInfo1 = [[JPDashlet alloc] initWithProgram:self.program fromFaculty:facultyDashletId];
    
    if(!_squareView1)
    {
        _squareView1 = [[iPadMainCollectionViewCell alloc] initWithFrame:CGRectMake(100, 100, kiPadDashletSizePortrait.width, kiPadDashletSizePortrait.height)];
    }
    
    _squareView1.dashletInfo = dashletInfo1;
    
    //Dashlet 2
    
    
    
    
    
}

- (void)reloadLabels
{
    if(!_squareView1 || _squareView1==nil || ![_square1Label isKindOfClass:[UILabel class]])
    {
        _square1Label = [[UILabel alloc] initWithFrame:CGRectMake(100+kiPadDashletSizePortrait.width + 20, 170, 400, 90)];
        _square1Label.font = [UIFont fontWithName:[JPFont defaultLightFont] size:30];
        _square1Label.numberOfLines = 2;
        _square1Label.textColor = [UIColor whiteColor];
        [self.view addSubview:_square1Label];
    }
  
    _square1Label.text = [NSString stringWithFormat:@"%@\n%@", self.program.name, self.program.faculty.school.name];
    
    if(!_squareView2 || _squareView2==nil || ![_square2Label isKindOfClass:[UILabel class]])
    {
        _square2Label = [[UILabel alloc] initWithFrame:CGRectMake(100+kiPadDashletSizePortrait.width + 20, 630, 400, 90)];
        _square2Label.font = _square1Label.font;
        _square2Label.textColor = _square1Label.textColor;
        _square2Label.numberOfLines = 2;
        [self.view addSubview:_square2Label];
    }

    _square2Label.text = @"Program Name\nUniversity Name";
    
}



- (void)setDashletUid:(NSUInteger)dashletUid
{
    _dashletUid = dashletUid;
    
    
    
}







- (void)searchButtonPressed
{
    
}





- (void)compareButtonPressed: (UIButton*)button event:(UIControlEvents)event
{

    if(!self.compProgram|| !self.compProgram.programId ||!self.compProgram.faculty)
    {
        DXAlertView* alertView = [[DXAlertView alloc] initWithTitle:@"Cannot Compare" contentText:@"Please select a program first." leftButtonTitle:nil rightButtonTitle:@"Okay"];
        [alertView show];
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
