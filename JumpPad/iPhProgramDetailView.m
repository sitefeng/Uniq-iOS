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
            self.whyPieChart = [[XYPieChart alloc] initWithFrame:CGRectMake(5, 35, 200, 200)];
            
            [self.whyPieChart setDataSource:self];
            [self.whyPieChart setDelegate:self];
            
            self.whyPieChart.showLabel = YES;
            
            self.whyPieChart.startPieAngle = M_PI_2;
            self.whyPieChart.animationSpeed = 1.0;
            
            self.whyPieChart.labelFont = [UIFont fontWithName:[JPFont defaultThinFont] size:17];
            self.whyPieChart.labelColor = [UIColor whiteColor];
            [self.whyPieChart setPieBackgroundColor: [UIColor clearColor]];
            
            self.whyPieChart.labelRadius = 50;
            self.whyPieChart.showPercentage = YES;
            self.whyPieChart.backgroundColor = [UIColor clearColor];
            self.whyPieChart.accessibilityLabel = @"whyPieChart";
            
            [self addSubview:self.whyPieChart];
            
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
            
            [self.whyPieChart setSliceSelectedAtIndex: _indexOfLargestSlice];
            
            
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
            
            
        }
        else if([title isEqual:@"Gals vs Guys Ratio"])
        {
            
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

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    if([pieChart.accessibilityLabel isEqualToString:@"whyPieChart"])
    {
        return 6;
    }
    else if([pieChart.accessibilityLabel isEqualToString:@"ratioPieChart"])
    {
        return 2;
    }
    
    return 0;
}


- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    CGFloat value = 0.0;
    
    if([pieChart.accessibilityLabel isEqualToString:@"whyPieChart"])
    {
        switch (index)
        {
            case JPRatingTypeDifficulty:
                value = [_programRating.difficulty floatValue];
                break;
            case JPRatingTypeProfessors:
                value = [_programRating.professor floatValue];
                break;
            case JPRatingTypeSchedule:
                value = [_programRating.schedule floatValue];
                break;
            case JPRatingTypeClassmates:
                value = [_programRating.classmates floatValue];
                break;
            case JPRatingTypeSocialEnjoyment:
                value = [_programRating.socialEnjoyments floatValue];
                break;
            case JPRatingTypeStudyEnvironment:
                value = [_programRating.studyEnv floatValue];
                break;
            default:
                NSLog(@"pie chart error");
                
        }
        
    }
    else if([pieChart.accessibilityLabel isEqualToString:@"ratioPieChart"])
    {
        if(index == 0)//Girls
        {
            return (100 - [_programRating.guyToGirlRatio floatValue]);
        }
        else
        {
            return [_programRating.guyToGirlRatio floatValue];
        }
    }
    
    return value;
}


- (UIColor*)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    if([pieChart.accessibilityLabel isEqualToString:@"whyPieChart"])
    {
        return [JPStyle rainbowColorWithIndex:index];
    }
    else if([pieChart.accessibilityLabel isEqualToString:@"ratioPieChart"])
    {
        if(index ==0) //girl
        {
            return [JPStyle rainbowColorWithIndex:0];//pink
        }
        else
        {
            return [JPStyle rainbowColorWithIndex:2];//blue
        }
    }
    else
    {
        return [UIColor whiteColor];
    }
    
}

- (void)reloadData
{
    [self.whyPieChart reloadData];
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
