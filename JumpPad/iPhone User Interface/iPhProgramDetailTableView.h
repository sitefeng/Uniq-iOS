//
//  iPhProgramDetailTableView.h
//  Uniq
//
//  Created by Si Te Feng on 9/7/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPhProgramDetailView.h"

@class iPhProgramDetailView, Program, Faculty, School;
@protocol JPProgramDetailTableViewDataSource;

// Also used for schools and faculties
@interface iPhProgramDetailTableView : UIScrollView <JPCoursesDetailViewDelegate> {
    NSMutableArray* _programDetailViews;
}

@property (nonatomic, strong) Program* program;
@property (nonatomic, strong) Faculty* faculty;
@property (nonatomic, strong) School* school;

@property (nonatomic, assign) JPDashletType type;

@property (nonatomic, strong) id<JPProgramDetailTableViewDataSource> dataSource;

//default is YES
@property (nonatomic, assign) BOOL scrollable;


// Note: Height of the table view doesn't matter when "scrollable = false" because the tableView's height is dynamic depending on the number of dashlets. The delegate will pass back later what the adjusted height for the detail table view is.
- (instancetype)initWithFrame:(CGRect)frame program:(Program*)program;
- (instancetype)initWithFrame:(CGRect)frame faculty:(Faculty*)faculty;
- (instancetype)initWithFrame:(CGRect)frame school:(School*)school;

- (void)reloadData;

- (iPhProgramDetailView*)dashletForRow:(NSInteger)row;

@end


@protocol JPProgramDetailTableViewDataSource <JPCoursesDetailViewDelegate>

@required
- (NSInteger)numberOfDashletsInProgramDetailTable:(iPhProgramDetailTableView*)tableView;

- (NSString*)programDetailTable:(iPhProgramDetailTableView*)tableView dashletTitleForRow:(NSInteger)row;

@optional

- (void)programDetailTable: (iPhProgramDetailTableView*)tableView didFindMaximumHeight: (CGFloat)height;


@end
