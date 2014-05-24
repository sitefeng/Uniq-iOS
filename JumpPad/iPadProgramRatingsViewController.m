//
//  iPadProgramRatingsViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramRatingsViewController.h"
#import "Program.h"
#import "JPGlobal.h"
#import "iPadProgramLabelView.h"
#import "SFGaugeView.h"
#import "VolumeBar.h"

#import "JPFont.h"
#import "JPStyle.h"


@interface iPadProgramRatingsViewController ()

@end

@implementation iPadProgramRatingsViewController

- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"ratings"];
//        self.view.backgroundColor = [JPStyle colorWithHex:@"FFE6EF" alpha:1];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
    
        self.program = program;
        self.dashletUid = dashletUid;
        
        
        self.programLabel = [[iPadProgramLabelView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, kiPadWidthPortrait, 44) dashletNum:self.dashletUid program:self.program];
        
        [self.view addSubview:self.programLabel];

        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.ratingScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight+self.programLabel.frame.size.height, kiPadWidthPortrait, kiPadHeightPortrait-(kiPadStatusBarHeight+kiPadNavigationBarHeight+self.programLabel.frame.size.height+kiPadTabBarHeight))];
    
    self.ratingScrollView.contentSize = CGSizeMake(kiPadWidthPortrait, 1300);
    
    
    UILabel* overallLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 250, 50)];
    overallLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:30];
    overallLabel.textColor = [UIColor whiteColor];
    overallLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    overallLabel.textAlignment = NSTextAlignmentCenter;
    overallLabel.layer.cornerRadius = 10;
    overallLabel.clipsToBounds = YES;
    overallLabel.text = @"Overall Impression";
    
    
    self.overallSelector = [[SFGaugeView alloc] initWithFrame:CGRectMake(280, 10, 500, 300)];
    self.overallSelector.maxlevel = 100;
    self.overallSelector.needleColor = [JPStyle colorWithName:@"green"];
    self.overallSelector.minImage = @"thumbsDown";
    self.overallSelector.maxImage = @"thumbsUp";
    self.overallSelector.userInteractionEnabled = YES;
    self.overallSelector.exclusiveTouch =  YES;
//    self.overallSelector.bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"greyBackground"]];
    
    self.overallSelector.bgColor = [JPStyle colorWithName:@"blue"];
    self.overallSelector.backgroundColor = self.view.backgroundColor;
    
    [self.ratingScrollView addSubview:overallLabel];
    [self.ratingScrollView addSubview:self.overallSelector];
    
    
    
    for(int j=0; j<3; j++)//3 rows
    {
        for(int i = 0; i<2; i++) //2Columns
        {
    
            UILabel* categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(50 + i*334, 350 + j*250, 384, 50)];
            categoryLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:30];
            categoryLabel.textColor = [UIColor whiteColor];
            categoryLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
            categoryLabel.textAlignment = NSTextAlignmentCenter;
            categoryLabel.layer.cornerRadius = 10;
            categoryLabel.clipsToBounds = YES;
            categoryLabel.text = [JPGlobal ratingStringWithIndex: j*2 + i];
            [categoryLabel sizeToFit];
            
            CGRect tempFrame = categoryLabel.frame;
            categoryLabel.frame = CGRectMake(tempFrame.origin.x, tempFrame.origin.y, tempFrame.size.width + 30, tempFrame.size.height + 10);
            
            [self.ratingScrollView addSubview:categoryLabel];
            
            VolumeBar* categorySelector = [[VolumeBar alloc] initWithFrame:CGRectMake(tempFrame.origin.x + 90, tempFrame.origin.y + 70, 200, 200) minimumVolume:0 maximumVolume:100];
            
            categorySelector.currentVolume = 50;
            
            [categorySelector addTarget:self action:@selector(categorySelectorTouched:event:) forControlEvents:UIControlEventValueChanged];
            [categorySelector addTarget:self action:@selector(categorySelectorEnded) forControlEvents:UIControlEventTouchCancel];
            
            [self.categorySelectors addObject:categorySelector];
            [self.ratingScrollView addSubview:categorySelector];
            
            
            
        }

        
    }
    
    
    
    UIButton* saveButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 1100, 270, 50)];
    [saveButton setBackgroundImage:[UIImage imageWithColor:[JPStyle colorWithName:@"green"]] forState:UIControlStateNormal];
    
    saveButton.layer.cornerRadius = 10;
    saveButton.clipsToBounds = YES;
    
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
    [saveButton setTintColor:[UIColor whiteColor]];
    [saveButton setShowsTouchWhenHighlighted:NO];
    [saveButton addTarget:self action:@selector(saveButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ratingScrollView addSubview:saveButton];
    
    
    
    
    [self.view addSubview:self.ratingScrollView];
    
}


- (void)setProgram:(Program *)program
{
    _program = program;
    
    
    
    
    
    
}




- (NSMutableArray*)categorySelectors
{
    
    if(!_categorySelectors)
    {
        _categorySelectors = [NSMutableArray array];
    }
   
    return _categorySelectors;
}







- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    
}



- (void)categorySelectorTouched:(VolumeBar*)control event:(UIControlEvents)event
{
    
    [self.ratingScrollView setScrollEnabled:NO];
    _saveLabel.text = @"";
    

}

- (void)categorySelectorEnded
{
    [self.ratingScrollView setScrollEnabled:YES];
}



- (void)saveButtonPressed
{
    
    if(!_saveLabel)
    {
        _saveLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _saveLabel.frame = CGRectMake(284,1076,200,22);
        _saveLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        _saveLabel.textColor = [JPStyle colorWithName:@"darkRed"];
        _saveLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:18];
        _saveLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.ratingScrollView addSubview:_saveLabel];
    }
    _saveLabel.text = @"Ratings Saved";
    
    
    NSLog(@"Overall: %i", [self.overallSelector currentLevel]);
    
    
    
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
