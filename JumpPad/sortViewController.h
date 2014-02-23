//
//  sortViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2/23/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JPSortDelegate;

@interface sortViewController : UITableViewController


@property (nonatomic, weak) id<JPSortDelegate> delegate;


@end


@protocol JPSortDelegate <NSObject>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end