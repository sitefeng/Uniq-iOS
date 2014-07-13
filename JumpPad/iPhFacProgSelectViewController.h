//
//  iPhFacProgSelectViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPhFacProgSelectViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSManagedObjectContext* context;
}


@property (nonatomic, assign) JPDashletType type;
@property (nonatomic, assign) NSUInteger dashletUid;

@property (nonatomic, strong) NSMutableArray* dashlets;


@property (nonatomic, strong) UITableView* tableView;



- (instancetype)initWithDashletUid: (NSUInteger)dashletUid forSelectionType: (JPDashletType)type;

@end
