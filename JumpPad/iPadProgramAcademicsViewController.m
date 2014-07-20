//
//  iPadProgramAcademicsViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramAcademicsViewController.h"
#import "iPadProgramLabelView.h"
#import "NSString+JPDateStringParser.h"

#import "JPFont.h"
#import "JPStyle.h"

#import "JPDateView.h"

#import "Program.h"
#import "ProgramCourse.h"
#import "NSString+JPDateStringParser.h"

#import "iPadProgramHexCollectionView.h"
#import "iPadProgramHexView.h"

#import "iPadProgramRelatedView.h"
#import "JPProgramCoursesViewController.h"

#import "UserFavItem.h"

@interface iPadProgramAcademicsViewController ()

@end

@implementation iPadProgramAcademicsViewController

- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program
{
    self = [super initWithDashletUid: dashletUid program: program];
    if (self) {
        // Custom initialization
        UniqAppDelegate* del = [[UIApplication sharedApplication] delegate];
        context = [del managedObjectContext];
        
        self.tabBarItem.image = [UIImage imageNamed:@"academics"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
        
        self.program = program;
        self.dashletUid = dashletUid;
        
        self.labelView = [[iPadProgramLabelView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, kiPadWidthPortrait, 44) dashletNum:self.dashletUid program:self.program];
        [self.view addSubview:self.labelView];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _yPositionForScrollView = 0;
    
    UIScrollView* mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, kiPadWidthPortrait, kiPadHeightPortrait-44)];
    
    
    mainScrollView.backgroundColor = [UIColor clearColor];
    mainScrollView.contentSize = CGSizeMake(kiPadWidthPortrait, 1000);
    
    mainScrollView.clipsToBounds = YES;
    
    _dateView = [[JPDateView alloc] initWithFrame:CGRectMake(0, 0, 200, 140)];
    
    _dateView.month = [self.program.admissionDeadline monthIntegerValue];
    _dateView.date  = [self.program.admissionDeadline dateIntegerValue];
    
    [mainScrollView addSubview:_dateView];
    /////////////////////////////////////////
    
    
    //Calendar Label View
    _calendarBackground = [[UIView alloc] initWithFrame:CGRectMake(_dateView.frame.size.width, 0, kiPadWidthPortrait - _dateView.frame.size.width, _dateView.frame.size.height)];
    _calendarBackground.backgroundColor = [UIColor whiteColor];
    
    _calendarLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 14, 500, 40)];
    _calendarLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:25];
    _calendarLabel.textColor = [UIColor blackColor];
    _calendarLabel.textAlignment = NSTextAlignmentLeft;
    
    [_calendarBackground addSubview:_calendarLabel];
    
    //Processes
    NSArray* processNames = [NSArray arrayWithObjects: @"Favorited",@"Researched",@"Applied",@"Response",@"Got Offer", nil];
    
    _applicationButtons = [NSMutableArray array];
    for(int i= 0; i<5; i++)
    {
        UIButton* processButton = [[UIButton alloc] initWithFrame:CGRectMake(30 + i*_calendarBackground.frame.size.width/5, 65, 44, 44)];
        
        [processButton setImage:[UIImage imageNamed:@"itemIncomplete"] forState:UIControlStateNormal];
        [processButton setImage:[UIImage imageNamed:@"itemComplete"] forState:UIControlStateSelected];
        [processButton setImage:[UIImage imageNamed:@"itemOverdue"] forState:UIControlStateHighlighted];
        processButton.tag = i;
        [processButton addTarget:self action:@selector(calendarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_applicationButtons addObject:processButton];
        [_calendarBackground addSubview:processButton];
        
        UILabel* processLabel = [[UILabel alloc] initWithFrame:CGRectMake(processButton.frame.origin.x - 20, processButton.frame.origin.y + processButton.frame.size.height + 4, processButton.frame.size.width + 40, 20)];
        processLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:15];
        processLabel.textAlignment = NSTextAlignmentCenter;
        processLabel.text = [processNames objectAtIndex:i];
        [_calendarBackground addSubview:processLabel];
    }
    
    [mainScrollView addSubview:_calendarBackground];

    
    ///////////////////////////////////////////////////////////////////
    _yPositionForScrollView += _dateView.frame.size.height;//140
    /////////////////////////////////////
    
    _numHexViews = 2;

    iPadProgramHexCollectionView* hexCV = [[iPadProgramHexCollectionView alloc] initWithFrame:CGRectZero];
    
    if(_numHexViews%3 == 0)
    {
        hexCV.frame = CGRectMake(0, _yPositionForScrollView, kiPadWidthPortrait, kHexHeight/4*7 * (_numHexViews-1)/3 + kHexHeight/4);
    }
    else if(_numHexViews%3 == 1)
    {
        hexCV.frame = CGRectMake(0, _yPositionForScrollView, kiPadWidthPortrait, kHexHeight/4*7 * (_numHexViews-2)/3 + kHexHeight/4);
    }
    else
    {
        hexCV.frame = CGRectMake(0, _yPositionForScrollView, kiPadWidthPortrait, kHexHeight/4*7 * _numHexViews/3);
    }

    hexCV.dataSource = self;
    [mainScrollView addSubview:hexCV];
    _yPositionForScrollView += hexCV.frame.size.height - 133;
    
    //Related Controller
    self.relatedView = [[iPadProgramRelatedView alloc] initWithFrame:CGRectMake(0, _yPositionForScrollView, kiPadWidthPortrait, kHexHeight)];
    self.relatedView.dataSource = self;
    
    
    [mainScrollView addSubview:self.relatedView];
    _yPositionForScrollView += self.relatedView.frame.size.height;

    mainScrollView.contentSize = CGSizeMake(mainScrollView.contentSize.width, _yPositionForScrollView + 50);
    [self.view addSubview:mainScrollView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)setProgram:(Program *)program
{
    super.program = program;
    
    _dateView.month = [self.program.admissionDeadline monthIntegerValue];
    _dateView.date  = [self.program.admissionDeadline dateIntegerValue];
    
    
    [self reloadData];
}




