//
//  iPhProgramDetailView.h
//  Uniq
//
//  Created by Si Te Feng on 7/13/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;

#import "iPadProgramDetailGraphView.h"
#import "JPProgramDetailView.h"
#import "JPRatings.h"
#import "ProgramDetailViewGeneric.h"

@class Program, ProgramRating, RPRadarChart;
@protocol JPCoursesDetailViewDelegate;
@interface iPhProgramDetailView : JPProgramDetailView <ChartViewDelegate, RPRadarChartDataSource, RPRadarChartDelegate, ProgramDetailViewGeneric>
{

    float  _indexOfLargestSlice;
    
}



@property (nonatomic, strong) Program* program;


@property (nonatomic, strong) NSString* title;
@property (nonatomic, assign) CGFloat viewHeight;

@property (nonatomic, strong) PieChartView* pieChart;
@property (nonatomic, strong) RPRadarChart* radarChart;

@property (nonatomic, weak) id<JPCoursesDetailViewDelegate> delegate;



- (instancetype)initWithFrame:(CGRect)frame title: (NSString*)title program: (Program*)program;

- (void)reloadData;



@end

@protocol JPCoursesDetailViewDelegate <NSObject>
@optional
- (void)courseTermPressed: (NSString*)term;

@end



