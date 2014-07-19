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


@implementation iPhProgramDetailView

- (instancetype)initWithFrame:(CGRect)frame title: (NSString*)title program: (Program*)program
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [JPStyle colorWithName:@"tWhite"];
        self.program = program;
        self.title = title;
        _programRating = self.program.rating;
        
        UILabel* dashletLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        dashletLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:26];
        dashletLabel.text = title;
        dashletLabel.textAlignment = NSTextAlignmentCenter;
        dashletLabel.backgroundColor = [JPStyle colorWithName:@"tWhite"];
        [self addSubview:dashletLabel];
        
        if([title isEqual:@"About"])
        {
            UITextView* textView =[[ UITextView alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, frame.size.height-30)];
            textView.editable = NO;
            textView.selectable = NO;
            textView.backgroundColor = [UIColor clearColor];
            textView.font = [UIFont fontWithName:[JPFont defaultFont] size:15];
            textView.showsVerticalScrollIndicator = NO;
            textView.text = program.about;
            
            [self addSubview:textView];
        }
        else if([title isEqual:@"Tuition"])
        {
            UILabel* localLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 70, 40)];
            localLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:15];
            localLabel.text = @"Domestic";
            localLabel.textColor = [UIColor blackColor];
            UILabel* intLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 105, 100, 40)];
            intLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:15];
            intLabel.text = @"International";
            intLabel.textColor = [UIColor blackColor];
            
            [self addSubview:localLabel];
            [self addSubview:intLabel];
            
            
            //Tuition Values
            UILabel* localLabelVal = [[UILabel alloc] initWithFrame:CGRectMake(100, 45, 150,70)];
            localLabelVal.font = [UIFont fontWithName:[JPFont defaultThinFont] size:35];
            
            NSDictionary* tuitionDict = [self.program.tuitions anyObject];
            NSDecimalNumber *domesticT = (NSDecimalNumber*)[tuitionDict valueForKey:@"domesticTuition"];
            
            localLabelVal.text = [NSString stringWithFormat:@"$ %@", [domesticT stringValue]];
            localLabelVal.textColor = [UIColor blackColor];
            
            //----------
            UILabel* intLabelVal = [[UILabel alloc] initWithFrame:CGRectMake(100, 120, 150, 70)];
            intLabelVal.font = [UIFont fontWithName:[JPFont defaultThinFont] size:35];
            NSDecimalNumber *internationalT = (NSDecimalNumber*)[tuitionDict valueForKey:@"internationalTuition"];
            intLabelVal.text = [NSString stringWithFormat:@"$ %@", [internationalT stringValue]];
            intLabelVal.textColor = [UIColor blackColor];
            
            [self addSubview:localLabelVal];
            [self addSubview:intLabelVal];

        }
        else if([title isEqual:@"Highlight"])
        {
            self.pieChart = [[XYPieChart alloc] initWithFrame:CGRectMake(5, 35, 200, 200)];
            
            [self.pieChart setDataSource:self];
            [self.pieChart setDelegate:self];
            
            self.pieChart.showLabel = YES;
            
            self.pieChart.startPieAngle = M_PI_2;
            self.pieChart.animationSpeed = 1.0;
            
            self.pieChart.labelFont = [UIFont fontWithName:[JPFont defaultThinFont] size:17];
            self.pieChart.labelColor = [UIColor whiteColor];
            [self.pieChart setPieBackgroundColor: [UIColor clearColor]];
            
            self.pieChart.labelRadius = 50;
            self.pieChart.showPercentage = YES;
            self.pieChart.backgroundColor = [UIColor clearColor];
            self.pieChart.accessibilityLabel = @"whyPieChart";
            
            [self addSubview:self.pieChart];
            
            _indexOfLargestSlice = 0;
            float largestValue = 0;
            float totalValue = 0;
            
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
            
            [self.pieChart setSliceSelectedAtIndex: _indexOfLargestSlice];
            
            
            //Legend
            
            NSArray* legendTexts = @[@"Difficulty", @"Professors", @"Schedule", @"Classmates", @"Social", @"Study Environment"];
            
            for(int i=0; i<6; i++)
            {
                UIView* view = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - 20, 40 + 30*i, 20, 15)];
                view.backgroundColor = [JPStyle rainbowColorWithIndex:i];
                
                UILabel* legendLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 100, 37 + 30*i, 70, 20)];
                legendLabel.text = legendTexts[i];
                legendLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:13];
                legendLabel.textColor = [JPStyle colorWithHex:@"750A09" alpha:1];
                legendLabel.textAlignment = NSTextAlignmentRight;
                
                if(i==5)
                {
                    legendLabel.numberOfLines = 2;
                    legendLabel.frame = CGRectMake(frame.size.width - 100, 37 + 30*i - 10, 70, 40);
                }
                
                [self addSubview:view];
                [self addSubview:legendLabel];
            }

        }
        else if([title isEqual:@"Ratings"])
        {
            self.radarChart = [[RPRadarChart alloc] initWithFrame:CGRectMake((kiPhoneWidthPortrait-220)/2, 30, 220, 220)];
            
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
            
        }
        else if([title isEqual:@"Gals vs Guys Ratio"])
        {
            self.pieChart = [[XYPieChart alloc] initWithFrame:CGRectMake(70, 30, 170, 170) Center:CGPointMake(170/2.0, 170/2.0) Radius:72];
            self.pieChart.dataSource = self;
            self.pieChart.delegate = self;
            self.pieChart.labelFont = [UIFont fontWithName:[JPFont defaultThinFont] size:17];
            self.pieChart.labelColor = [UIColor whiteColor];
            self.pieChart.showPercentage = YES;
            self.pieChart.showLabel = YES;
            self.pieChart.animationSpeed = 1;
            self.pieChart.startPieAngle = M_PI_2;
            self.pieChart.labelRadius = 45;
            
            self.pieChart.accessibilityLabel = @"ratioPieChart";
            [self.pieChart setPieBackgroundColor: self.backgroundColor];
            
            [self setUserInteractionEnabled:NO];
            [self addSubview:self.pieChart];
            
            UILabel* percentageLabel = [[UILabel alloc] init];
            
            [percentageLabel setFrame:CGRectMake(0, 0, 40, 40)];
            [percentageLabel setCenter:self.pieChart.center];
            
            [percentageLabel setFont:[UIFont fontWithName:[JPFont defaultThinFont] size:25]];
            percentageLabel.text = @"%";
            percentageLabel.textColor = [UIColor blackColor];
            percentageLabel.clipsToBounds = YES;
            percentageLabel.textAlignment = NSTextAlignmentCenter;
            percentageLabel.backgroundColor = self.backgroundColor;
            [percentageLabel.layer setCornerRadius:percentageLabel.frame.size.width/2.0f];
            
            [self addSubview:percentageLabel];
            
        }
        else if([title isEqual:@"Courses"])
        {
            NSArray* titles = @[@"1st Year", @"2nd Year", @"3rd Year", @"4th Year"];
            
            for(int i=0; i<2; i++)
            {
                for(int j=0; j<2; j++)
                {
                    UIButton* yearButton = [[UIButton alloc] initWithFrame:CGRectMake(10 + 150*(j%2), 40 + 80 *(i%2), 130, 70)];
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
                    
                    [self addSubview:yearButton];
                }
            }
            
        }
        
        
        
    }
    return self;
}


- (void)yearButtonPressed: (UIButton*)button
{
    [self.delegate courseYearPressedWithYear:button.tag+1];
}


#pragma mark - Why Pie Chart View Methods

- (void)reloadData
{
    [self.pieChart reloadData];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
