//
//  iPadProgramDetailGraphView.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-10.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramDetailGraphView.h"

#import "Program.h"
#import "ProgramRating.h"
#import "CorePlot-CocoaTouch.h"

#import "ApplicationConstants.h"
#import "JPStyle.h"
#import "JPFont.h"
#import "JPGlobal.h"
#import "UIBezierPath+BasicShapes.h"


@implementation iPadProgramDetailGraphView //For one detail graph element in a program



- (id)initWithFrame:(CGRect)frame  title:(NSString*)title  program:(Program*) program
{

    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.program = program;
        
        self.title = title;
        programRating = self.program.rating;
        
        

        
        if([self.title isEqualToString:@"Tuition"])
        {
            self.backgroundColor = [UIColor whiteColor];
            [self initializeTuition];
        }
        

        if([self.title isEqualToString:@"Why"])
        {
//            self.backgroundColor = [JPStyle colorWithHex:@"FFFFB3" alpha:1];

            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"whiteBackground"]];
            
            [self initializeWhy];

        }
        
        
        if([self.title isEqualToString:@"Ratings"])
        {
            self.backgroundColor = [UIColor whiteColor];
            
            [self initializeRatings];
        }
        
        
        if([self.title isEqualToString:@"Ratio"])
        {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"whiteBackground"]];
            
            self.ratioPieChart = [[XYPieChart alloc] initWithFrame:CGRectMake(450, 50, 200, 200) Center:CGPointMake(100, 100) Radius:100];
            self.ratioPieChart.dataSource = self;
            self.ratioPieChart.delegate = self;
            self.ratioPieChart.labelFont = [JPFont coolFontOfSize:20];
            self.ratioPieChart.labelColor = [UIColor whiteColor];
            self.ratioPieChart.showPercentage = YES;
            self.ratioPieChart.showLabel = YES;
            
            self.ratioPieChart.animationSpeed = 1;
            self.ratioPieChart.startPieAngle = M_PI_2;
            self.ratioPieChart.labelShadowColor = [UIColor blackColor];
            self.ratioPieChart.labelRadius = 66;
            
            self.ratioPieChart.accessibilityLabel = @"ratioPieChart";
            [self.ratioPieChart setPieBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"whiteBackground"]]];
            
            [self setUserInteractionEnabled:NO];
            
            [self.ratioPieChart reloadData];
            [self addSubview:self.ratioPieChart];
            
            
            UILabel* percentageLabel = [[UILabel alloc] init];
            
            [percentageLabel setFrame:CGRectMake(0, 0, 70, 70)];
            [percentageLabel setCenter:self.ratioPieChart.center];
            
            [percentageLabel setFont:[JPFont coolFontOfSize:35]];
            percentageLabel.text = @"%";
            percentageLabel.textColor = [UIColor blackColor];
            percentageLabel.clipsToBounds = YES;
            percentageLabel.textAlignment = NSTextAlignmentCenter;
            percentageLabel.backgroundColor = self.backgroundColor;
            [percentageLabel.layer setCornerRadius:percentageLabel.frame.size.width/2.0f];
            
            [self addSubview:percentageLabel];
            
            
            UILabel* ratioTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 50, 350, 200)];
            ratioTitle.textAlignment = NSTextAlignmentCenter;
      
            ratioTitle.font = [UIFont fontWithName:[JPFont defaultThinFont] size:55];
            ratioTitle.textColor = [JPStyle programViewTitleColor];
            ratioTitle.text = @"Gals vs Guys\nRatio";
            ratioTitle.numberOfLines = 2;
            
            [self addSubview:ratioTitle];
            
            
            
            
        }
        
        
        
        
        
        
        
    }
    return self;
}


    
           
           
           
#pragma mark - Tuition View Methods
           
