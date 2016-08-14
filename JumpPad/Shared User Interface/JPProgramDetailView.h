//
//  JPProgramDetailView.h
//  Uniq
//
//  Created by Si Te Feng on 7/19/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//


@import Charts;
#import <UIKit/UIKit.h>
#import "RPRadarChart.h"

@class ProgramRating;
@interface JPProgramDetailView : UIView<ChartViewDelegate, RPRadarChartDataSource, RPRadarChartDelegate>
{
    @protected
    ProgramRating* _programRating;
}



- (UIColor*)pieChart:(NSString *)pieChartName colorForSliceAtIndex:(NSUInteger)index;

- (CGFloat)pieChart:(NSString *)pieChartName valueForSliceAtIndex:(NSUInteger)index;

- (NSUInteger)numberOfSlicesInPieChart:(NSString *)pieChartName;




@end
