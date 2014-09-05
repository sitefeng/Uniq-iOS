//
//  iPhFacProgSelectViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPDataRequest.h"


@interface iPhFacProgSelectViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, JPDataRequestDelegate>
{
    NSManagedObjectContext* context;
    JPDataRequest*  _dataRequest;
}


@property (nonatomic, assign) JPDashletType type;

@property (nonatomic, assign) NSString* itemId;


@property (nonatomic, strong) NSMutableArray* dashlets;


@property (nonatomic, strong) UITableView* tableView;



- (instancetype)initWithItemId: (NSString*)itemId forSelectionType: (JPDashletType)type;

@end
