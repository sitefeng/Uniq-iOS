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

@class Program, ProgramRating;
@protocol JPCoursesDetailViewDelegate;
@interface iPhProgramDetailView : UIView <XYPieChartDataSource, XYPieChartDelegate>
{
    ProgramRating* _programRating;
    float  _indexOfLargestSlice;
}



@property (nonatomic, strong)Program* program;
@property (nonatomic, strong)NSString* title;


@property (nonatomic, strong)XYPieChart* whyPieChart;


@property (nonatomic, weak) id<JPCoursesDetailViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame title: (NSString*)title program: (Program*)program;


- (void)reloadData;


@end

@protocol JPCoursesDetailViewDelegate <NSObject>

- (void)courseYearPressedWithYear: (NSInteger)year;

@end