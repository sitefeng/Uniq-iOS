//
//  JPProgramDetailView.h
//  Uniq
//
//  Created by Si Te Feng on 7/19/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPRadarChart.h"
#import "XYPieChart.h"

@class ProgramRating;
@interface JPProgramDetailView : UIView<XYPieChartDataSource, XYPieChartDelegate, RPRadarChartDataSource, RPRadarChartDelegate>
{
    @protected
    ProgramRating* _programRating;
}












@end