- (void)initializeTuition
{
    //Title
    float titleLabelY = 20 + 30;
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, titleLabelY, 136, 55)];
    titleLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:55];
    titleLabel.text = self.title;
    [titleLabel sizeToFit];
    titleLabel.textColor = [JPStyle programViewTitleColor];
    [self addSubview:titleLabel];
    
    UILabel* localLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, titleLabelY + 55, 70, 40)];
    localLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:15];
    localLabel.text = @"Domestic";
    localLabel.textColor = [UIColor blackColor];
    UILabel* intLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, titleLabelY + 145, 100, 40)];
    intLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:15];
    intLabel.text = @"International";
    intLabel.textColor = [UIColor blackColor];
    
    [self addSubview:localLabel];
    [self addSubview:intLabel];
    
    
    
    //Tuition Values
    UILabel* localLabelVal = [[UILabel alloc] initWithFrame:CGRectMake(70, titleLabelY + 80, 150,70)];
    localLabelVal.font = [JPFont coolFontOfSize:35];
    
    NSDictionary* tuitionDict = [self.program.tuitions anyObject];
    NSDecimalNumber *domesticT = (NSDecimalNumber*)[tuitionDict valueForKey:@"domesticTuition"];
    
    localLabelVal.text = [NSString stringWithFormat:@"$ %@", [domesticT stringValue]];
    localLabelVal.textColor = [UIColor blackColor];
    
    //----------
    UILabel* intLabelVal = [[UILabel alloc] initWithFrame:CGRectMake(70, titleLabelY + 170, 150, 70)];
    intLabelVal.font = [JPFont coolFontOfSize:35];
    NSDecimalNumber *internationalT = (NSDecimalNumber*)[tuitionDict valueForKey:@"internationalTuition"];
    intLabelVal.text = [NSString stringWithFormat:@"$ %@", [internationalT stringValue]];
    intLabelVal.textColor = [UIColor blackColor];
    
    [self addSubview:localLabelVal];
    [self addSubview:intLabelVal];
    
    
    //Chart
    
    barChart = [[CPTXYGraph alloc] initWithFrame:CGRectZero xScaleType:CPTScaleTypeLinear yScaleType:CPTScaleTypeLinear];
    
    CPTTheme* theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    [barChart applyTheme:theme];
    
    self.barChartView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(250, 20, 500, 300)];
    
    self.barChartView.allowPinchScaling = YES;
    self.barChartView.hostedGraph = barChart;
    
    barChart.plotAreaFrame.masksToBorder = NO;
    
    barChart.paddingLeft   = 70.0;
    barChart.paddingTop    = 20.0;
    barChart.paddingRight  = 20.0;
    barChart.paddingBottom = 50.0;
    
    ///////////////////////
    
    CPTMutableLineStyle *majorGridLineStyle = [CPTMutableLineStyle lineStyle];
    majorGridLineStyle.lineWidth = 1.0;
    majorGridLineStyle.lineColor = [[CPTColor blackColor] colorWithAlphaComponent:0.75];
    
    CPTMutableLineStyle *minorGridLineStyle = [CPTMutableLineStyle lineStyle];
    minorGridLineStyle.lineWidth = 1.0;
    minorGridLineStyle.lineColor = [[CPTColor blackColor] colorWithAlphaComponent:0.25];
    
    
    
    //////////////////////
    CPTXYPlotSpace* plotSpace = (CPTXYPlotSpace  *)barChart.defaultPlotSpace;
    
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length: CPTDecimalFromFloat(40.00f)];
    
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(3.0f)];
    
    /////////////////////&&&&&&&&&&&&&&&&&&
    CPTXYAxisSet *axisSet = (CPTXYAxisSet*) barChart.axisSet;
    
    CPTXYAxis *x = axisSet.xAxis;
    
    x.axisLineStyle = nil;
    x.majorGridLineStyle = majorGridLineStyle;
    x.minorGridLineStyle = minorGridLineStyle;
    
    x.minorTicksPerInterval = 0;
    
    x.majorTickLineStyle = nil;
    x.minorTickLineStyle = nil;
    x.majorIntervalLength = CPTDecimalFromFloat(1.0f);
    
    x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
    
    /////////
    x.title  = @"Tuition Type";
    CPTMutableTextStyle* labelTextStyle = [CPTMutableTextStyle textStyle];
    labelTextStyle.fontSize = 16;
    labelTextStyle.fontName = [JPFont defaultBoldFont];
    labelTextStyle.color = [CPTColor colorWithComponentRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1];
    
    x.titleTextStyle = labelTextStyle;
    x.titleLocation = CPTDecimalFromDouble(1.5);
    x.titleOffset = 27;
    ////////
    
    //custom labels
    x.labelRotation = 0;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    NSArray *customTickLocations = @[@1, @2.4];
    NSArray *xAxisLabels         = @[@"Domestic", @"International"];
    
    NSMutableSet *customLabels   = [NSMutableSet setWithCapacity:[xAxisLabels count]];
    
    for(int i=0; i<2; i++)
    {
        CPTAxisLabel* newLabel = [[CPTAxisLabel alloc] initWithText:xAxisLabels[i] textStyle:x.labelTextStyle];
        newLabel.tickLocation = [(NSNumber*)customTickLocations[i] decimalValue];
        newLabel.offset = x.labelOffset + x.majorTickLength;
        newLabel.rotation = 0;
        
        [customLabels addObject:newLabel];
    }
    
    x.axisLabels = customLabels;
    
    ////////////////////////////
    
    
    CPTXYAxis *y = (CPTXYAxis*) axisSet.yAxis;
    
    y.axisLineStyle = nil;
    
    y.majorGridLineStyle = majorGridLineStyle;
    y.minorGridLineStyle = minorGridLineStyle;
    y.minorTicksPerInterval = 4;
    
    y.majorTickLineStyle = nil;
    y.minorTickLineStyle = nil;
    y.majorIntervalLength = CPTDecimalFromDouble(10.0);
    
    y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0);
    
    y.title = @"Tuition (kCAD/year)";
    y.titleTextStyle = labelTextStyle;
    y.titleOffset = 40;
    
    y.titleLocation = CPTDecimalFromDouble(20.0);
    
    
    //////////////////
    // First bar plot
    CPTBarPlot* barPlot1 = [CPTBarPlot tubularBarPlotWithColor:[CPTColor whiteColor] horizontalBars:NO];
    
    barPlot1.baseValue = CPTDecimalFromDouble(0.0);
    barPlot1.barWidth = CPTDecimalFromDouble(0.25);
    
    barPlot1.barOffset = CPTDecimalFromFloat(-0.25f);
    barPlot1.identifier = @"name";
    barPlot1.dataSource = self;
    barPlot1.delegate = self;
    
    [barChart addPlot:barPlot1 toPlotSpace:plotSpace];
    
    
    // Second bar plot
    CPTBarPlot* barPlot2 = [CPTBarPlot tubularBarPlotWithColor:[CPTColor blueColor] horizontalBars:NO];
    
    barPlot2.baseValue       = CPTDecimalFromDouble(0.0);
    barPlot2.barWidth        = CPTDecimalFromDouble(0.25);
    barPlot2.barOffset       = CPTDecimalFromFloat(0.0f);
    
    barPlot2.identifier      = @"School Aveg";
    barPlot2.dataSource      = self;
    barPlot2.delegate         = self;
    [barChart addPlot:barPlot2 toPlotSpace:plotSpace];
    
    
    // Third bar plot
    CPTBarPlot* barPlot3 = [CPTBarPlot tubularBarPlotWithColor:[CPTColor orangeColor] horizontalBars:NO];
    
    barPlot3.baseValue       = CPTDecimalFromDouble(0.0);
    barPlot3.barWidth        = CPTDecimalFromDouble(0.25);
    barPlot3.barOffset       = CPTDecimalFromFloat(0.25f);
    
    barPlot3.identifier      = @"National Aveg";
    barPlot3.dataSource      = self;
    barPlot3.delegate         = self;
    [barChart addPlot:barPlot3 toPlotSpace:plotSpace];
    
    
    /////////////Legend
    CPTBarPlot* barPlot4 = [CPTBarPlot tubularBarPlotWithColor:[CPTColor greenColor] horizontalBars:NO];
    barPlot4.identifier = self.program.name;
    CPTBarPlot* barPlot5 = [CPTBarPlot tubularBarPlotWithColor:[CPTColor colorWithComponentRed:99/255.0 green:188/255.0 blue:255/255.0 alpha:1] horizontalBars:NO];
    barPlot5.identifier = @"School Avg";
    CPTBarPlot* barPlot6 = [CPTBarPlot tubularBarPlotWithColor:[CPTColor colorWithComponentRed:255/255.0 green:94/255.0 blue:127/255.0 alpha:1] horizontalBars:NO];
    barPlot6.identifier = @"National Avg";
    
    CPTLegend* legend = [CPTLegend legendWithPlots:@[barPlot4, barPlot5, barPlot6]];
    
    
    CPTGradient* gradient = [CPTGradient gradientWithBeginningColor:[CPTColor colorWithComponentRed:94/255.0 green:158/255.0 blue:255/255.0 alpha:1] endingColor:[CPTColor colorWithComponentRed:81/255.0 green:70/255.0 blue:180/255.0 alpha:1]];
    
    legend.fill =[CPTFill fillWithGradient:gradient];;
    
    CPTMutableLineStyle* lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineColor = [CPTColor whiteColor];
    lineStyle.lineWidth = 1.0;
    
    legend.borderLineStyle = lineStyle;
    
    legend.cornerRadius = 5.0;
    
    CPTMutableTextStyle* textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color = [CPTColor whiteColor];
    textStyle.fontName = [JPFont defaultBoldFont];
    textStyle.fontSize = 13;
    legend.textStyle = textStyle;
    
    legend.numberOfRows = 3;
    legend.numberOfColumns = 1;
    
    legend.paddingLeft   = 10.0;
    legend.paddingTop    = 10.0;
    legend.paddingRight  = 10.0;
    legend.paddingBottom = 10.0;
    
    barChart.legend = legend;
    barChart.legendAnchor = CPTRectAnchorTopLeft;
    barChart.legendDisplacement = CGPointMake(80, -28);
    
    
    
    [self addSubview:self.barChartView];
}













- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return 2;
}


- (NSNumber*)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    //tuitions:
    float localTuition = (8279.53f)/1000;
    float intTuition = (36892.00f)/1000;
    
    NSNumber *num = nil;
    
    
    
    if ( [plot isKindOfClass:[CPTBarPlot class]] ) {
        switch ( fieldEnum ) {
            case CPTBarPlotFieldBarTip:
                if([plot.identifier isEqual:@"name"])
                {
                    if(index == 0) //local
                        num = [NSNumber numberWithFloat:localTuition];
                    else //international
                        num = [NSNumber numberWithFloat:intTuition];
                }
                else if([plot.identifier isEqual:@"School Aveg"]) //schoolAvg
                {
                    if(index == 0)
                        num = [NSNumber numberWithFloat:(localTuition + 5)];
                    else //international
                        num = [NSNumber numberWithFloat:(intTuition - 4)];
                    
                }
                else if([plot.identifier isEqual:@"National Aveg"])//national avg
                {
                    if(index == 0)
                        num = [NSNumber numberWithFloat:(localTuition - 1)];
                    else //international
                        num = [NSNumber numberWithFloat:(intTuition + 2)];
                }
                else
                {
                    num = [NSNumber numberWithFloat:1];
                }
                
                break;
                
            case CPTBarPlotFieldBarLocation:
                if ( index == 0 ) {
                    num = @(1);
                }
                else if(index == 1)
                {
                    num = @(2.4);
                }
                else
                {
                    NSLog(@"error position");
                }
                
                break;
        }
    }
    
    return num;
    
}



