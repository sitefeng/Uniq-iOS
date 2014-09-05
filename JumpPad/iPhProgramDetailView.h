//
//  iPhProgramDetailView.h
//  Uniq
//
//  Created by Si Te Feng on 7/13/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"
#import "iPadProgramDetailGraphView.h"
#import "JPProgramDetailView.h"
#import "JPRatings.h"

@class Program, ProgramRating, RPRadarChart;
@protocol JPCoursesDetailViewDelegate;
@interface iPhProgramDetailView : JPProgramDetailView <XYPieChartDataSource, XYPieChartDelegate, RPRadarChartDataSource, RPRadarChartDelegate>
{

    float  _indexOfLargestSlice;
    
}



@property (nonatomic, strong)Program* program;
@property (nonatomic, strong)NSString* title;


@property (nonatomic, strong)XYPieChart* pieChart;
@property (nonatomic, strong)RPRadarChart* radarChart;

@property (nonatomic, weak) id<JPCoursesDetailViewDelegate> delegate;



- (instancetype)initWithFrame:(CGRect)frame title: (NSString*)title program: (Program*)program;

- (void)reloadData;



@end

@protocol JPCoursesDetailViewDelegate <NSObject>

- (void)courseTermPressed: (NSString*)term;

@end