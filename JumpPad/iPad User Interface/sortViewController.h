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
{
    NSArray* _sortOptions;
    
    
    
}


@property (nonatomic, weak) id<JPSortDelegate> delegate;

@property (nonatomic, assign) NSInteger sortType;

@end


@protocol JPSortDelegate <NSObject>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end