- (CPTFill *)barFillForBarPlot:(CPTBarPlot *)barPlot recordIndex:(NSUInteger)index
{
    CPTGradient* gradient = [CPTGradient gradientWithBeginningColor:[CPTColor whiteColor] endingColor:[CPTColor blackColor]];
    
    //    CPTColor* endColor =[CPTColor colorWithComponentRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1];
    
    
    if([barPlot.identifier isEqual:@"name"] || [barPlot.identifier isEqual:self.program.name])
    {
        gradient = [CPTGradient gradientWithBeginningColor:[CPTColor colorWithComponentRed:0/255.0 green:200/255.0 blue:0/255.0 alpha:1] endingColor:[CPTColor colorWithComponentRed:0/255.0 green:200/255.0 blue:0/255.0 alpha:0.2]];
        
    }
    else if([barPlot.identifier isEqual:@"School Aveg"]||[barPlot.identifier isEqual:@"School Avg"])
    {
        gradient = [CPTGradient gradientWithBeginningColor:[CPTColor colorWithComponentRed:99/255.0 green:188/255.0 blue:255/255.0 alpha:1] endingColor:[CPTColor colorWithComponentRed:99/255.0 green:188/255.0 blue:255/255.0 alpha:0.2]];
        
    }
    else if([barPlot.identifier isEqual:@"National Aveg"]||[barPlot.identifier isEqual:@"National Avg"]) //National Avg
    {
        gradient = [CPTGradient gradientWithBeginningColor:[CPTColor colorWithComponentRed:255/255.0 green:94/255.0 blue:127/255.0 alpha:1] endingColor:[CPTColor colorWithComponentRed:255/255.0 green:94/255.0 blue:127/255.0 alpha:0.2]];
        
    }
    
    CPTFill* fill = [CPTFill fillWithGradient:gradient];
    return  fill;
    
}



