//
//  iPadProgramDetailGraphView.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-10.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RPRadarChart.h"

#import "DPMeterView.h"
#import "JPProgramDetailView.h"

@class Program, ProgramRating;

@interface iPadProgramDetailGraphView : JPProgramDetailView {
    NSInteger    _indexOfLargestSlice;
}



@property (nonatomic, strong) Program* program;

@property (nonatomic, strong) NSString* title;

@property (nonatomic, strong) PieChartView* whyPieChart;

@property (nonatomic, strong) RPRadarChart* radarChart;
@property (nonatomic, strong) DPMeterView* overallRatingView;

@property (nonatomic, strong) PieChartView *ratioPieChart;


- (id)initWithFrame:(CGRect)frame  title:(NSString*)title  program:(Program*) program;
- (void)reloadData;

@end
