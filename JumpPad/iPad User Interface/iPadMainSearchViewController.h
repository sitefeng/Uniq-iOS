//
//  JumpPadMainSearchViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-04-29.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iPadSearchResultsView;
@interface iPadMainSearchViewController : UIViewController <UISearchBarDelegate>
{
    NSString*     _queryString;
}




@property (nonatomic, strong) UISearchBar* searchBar;

@property (nonatomic, strong) iPadSearchResultsView* resultView;


@end