-(void)barPlot:(CPTBarPlot *)plot barWasSelectedAtRecordIndex:(NSUInteger)index
{
    
    
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
                value = [programRating.difficulty floatValue];
                break;
            case JPRatingTypeProfessors:
                value = [programRating.professor floatValue];
                break;
            case JPRatingTypeSchedule:
                value = [programRating.schedule floatValue];
                break;
            case JPRatingTypeClassmates:
                value = [programRating.classmates floatValue];
                break;
            case JPRatingTypeSocialEnjoyment:
                value = [programRating.socialEnjoyments floatValue];
                break;
            case JPRatingTypeStudyEnvironment:
                value = [programRating.studyEnv floatValue];
                break;
            default:
                NSLog(@"pie chart error");
            
        }
        
    }
    else if([pieChart.accessibilityLabel isEqualToString:@"ratioPieChart"])
    {
        if(index == 0)//Girls
        {
            return (100 - [programRating.guyToGirlRatio floatValue]);
        }
        else
        {
            return [programRating.guyToGirlRatio floatValue];
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




- (void)initializeWhy
{
    
    //Title
    float titleLabelY = 20;
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, titleLabelY, 700, 55)];
    titleLabel.text = [NSString stringWithFormat:@"%@ Highlight", self.program.name];
    
    float fontSize = 45.0f;
    NSString* fontName = [JPFont defaultThinFont];
    
    CGSize size = [titleLabel.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize]}];
    
    while(size.width > 688)
    {
        fontSize -= 0.5;
        size = [titleLabel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize]}];
    }
    
    titleLabel.font = [UIFont fontWithName:fontName size:fontSize];
    [titleLabel sizeToFit];
    titleLabel.textColor = [JPStyle programViewTitleColor];
    [self addSubview:titleLabel];
    
    
    
    
    self.whyPieChart = [[XYPieChart alloc] initWithFrame:CGRectMake(340, 100, 300, 300)];
    
    [self.whyPieChart setDataSource:self];
    [self.whyPieChart setDelegate:self];
    
    self.whyPieChart.showLabel = YES;
    
    self.whyPieChart.startPieAngle = M_PI_2;
    self.whyPieChart.animationSpeed = 1.0;
    
    self.whyPieChart.labelFont = [JPFont coolFontOfSize:20];
    self.whyPieChart.labelColor = [UIColor whiteColor];
    
    self.whyPieChart.labelShadowColor = [UIColor blackColor];
    [self.whyPieChart setPieBackgroundColor: self.backgroundColor];
    
    self.whyPieChart.labelRadius = 100;
    self.whyPieChart.showPercentage = YES;
    
    self.whyPieChart.accessibilityLabel = @"whyPieChart";
    
    [self addSubview:self.whyPieChart];
    
    [self.whyPieChart reloadData];
    
    int indexOfLargestValue = 0;
    float largestValue = 0;
    float totalValue = 0;
    
    NSArray* array = @[programRating.difficulty, programRating.professor, programRating.schedule, programRating.classmates, programRating.socialEnjoyments, programRating.studyEnv];
    
    for(int i =0; i<[array count]; i++)
    {
        totalValue = totalValue + [array[i] floatValue];
        
        if([array[i] floatValue]>largestValue)
        {
            largestValue = [array[i] floatValue];
            indexOfLargestValue = i;
        }
    }
    
    [self.whyPieChart setSliceSelectedAtIndex: indexOfLargestValue];
    
    
    
    //Legend
    
    NSArray* legendTexts = @[@"Difficulty", @"Professors", @"Schedule", @"Classmates", @"Social", @"Study Environment"];
    
    for(int i=0; i<6; i++)
    {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(720, 115 + 30*i, 48, 15)];
        view.backgroundColor = [JPStyle rainbowColorWithIndex:i];
        
        UILabel* legendLabel = [[UILabel alloc] initWithFrame:CGRectMake(640, 112 + 30*i, 74, 20)];
        
        legendLabel.text = legendTexts[i];
        legendLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:13];
        legendLabel.textColor = [JPStyle colorWithHex:@"750A09" alpha:1];
        legendLabel.textAlignment = NSTextAlignmentRight;
        
        if(i==5)
        {
            legendLabel.numberOfLines = 2;
            legendLabel.frame = CGRectMake(640, 112 + 30*i - 10, 74, 40);
        }
        
        [self addSubview:view];
        [self addSubview:legendLabel];
    }
    
    
    
    
    UILabel* percentageLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 90, 270, 60)];
    percentageLabel.textColor = [UIColor blackColor];
    percentageLabel.font = [JPFont coolFontOfSize:50];
    percentageLabel.textAlignment = NSTextAlignmentCenter;
    
    
    float largestPercentage = [array[indexOfLargestValue] floatValue]/totalValue*100;
    percentageLabel.text = [[NSMutableString stringWithFormat:@"%.0f", largestPercentage] stringByAppendingString:@"%"];
    
    
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(30, 150, 300, 250)];
    textView.font = [UIFont fontWithName:[JPFont defaultThinFont] size:30];
    
    textView.textAlignment = NSTextAlignmentCenter;
    textView.textColor = [UIColor blackColor];
    textView.backgroundColor = [UIColor clearColor];
    
    NSArray* words = @[@"think", @"believe", @"said", @"rated that", @"responses indicate"];
    
    int index = arc4random()%5;
    NSString* wordToUse = words[index];
    
    if(index< 4)
    {
        if(arc4random()%2 == 0)
            wordToUse = [NSString stringWithFormat:@"%@ %@", @"people", wordToUse];
    }
    
    switch (indexOfLargestValue)
    {
        case JPRatingTypeDifficulty:
            textView.text = [NSString stringWithFormat:@"%@ %@ is difficult", wordToUse, self.program.name];
            break;
        case JPRatingTypeProfessors:
            textView.text = [NSString stringWithFormat: @"%@ the professors for %@ are good",wordToUse, self.program.name ];
            break;
        case JPRatingTypeClassmates:
            textView.text = [NSString stringWithFormat: @"%@ classmates in %@ are friendly",wordToUse, self.program.name ];
            break;
        case JPRatingTypeSchedule:
            textView.text = [NSString stringWithFormat: @"%@ the schedule in %@ is tough",wordToUse, self.program.name ];
            break;
        case JPRatingTypeSocialEnjoyment:
            textView.text = [NSString stringWithFormat: @"%@ they had a FUN time while studying %@",wordToUse, self.program.name ];
            break;
        case JPRatingTypeStudyEnvironment:
            textView.text = [NSString stringWithFormat: @"%@ the study environment is enjoyable",wordToUse];
            break;
            
            
    }
    
    textView.userInteractionEnabled = NO;
    
    
    [self addSubview:textView];
    [self addSubview:percentageLabel];
}





