//
//  iPadProgramDetailGraphView.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-10.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CorePlot-CocoaTouch.h"
#import "XYPieChart.h"
#import "RPRadarChart.h"

#import "DPMeterView.h"

@class Program, ProgramRating;

@interface iPadProgramDetailGraphView : UIView <CPTBarPlotDataSource, CPTPlotSpaceDelegate, CPTBarPlotDelegate, XYPieChartDataSource, XYPieChartDelegate, RPRadarChartDelegate, RPRadarChartDataSource>

{
    CPTXYGraph*  barChart;
    
    ProgramRating* _programRating;
    
    NSInteger    _indexOfLargestSlice;
}






@property (nonatomic, strong) Program* program;

@property (nonatomic, strong) NSString* title;


@property (nonatomic, strong) CPTGraphHostingView* barChartView;


@property (nonatomic, strong) XYPieChart* whyPieChart;


@property (nonatomic, strong) RPRadarChart* radarChart;
@property (nonatomic, strong) DPMeterView* overallRatingView;



@property (nonatomic, strong) XYPieChart *ratioPieChart;


- (id)initWithFrame:(CGRect)frame  title:(NSString*)title  program:(Program*) program;


- (void)reloadData;






@end