- (void)reloadData
{
    NSInteger daysLeft = [self.program.admissionDeadline daysLeftFromToday];
    
    _calendarLabel.text = @"Application Progress: ";
    
    if(daysLeft < 90)
    {
        _calendarLabel.text = [_calendarLabel.text stringByAppendingString: [NSString stringWithFormat: @"%li days left to apply", (long)daysLeft]];
    }
    else if(daysLeft > 350)
    {
        _calendarLabel.text = [_calendarLabel.text stringByAppendingString: @"Application Period Ended"];
    }

}





#pragma mark - Program Hex Collection View DataSource

- (NSUInteger)numberOfCellsInHexCollectionView:(iPadProgramHexCollectionView *)cv
{
    return _numHexViews;
}


- (iPadProgramHexView*)hexCollectionView:(iPadProgramHexCollectionView *)cv hexViewForCellAtPosition:(NSUInteger)position
{
    CGFloat contentStartYPosition = kHexHeight/4 + 5;
    
    iPadProgramHexView* hexView = [[iPadProgramHexView alloc] initWithFrame:CGRectMake(0, 0, kHexWidth, kHexWidth)];
    
    switch (position) {
        case 0:{
            hexView.titleLabel.text = @"Courses";
            NSArray* titles = @[@"1st Year", @"2nd Year", @"3rd Year", @"4th Year"];
            
            for(int i=0; i<2; i++)
            {
                for(int j=0; j<2; j++)
                {
                    UIButton* yearButton = [[UIButton alloc] initWithFrame:CGRectMake(28 + 156*(j%2), contentStartYPosition + 10 + 105*(i%2), 150, 90)];
                    [yearButton setBackgroundImage:[UIImage imageWithColor:[JPStyle colorWithName:@"tBlack"]] forState:UIControlStateNormal];
                    [yearButton setBackgroundImage:[UIImage imageWithColor:[UIColor blackColor]] forState:UIControlStateHighlighted];
                    
                    yearButton.layer.cornerRadius = 10;
                    yearButton.clipsToBounds = YES;
                    
                    [yearButton setTitle:titles[j+i*2] forState:UIControlStateNormal];
                    
                    yearButton.titleLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
                    [yearButton setTintColor:[UIColor whiteColor]];
                    [yearButton setShowsTouchWhenHighlighted:NO];
                    yearButton.tag = j+2*i;
                    [yearButton addTarget:self action:@selector(yearButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [hexView addSubview:yearButton];
                }
                
            }
            
            
            break;
        }
        case 1:
        {
            hexView.titleLabel.text = @"+";
            hexView.titleLabel.font = [UIFont fontWithName:[JPFont defaultBoldFont] size:40];
            
            UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(20, contentStartYPosition + 30, kHexWidth - 40, 170)];
            
            [button setTintColor:[UIColor whiteColor]];
            button.titleLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:36];
            [button setTitle:@"More Info Soon!" forState:UIControlStateNormal];
            
            [hexView addSubview:button];
            
            break;
        }
        case 2:
            hexView.titleLabel.text = @"+";
            hexView.titleLabel.font = [UIFont fontWithName:[JPFont defaultBoldFont] size:40];
            break;
        default:
            hexView.titleLabel.text = @"Unknown";
            break;
    }
    
    return hexView;
    
}


- (void)yearButtonPressed: (UIButton*)button
{
    
    NSUInteger year = button.tag + 1;
    
    JPProgramCoursesViewController* viewController = [[JPProgramCoursesViewController alloc] init];
    
    viewController.coursesYear = year;
    viewController.programCourses = self.program.courses;
    
    
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    
    [self presentViewController:navController animated:YES completion:nil];
    
}







#pragma mark - Program Related View Data Source

- (NSUInteger)numberOfCellsForRelatedView:(iPadProgramRelatedView *)relatedView
{
    
    return 6;
    
}


- (NSString*)relatedView:(iPadProgramRelatedView *)relatedView cellTitleForCellAtPosition:(NSUInteger)position
{
    
    
    return @"Mechanical Engineering";
}


- (NSString*)relatedView:(iPadProgramRelatedView *)relatedView cellSubtitleForCellAtPosition:(NSUInteger)position
{
    
    return @"Ryerson University";
}


- (NSString*)relatedView:(iPadProgramRelatedView *)relatedView cellBackgroundImageURLStringForCellAtPosition:(NSUInteger)position
{
    if(position==1)
        return @"http://sitefeng.com/images/Jump/ryerson1.png";
    
    else
        return @"http://sitefeng.com/images/Jump/ryerson2.png";
    
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