#pragma mark Radar Chart Method and Data Source and Delegate Methods

- (void)initializeRatings
{
    self.radarChart = [[RPRadarChart alloc] initWithFrame:CGRectMake(435, 20, 300, 300)];
    
    self.radarChart.delegate = self;
    self.radarChart.dataSource = self;
    
    self.radarChart.userInteractionEnabled = NO;
    self.radarChart.backgroundColor = [UIColor whiteColor];
    self.radarChart.guideLineSteps = 4;
    self.radarChart.showGuideNumbers = NO;
    self.radarChart.showValues = YES;
    self.radarChart.dotRadius = 6;
    [self addSubview:self.radarChart];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 150, 55)];
    titleLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:55];
    titleLabel.text = self.title;
    [titleLabel sizeToFit];
    titleLabel.textColor = [JPStyle programViewTitleColor];
    [self addSubview:titleLabel];
    
    UILabel* overallLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 115, 110, 50)];
    overallLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
    overallLabel.text = @"Overall";
    overallLabel.textColor = [UIColor blackColor];
    
    UILabel* byCategories = [[UILabel alloc] initWithFrame:CGRectMake(329, 115, 150, 50)];
    byCategories.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
    byCategories.text = @"By Categories";
    byCategories.textColor = [UIColor blackColor];
    
    [self addSubview:overallLabel];
    [self addSubview:byCategories];
    /////////////////////////////////////////////////////
    
    UIBezierPath* bezierPath = [UIBezierPath heartShape:CGRectMake(100, 130, 200, 200)];
    CGPathRef pathRef = bezierPath.CGPath;
    
    self.overallRatingView = [[DPMeterView alloc] initWithFrame:CGRectMake(100, 130, 200, 200) shape:pathRef gravity:YES];
    self.overallRatingView.meterType = DPMeterTypeLinearVertical;
    self.overallRatingView.trackTintColor = [JPStyle translucentRainbowColorWithIndex:0];
    self.overallRatingView.progressTintColor = [JPStyle rainbowColorWithIndex:0];
    self.overallRatingView.progress = [programRating.ratingOverall floatValue] / 103.0f;
    [self addSubview:self.overallRatingView];
    
    UILabel* overallPercent = [[UILabel alloc] initWithFrame:CGRectMake(173, 200, 100, 50)];
    overallPercent.textColor = [UIColor blackColor];
    overallPercent.font = [JPFont coolFontOfSize:29];
    overallPercent.text = [[NSMutableString stringWithFormat:@"%i", [programRating.ratingOverall intValue]] stringByAppendingString:@"%"];
    [self addSubview:overallPercent];
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
            return [programRating.difficulty floatValue];
            break;
        case 1:
            return [programRating.professor floatValue];
            break;
        case 2:
            return [programRating.schedule floatValue];
            break;
        case 3:
            return [programRating.classmates floatValue];
            break;
        case 4:
            return [programRating.socialEnjoyments floatValue];
            break;
        case 5:
            return [programRating.studyEnv floatValue];
            break;
        default:
            return 0.0f;
            break;
    }
    
}


- (UIColor*)radarChart:(RPRadarChart *)chart colorForData:(NSInteger)atIndex
{
    NSInteger randomInt = arc4random() % 6;
    return [JPStyle rainbowColorWithIndex: randomInt];
}






#pragma mark - Other Methods

- (void)reloadData
{
    [self.whyPieChart reloadData];
    [self.ratioPieChart reloadData];
    
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
