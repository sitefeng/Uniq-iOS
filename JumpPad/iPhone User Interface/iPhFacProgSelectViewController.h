//
//  iPhFacProgSelectViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPDataRequest.h"


@interface iPhFacProgSelectViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSManagedObjectContext* context;
    
}


@property (nonatomic, assign) JPDashletType type;


@property (nonatomic, strong) NSString *schoolSlug;
@property (nonatomic, strong) NSString *facultySlug;

@property (nonatomic, strong) NSString *itemId;


@property (nonatomic, strong) NSMutableArray* dashlets;

@property (nonatomic, strong) UITableView* tableView;



- (instancetype)initWithItemId:(NSString*)itemId schoolSlug: (NSString *)schoolSlug facultySlug: (NSString *)facultySlug forSelectionType: (JPDashletType)type;

@end
