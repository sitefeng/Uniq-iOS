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

@class Program, ProgramRating;

@interface iPadProgramDetailGraphView : UIView <CPTBarPlotDataSource, CPTPlotSpaceDelegate, CPTBarPlotDelegate, XYPieChartDataSource, XYPieChartDelegate>

{
    CPTXYGraph*  barChart;
    
    ProgramRating* programRating;
    
}






@property (nonatomic, assign) Program* program;



@property (nonatomic, strong) NSString* title;


@property (nonatomic, strong) CPTGraphHostingView* barChartView;


@property (nonatomic, strong) XYPieChart* whyPieChart;





- (id)initWithFrame:(CGRect)frame  title:(NSString*)title  program:(Program*) program;









@end
