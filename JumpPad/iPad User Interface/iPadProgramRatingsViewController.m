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
#import "SFGaugeView.h"
#import "VolumeBar.h"

#import "JPFont.h"
#import "JPStyle.h"
#import "JPProgramRatingHelper.h"
#import "TLTiltSlider.h"
#import "JPGlobal.h"
#import "JPRatings.h"
#import "SVStatusHUD.h"

@interface iPadProgramRatingsViewController ()

@end

@implementation iPadProgramRatingsViewController

- (id)initWithProgram: (Program*)program
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"ratings"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
        
        _ratingsHelper = [[JPProgramRatingHelper alloc] init];
        _ratingsHelper.delegate = self;
    
        self.program = program;
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.ratingScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, kiPadWidthPortrait, kiPadHeightPortrait-(kiPadStatusBarHeight+kiPadNavigationBarHeight+kiPadTabBarHeight))];
    
    
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
            categoryLabel.text = [JPGlobal ratingFullStringWithIndex: j*2 + i];
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
    
    UILabel* ratioLabel = [[UILabel alloc] initWithFrame:CGRectMake(260, 1110, kiPadWidthPortrait-520, 40)];
    ratioLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:30];
    ratioLabel.textColor = [UIColor whiteColor];
    ratioLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    ratioLabel.textAlignment = NSTextAlignmentCenter;
    ratioLabel.layer.cornerRadius = 10;
    ratioLabel.clipsToBounds = YES;
    ratioLabel.text = @"Guy To Girl Ratio";
    [ratioLabel sizeToFit];
    CGRect tempFrame = ratioLabel.frame;
    ratioLabel.frame = CGRectMake(tempFrame.origin.x, tempFrame.origin.y, tempFrame.size.width + 30, tempFrame.size.height + 10);
    [self.ratingScrollView addSubview:ratioLabel];
    
    
    self.tiltSlider = [[TLTiltSlider alloc] initWithFrame:CGRectMake(100, 1170, kiPadWidthPortrait-200, 30)];
    self.tiltSlider.tiltEnabled = YES;
    self.tiltSlider.value = 0.5;
    [self.tiltSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.ratingScrollView addSubview:self.tiltSlider];
    
    _guyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 1170, 80, 33)];
    _guyLabel.text = @"50";
    _guyLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:30];
    _guyLabel.textColor = [UIColor whiteColor];
    _guyLabel.textAlignment = NSTextAlignmentCenter;
    [self.ratingScrollView addSubview:_guyLabel];
    
    
    _girlLabel = [[UILabel alloc] initWithFrame:CGRectMake(kiPadWidthPortrait-90, 1170, 80, 33)];
    
    _girlLabel.text = @"50";
    _girlLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:30];
    _girlLabel.textColor = [UIColor whiteColor];
    _girlLabel.textAlignment = NSTextAlignmentCenter;
    [self.ratingScrollView addSubview:_girlLabel];
    
    
    
    //Save Button
    submitButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 1240, 270, 50)];
    [submitButton setBackgroundImage:[UIImage imageWithColor:[JPStyle colorWithName:@"green"]] forState:UIControlStateNormal];
    
    submitButton.layer.cornerRadius = 10;
    submitButton.clipsToBounds = YES;
    
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
    [submitButton addTarget:self action:@selector(saveButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ratingScrollView addSubview:submitButton];
    
    
    self.ratingScrollView.contentSize = CGSizeMake(kiPadWidthPortrait, 1300);
    [self.view addSubview:self.ratingScrollView];
    
    
    
    /////////////////////
    [_ratingsHelper downloadRatingsWithProgramUid:self.program.programId getAverageValue:NO completionHandler:^(BOOL success, JPRatings *ratings) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(!success) {
                [SVStatusHUD showWithImage:[UIImage imageNamed:@"downloadFailedHUD"] status:@"Currently Offline"];
                return;
            }
            
            [submitButton setTitle:@"Update Submission" forState:UIControlStateNormal];
            
            NSArray* orderedArray = [ratings getOrderedArray];
            
            float maxVal = 1.0502156;
            float minVal = -1.0482738;
            float overallValue = [[orderedArray objectAtIndex:0] floatValue];
            
            self.overallSelector.currentRadian = (overallValue/100.0)*(maxVal-minVal) + minVal;
            
            for(int i=1; i<=6; i++)
            {
                NSInteger value = [[orderedArray objectAtIndex:i] integerValue];
                VolumeBar* volume = [self.categorySelectors objectAtIndex:i-1];
                volume.currentVolume = value;
            }
            
            NSInteger ratioValue = ratings.guyRatio;
            self.tiltSlider.value = ratioValue/100.0;
            _guyLabel.text = [NSString stringWithFormat:@"%ld", (long)ratioValue];
            _girlLabel.text = [NSString stringWithFormat:@"%ld", 100-ratioValue];
        });
    }];
}


- (void)sliderChanged: (TLTiltSlider*)slider
{
    CGFloat percentage = slider.value * 100;
    
    _guyLabel.text = [NSString stringWithFormat:@"%.00f", percentage];
    _girlLabel.text = [NSString stringWithFormat:@"%.00f", 100-percentage];
    
    
}


- (void)saveButtonPressed
{
    NSInteger ratingOverall = self.overallSelector.currentLevel;
    NSMutableArray* orderedArray = [NSMutableArray arrayWithObject:[NSNumber numberWithInteger:ratingOverall]];
    
    NSArray* categorySelectors = [self categorySelectors];
    
    for(VolumeBar* volumeBar in categorySelectors)
    {
        NSInteger value = volumeBar.currentVolume;
        [orderedArray addObject:[NSNumber numberWithInteger:value]];
    }
    
    [orderedArray addObject:[NSNumber numberWithInteger:self.tiltSlider.value*100]];
    
    JPRatings* ratings = [[JPRatings alloc] initWithOrderedArray:orderedArray];
    
    NSString* programUid = [NSString stringWithFormat:@"%@", self.program.programId];
    [_ratingsHelper uploadRatingsWithProgramUid:programUid ratings:ratings];
    
}





#pragma mark - Program Rating Helper Delegate

- (void)ratingHelper:(JPProgramRatingHelper *)helper didUploadRatingsForProgramUid:(NSString *)uid error:(NSError *)error
{
    if(error)
    {
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"uploadFailedHUD"] status:@"Currently Offline"];
        return;
    }
    
    [submitButton setTitle:@"Update Submission" forState:UIControlStateNormal];
}


#pragma mark - Setters and Getters

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






#pragma mark - Stabilize Scroll View

- (void)categorySelectorTouched:(VolumeBar*)control event:(UIControlEvents)event
{
    [self.ratingScrollView setScrollEnabled:NO];
    

}


- (void)categorySelectorEnded
{
    [self.ratingScrollView setScrollEnabled:YES];
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
