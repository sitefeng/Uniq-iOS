//
//  iPhProgramHomeViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhProgramHomeViewController.h"
#import "JPGlobal.h"
#import "Program.h"
#import "Faculty.h"
#import "School.h"
#import "SchoolLocation.h"
#import "JPLocation.h"
#import "iPhImagePanView.h"
#import "JPProgramSummaryView.h"
#import "iPhProgramDetailView.h"
#import "SVStatusHUD.h"


@interface iPhProgramHomeViewController ()

@end

@implementation iPhProgramHomeViewController

- (instancetype)initWithProgram: (Program*)program
{
    self = [super initWithProgram: program];
    if (self)
    {
        self.program = program;
        
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
    
    _panImageView = [[iPhImagePanView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight - 240, kiPhoneWidthPortrait, 270)];
   
    _panImageView.program = self.program;
    
    UIPanGestureRecognizer* panRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewPanned:)];
    [_panImageView addGestureRecognizer:panRec];
    [self.view addSubview:_panImageView];

    _detailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait)];
    _detailScrollView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    _detailScrollView.showsHorizontalScrollIndicator = NO;
    _detailScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_detailScrollView];


    JPProgramSummaryView* summaryView = [[JPProgramSummaryView alloc] initWithFrame:CGRectMake(-10, 0, kiPhoneWidthPortrait, 308) program:self.program isPhoneInterface:YES];
    summaryView.delegate = self;
    [_detailScrollView addSubview:summaryView];

    _dashletTitles = @[@"About",@"Tuition",@"Highlight",@"Ratings",@"Gals vs Guys Ratio"];
    
    self.dashletTableView = [[iPhProgramDetailTableView alloc] initWithFrame:CGRectMake(0, 310, kiPhoneWidthPortrait, 500) program:self.program];
    self.dashletTableView.scrollable = NO;
    self.dashletTableView.dataSource = self;
    [_detailScrollView addSubview:self.dashletTableView];
    
    
    [self.view bringSubviewToFront:_panImageView];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_highlighView reloadData];
    [_ratioView reloadData];
}



#pragma mark - Program Detail Table View Data Source

- (NSInteger)numberOfDashletsInProgramDetailTable:(iPhProgramDetailTableView *)tableView
{
    
    return [_dashletTitles count];
}


- (NSString*)programDetailTable:(iPhProgramDetailTableView *)tableView dashletTitleForRow:(NSInteger)row
{
    return _dashletTitles[row];
}


- (void)programDetailTable:(iPhProgramDetailTableView *)tableView didFindMaximumHeight:(CGFloat)height
{
    [_detailScrollView setContentSize:CGSizeMake(_detailScrollView.frame.size.width, 310+height)];
}


#pragma mark - Summary Button Callback Methods

- (void)facebookButtonTapped
{
    Contact* contact = [self.program.contacts anyObject];
    
    NSURL* url = [NSURL URLWithString:contact.facebook];
    [JPGlobal openURL:url];
}


- (void)emailButtonTapped {
    
    Contact* contact = [self.program.contacts anyObject];
    NSString* recipient = contact.email;
    
    if([MFMailComposeViewController canSendMail] && recipient) {
        _mailController = [[MFMailComposeViewController alloc] init];
        _mailController.mailComposeDelegate = self;

        [_mailController setToRecipients:@[recipient]];
        [self presentViewController:_mailController animated:YES completion:nil];
    }
    else {
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"noEmailHUD"] status:@"Unavailable"];
    }
}


- (void)websiteButtonTapped
{
    Contact* contact = [self.program.contacts anyObject];
    NSURL* url = [NSURL URLWithString:contact.website];
    [JPGlobal openURL:url];
}


- (void)phoneButtonTapped
{
    Contact* contact = [self.program.contacts anyObject];
    
    NSString* phoneNumberString = [NSString stringWithFormat:@"%@", contact.phone];
    
    if([JPStyle isPhone])
    {
        NSString* phoneURLStr = [NSString stringWithFormat:@"tel:%@", phoneNumberString];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneURLStr]];
    }
    else
    {
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"copyHUD"] status:@"Phone Copied"];
        UIPasteboard* board = [UIPasteboard generalPasteboard];
        [board setString: phoneNumberString];
    }
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)setProgram:(Program *)program
{
    super.program = program;
    
    _panImageView.program = program;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
