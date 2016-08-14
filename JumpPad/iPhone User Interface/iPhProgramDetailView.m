//
//  iPhProgramDetailView.m
//  Uniq
//
//  Created by Si Te Feng on 7/13/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhProgramDetailView.h"
#import "JPStyle.h"
#import "JPFont.h"
#import "Program.h"
#import "ProgramRating.h"
#import "RPRadarChart.h"
#import "ProgramYearlyTuition.h"


@implementation iPhProgramDetailView

- (instancetype)initWithFrame:(CGRect)frame title: (NSString*)title program: (Program*)program
{
    self = [super initWithFrame:frame];
    if (self) {

        self.program = program;
        self.title = title;
        _programRating = self.program.rating;
        
        
        if([title isEqual:@"About"])
        {
            UITextView* textView =[[UITextView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            textView.editable = NO;
            textView.selectable = NO;
            textView.backgroundColor = [UIColor clearColor];
            textView.font = [UIFont fontWithName:[JPFont defaultFont] size:15];
            textView.showsVerticalScrollIndicator = NO;
            
            textView.text = program.about;
            
            [self addSubview:textView];
            
            self.viewHeight = 170;
        }
        else if([title isEqual:@"Tuition"])
        {
            UILabel* localLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 200, 20)];
            localLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:15];
            localLabel.text = @"Domestic (per term)";
            localLabel.textColor = [UIColor blackColor];
            UILabel* intLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 85, 200, 20)];
            intLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:15];
            intLabel.text = @"International (per term)";
            intLabel.textColor = [UIColor blackColor];
            
            [self addSubview:localLabel];
            [self addSubview:intLabel];
            
            //Tuition Values
            UILabel* localLabelVal = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 190, 40)];
            localLabelVal.font = [UIFont fontWithName:[JPFont defaultThinFont] size:35];
            
            ProgramYearlyTuition *tuition = self.program.tuition;
            
            localLabelVal.text = [NSString stringWithFormat:@"$ %.f", tuition.domesticTuition.floatValue];
            localLabelVal.textColor = [UIColor blackColor];
            
            //----------
            UILabel* intLabelVal = [[UILabel alloc] initWithFrame:CGRectMake(70, 105, 190, 40)];
            intLabelVal.font = [UIFont fontWithName:[JPFont defaultThinFont] size:35];
            
            intLabelVal.text = [NSString stringWithFormat:@"$ %.f", tuition.internationalTuition.floatValue];
            intLabelVal.textColor = [UIColor blackColor];
            
            [self addSubview:localLabelVal];
            [self addSubview:intLabelVal];
            self.viewHeight = 170;
        }
        else if([title isEqual:@"Highlight"]) {
          
            self.pieChart = [[PieChartView alloc] initWithFrame:CGRectMake(0, 10, 230, 230)];
            self.pieChart.drawHoleEnabled = true;
            self.pieChart.backgroundColor = [UIColor clearColor];
            self.pieChart.delegate = self;
            self.pieChart.descriptionText = @"";
            self.pieChart.accessibilityLabel = @"whyPieChart";
            [self addSubview:self.pieChart];
            
            //Generating the Pie Chart
            _indexOfLargestSlice = 0;
            float largestValue = 0;
            float totalValue = 0;
            
            if(!_programRating)
                return self;
            
            NSArray* array = @[_programRating.difficulty, _programRating.professor, _programRating.schedule, _programRating.classmates, _programRating.socialEnjoyments, _programRating.studyEnv];
            
            for(int i =0; i<[array count]; i++)
            {
                totalValue = totalValue + [array[i] floatValue];
                
                if([array[i] floatValue]>largestValue)
                {
                    largestValue = [array[i] floatValue];
                    _indexOfLargestSlice = i;
                }
            }
            
            
            //Legend for Pie Chart
            
            NSArray* legendTexts = @[@"Difficulty", @"Professors", @"Schedule", @"Classmates", @"Social", @"Study Environment"];
            
            for(int i=0; i<6; i++)
            {
                UIView* view = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - 20, 20 + 30*i, 20, 15)];
                view.backgroundColor = [JPStyle rainbowColorWithIndex:i];
                
                UILabel* legendLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 100, 17 + 30*i, 70, 20)];
                legendLabel.text = legendTexts[i];
                legendLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:13];
                legendLabel.textColor = [JPStyle colorWithHex:@"750A09" alpha:1];
                legendLabel.textAlignment = NSTextAlignmentRight;
                
                if(i==5)
                {
                    legendLabel.numberOfLines = 2;
                    legendLabel.frame = CGRectMake(frame.size.width - 100, 17 + 30*i - 10, 70, 40);
                }
                
                [self addSubview:view];
                [self addSubview:legendLabel];
            }
            self.viewHeight = 220;
        }
        else if([title isEqual:@"Ratings"])
        {
            self.radarChart = [[RPRadarChart alloc] initWithFrame:CGRectMake(kiPhoneWidthPortrait-220- 25, 0, 220, 220)];
            
            self.radarChart.delegate = self;
            self.radarChart.dataSource = self;
            
            self.radarChart.userInteractionEnabled = NO;
            self.radarChart.backgroundColor = [UIColor whiteColor];
            self.radarChart.guideLineSteps = 4;
            self.radarChart.showGuideNumbers = NO;
            self.radarChart.showValues = YES;
            self.radarChart.dotRadius = 6;
            self.radarChart.backgroundColor = [UIColor clearColor];
            [self addSubview:self.radarChart];
            
            //Overall Value
            UILabel* overallLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 55)];
            overallLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
            overallLabel.numberOfLines = 2;
            double overallRating = [self.program.rating.ratingOverall doubleValue];
            overallLabel.text = [NSString stringWithFormat:@"Overall\n%.0f%%", overallRating];
            [self addSubview:overallLabel];
            
            //Number of Ratings Value
            UILabel* numRatingsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 80, 55)];
            numRatingsLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
            numRatingsLabel.numberOfLines = 2;
            long numRatings = [self.program.rating.weight longValue];
            numRatingsLabel.text = [NSString stringWithFormat:@"%ld\nRatings", numRatings];
            [self addSubview:numRatingsLabel];
            
            self.viewHeight = 220;
        }
        else if([title isEqual:@"Gals vs Guys Ratio"]) {
            self.pieChart = [[PieChartView alloc] initWithFrame:CGRectMake(70, 0, 200, 200)];
            self.pieChart.center = CGPointMake([UIScreen mainScreen].bounds.size.width /2.0, self.pieChart.frame.size.height / 2.0);
            self.pieChart.accessibilityLabel = @"ratioPieChart";
            self.pieChart.drawHoleEnabled = true;
            self.pieChart.backgroundColor = [UIColor clearColor];
            self.pieChart.delegate = self;
            self.pieChart.descriptionText = @"";
            self.pieChart.centerText = @"%";
            self.pieChart.holeColor = [UIColor whiteColor];
            
            self.pieChart.userInteractionEnabled = false;
            [self addSubview:self.pieChart];
            
            self.viewHeight = 170;
        }
        else if([title isEqual:@"Courses"])
        {
            NSArray* termTitles = [self.program.curriculumTerms componentsSeparatedByString:@","];
            UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            scrollView.showsHorizontalScrollIndicator = NO;
            CGFloat contentWidth = frame.size.width;
            
            for(int i=0; i<[termTitles count]/2; i++)
            {
                for(int j=0; j<2; j++)
                {
                    UIButton* yearButton = [[UIButton alloc] initWithFrame:CGRectMake(15 + 120*i, 10+ 80*j, 105, 70)];
                    [yearButton setBackgroundImage:[UIImage imageWithColor:[JPStyle colorWithName:@"tBlack"]] forState:UIControlStateNormal];
                    [yearButton setBackgroundImage:[UIImage imageWithColor:[UIColor blackColor]] forState:UIControlStateHighlighted];
                    yearButton.layer.cornerRadius = 10;
                    yearButton.clipsToBounds = YES;
                    [yearButton setTitle:termTitles[j+i*2] forState:UIControlStateNormal];
                    
                    yearButton.titleLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
                    [yearButton setTintColor:[UIColor whiteColor]];
                    [yearButton setShowsTouchWhenHighlighted:NO];
                    yearButton.tag = j+2*i;
                    [yearButton addTarget:self action:@selector(yearButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    [scrollView addSubview:yearButton];
                    
                    contentWidth = yearButton.frame.origin.x + yearButton.frame.size.width + 15;
                }
                
            }
            
            scrollView.contentSize = CGSizeMake(contentWidth, scrollView.frame.size.height);
            [self addSubview:scrollView];
            
            self.viewHeight = 190;
        }
        else if([title isEqual:@"+"])
        {
            self.viewHeight = 140;
            
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, self.viewHeight)];
            label.font = [UIFont fontWithName:[JPFont defaultThinFont] size:25];
            label.text = @"More Info Soon!";
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
        }
        
        
        
    }
    return self;
}


- (void)yearButtonPressed: (UIButton*)button
{
    [self.delegate courseTermPressed:button.titleLabel.text];
}


#pragma mark - Custom Methods

- (void)reloadData {
    
    // Reload Pie Chart
    NSString *pieChartName = self.pieChart.accessibilityLabel;
    NSUInteger pieChartPieces = [self numberOfSlicesInPieChart: pieChartName];
    
    NSMutableArray *colors = [@[] mutableCopy];
    NSMutableArray *yVals = [@[] mutableCopy];
    for (NSUInteger i=0; i<pieChartPieces; i++) {
        [colors addObject:[self pieChart:pieChartName colorForSliceAtIndex:i]];
        CGFloat value = [self pieChart:pieChartName valueForSliceAtIndex:i];
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithValue:value xIndex:i];
        [yVals addObject: entry];
    }
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithYVals:yVals label: @""];
    dataSet.sliceSpace = 2.0;
    dataSet.colors = colors;
    
    PieChartData *chartData = [[PieChartData alloc] init];
    chartData.dataSets = @[dataSet];
    
    self.pieChart.data = chartData;
}




@end
