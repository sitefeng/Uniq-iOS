//
//  JumpPadMainSearchViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-04-29.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadMainSearchViewController.h"

#import "JPFont.h"
#import "JPStyle.h"

#import "iPadSearchResultsView.h"

@interface iPadMainSearchViewController ()

@end

@implementation iPadMainSearchViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        
        
        
        
        
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(230, kiPadStatusBarHeight+ 100, 450, 50)];
    self.searchBar.placeholder = @"Ask a Question";
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.translucent = YES;
    
    self.searchBar.text = @"mechatronics tuition";
    
    for (UIView *subView in self.searchBar.subviews)
    {
        for (UIView *secondLevelSubview in subView.subviews){
            if ([secondLevelSubview isKindOfClass:[UITextField class]])
            {
                UITextField *searchBarTextField = (UITextField *)secondLevelSubview;
                //set font color here
                searchBarTextField.textColor = [UIColor whiteColor];
                break;
            }
        }
    }
    
    self.searchBar.delegate = self;
    
    [self.view addSubview: self.searchBar];
    
    
    UIImageView* searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.searchBar.frame.origin.x - 100, self.searchBar.frame.origin.y - 45, 75, 75)];
    searchImageView.image = [UIImage imageNamed:@"searchIcon"];
    searchImageView.layer.cornerRadius = 20;
    searchImageView.clipsToBounds = YES;
    [self.view addSubview:searchImageView];
    
    
    UILabel* mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.searchBar.frame.origin.x + 6, self.searchBar.frame.origin.y - 60, self.searchBar.frame.size.width + 30, 55)];
//    UIFont* labelFont = [UIFont fontWithName:[JPFont defaultMediumFont] size:40];
    UIFont* labelFont = [UIFont fontWithName:@"Optima-Regular" size:40];
    mainLabel.textAlignment = NSTextAlignmentLeft;
    
    NSMutableAttributedString* labelString = [[NSMutableAttributedString alloc] initWithString:@"Uniq Knowledge Engine" attributes:@{NSFontAttributeName:labelFont}];
    
    [labelString addAttribute:NSForegroundColorAttributeName value:[JPStyle colorWithName:@"blue"] range:NSMakeRange(0, 4)];
    [labelString addAttribute:NSForegroundColorAttributeName value:[JPStyle colorWithName:@"green"] range:NSMakeRange(5, 16)];
    
    mainLabel.attributedText = labelString;
    
    [self.view addSubview:mainLabel];
    
    
//    UIButton* compareButton = [[UIButton alloc] initWithFrame:CGRectMake(self.searchBar.frame.origin.x + 4, self.searchBar.frame.origin.y - 60, self.searchBar.frame.size.width + 30, 55)];
//    [compareButton setBackgroundImage:[UIImage imageWithColor:[JPStyle colorWithName:@"green"]] forState:UIControlStateNormal];
//    
//    compareButton.layer.cornerRadius = 10;
//    compareButton.clipsToBounds = YES;
//    
//    [compareButton setTitle:@"Ask Question" forState:UIControlStateNormal];
//    compareButton.titleLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
//    [compareButton setTintColor:[UIColor whiteColor]];
//    [compareButton setShowsTouchWhenHighlighted:NO];
//    [compareButton addTarget:self action:@selector(askButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    
    
    
    
    self.resultView = [[iPadSearchResultsView alloc] initWithFrame:CGRectMake(0, 180, kiPadWidthPortrait, kiPadHeightPortrait-kiPadTabBarHeight- 180)];
    
    [self.view addSubview:self.resultView];
    
    
    
    
    
}





- (void)askButtonPressed
{
    [self searchBarSearchButtonClicked:self.searchBar];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    _queryString = searchBar.text;
    
    self.resultView.queryString = _queryString;
    
    
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
