//
//  iPhProgramDetailTableView.h
//  Uniq
//
//  Created by Si Te Feng on 9/7/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPhProgramDetailView.h"

@class iPhProgramDetailView, Program;
@protocol JPProgramDetailTableViewDataSource;
@interface iPhProgramDetailTableView : UIScrollView <JPCoursesDetailViewDelegate>
{
    NSMutableArray* _programDetailViews;
}

@property (nonatomic, strong) Program* program;

@property (nonatomic, strong) id<JPProgramDetailTableViewDataSource> dataSource;

//default is YES
@property (nonatomic, assign) BOOL scrollable;


- (instancetype)initWithFrame:(CGRect)frame program:(Program*)program;

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
