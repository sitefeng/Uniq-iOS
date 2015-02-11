//
//  iPadSearchBarView.h
//  JumpPad
//
//  Created by Si Te Feng on 2/22/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol JPSearchBarDelegate;


@interface iPadSearchBarView : UIView <UISearchBarDelegate>



@property (nonatomic, strong) UISearchBar* searchBar;
@property (nonatomic, strong) UIButton* sortButton;

@property (nonatomic, weak) id<JPSearchBarDelegate> delegate;



@end




@protocol JPSearchBarDelegate <UISearchBarDelegate>


- (void)sortButtonPressed: (id)sender;


@end