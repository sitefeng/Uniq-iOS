//
//  JPProgramDetailView.m
//  Uniq
//
//  Created by Si Te Feng on 7/19/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPProgramDetailView.h"
#import "RPRadarChart.h"
#import "XYPieChart.h"
#import "JPGlobal.h"
#import "ProgramRating.h"

@implementation JPProgramDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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



- (NSInteger)numberOfSopkesInRadarChart:(RPRadarChart *)chart
{
    return 6;
}


- (NSInteger)numberOfDatasInRadarChart:(RPRadarChart *)chart
{
    return 1;
}


- (float)maximumValueInRadarChart:(RPRadarChart *)chart
{
    return 100;
}


- (NSString*)radarChart:(RPRadarChart *)chart titleForSpoke:(NSInteger)atIndex
{
    if(atIndex != JPRatingTypeStudyEnvironment)
        return [JPGlobal ratingStringWithIndex:atIndex];
    else
        return @"Study Env.";
}


- (float)radarChart:(RPRadarChart *)chart valueForData:(NSInteger)dataIndex forSpoke:(NSInteger)spokeIndex
{
    
    switch (spokeIndex) {
        case 0:
            return [_programRating.difficulty floatValue];
            break;
        case 1:
            return [_programRating.professor floatValue];
            break;
        case 2:
            return [_programRating.schedule floatValue];
            break;
        case 3:
            return [_programRating.classmates floatValue];
            break;
        case 4:
            return [_programRating.socialEnjoyments floatValue];
            break;
        case 5:
            return [_programRating.studyEnv floatValue];
            break;
        default:
            return 0.0f;
            break;
    }
    
}


- (UIColor*)radarChart:(RPRadarChart *)chart colorForData:(NSInteger)atIndex
{
    return [JPStyle rainbowColorWithIndex: 4];
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
