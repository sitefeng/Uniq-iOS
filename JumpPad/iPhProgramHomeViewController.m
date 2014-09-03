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
    
    
    _detailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 25, kiPhoneWidthPortrait, 620)];
    _detailScrollView.showsHorizontalScrollIndicator = NO;
    _detailScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_detailScrollView];

    JPLocation* programLocation = [[JPLocation alloc] initWithSchoolLocation:self.program.faculty.school.location];
    JPProgramSummaryView* summaryView = [[JPProgramSummaryView alloc] initWithFrame:CGRectMake(-10, 0, kiPhoneWidthPortrait, 308) program:self.program location:programLocation isPhoneInterface:YES];
    summaryView.delegate = self;
    [_detailScrollView addSubview:summaryView];

    
    CGFloat currYPosition = CGRectGetMaxY(summaryView.frame) + 5;
    
    iPhProgramDetailView* aboutView = [[iPhProgramDetailView alloc] initWithFrame:CGRectMake(5, currYPosition, kiPhoneWidthPortrait - 10, 200) title:@"About" program:self.program];
    [_detailScrollView addSubview:aboutView];
    currYPosition += aboutView.frame.size.height + 5;
    
    iPhProgramDetailView* tuitionView = [[iPhProgramDetailView alloc] initWithFrame:CGRectMake(5, currYPosition, kiPhoneWidthPortrait - 10, 200) title:@"Tuition" program:self.program];
    [_detailScrollView addSubview:tuitionView];
    currYPosition += tuitionView.frame.size.height + 5;
    
    _highlighView = [[iPhProgramDetailView alloc] initWithFrame:CGRectMake(5, currYPosition, kiPhoneWidthPortrait - 10, 250) title:@"Highlight" program:self.program];
    [_detailScrollView addSubview:_highlighView];
    currYPosition += _highlighView.frame.size.height + 5;
    
    
    iPhProgramDetailView* ratingsView = [[iPhProgramDetailView alloc] initWithFrame:CGRectMake(5, currYPosition, kiPhoneWidthPortrait - 10, 250) title:@"Ratings" program:self.program];
    [_detailScrollView addSubview:ratingsView];
    currYPosition += ratingsView.frame.size.height + 5;
    
    
    _ratioView = [[iPhProgramDetailView alloc] initWithFrame:CGRectMake(5, currYPosition, kiPhoneWidthPortrait - 10, 200) title:@"Gals vs Guys Ratio" program:self.program];
    [_detailScrollView addSubview:_ratioView];
    currYPosition += _ratioView.frame.size.height + 5;
    
    [_detailScrollView setContentSize:CGSizeMake(_detailScrollView.frame.size.width, currYPosition + 130)];
    
    [self.view bringSubviewToFront:_panImageView];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_highlighView reloadData];
    [_ratioView reloadData];
}



- (void)facebookButtonTapped
{
    Contact* contact = [self.program.contacts anyObject];
    
    NSURL* url = [NSURL URLWithString:contact.facebook];
    [JPGlobal openURL:url];
}


- (void)emailButtonTapped
{
    if([MFMailComposeViewController canSendMail])
    {
        Contact* contact = [self.program.contacts anyObject];
    
        _mailController = [[MFMailComposeViewController alloc] init];
        _mailController.mailComposeDelegate = self;
        NSString* recipient = contact.email;
        [_mailController setToRecipients:@[recipient]];
        
        [self presentViewController:_mailController animated:YES completion:nil];
    }
    else
    {
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"noEmailHUD"] status:@"No Account"];
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
