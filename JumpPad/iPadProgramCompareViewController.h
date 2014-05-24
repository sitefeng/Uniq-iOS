//
//  iPadProgramCompareViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Program, iPadMainCollectionViewCell;
@interface iPadProgramCompareViewController : UIViewController <UISearchBarDelegate>
{
    iPadMainCollectionViewCell* _squareView1;
    iPadMainCollectionViewCell* _squareView2;
    
    
    UILabel*    _square1Label;
    UILabel*    _square2Label;
    
    
    iPadMainCollectionViewCell* _compSquareView;
    
    UISearchBar*   _searchBar;
    
}



@property (nonatomic, assign) NSUInteger dashletUid;
@property (nonatomic, strong) Program* program;


@property (nonatomic, strong) Program* compProgram;





- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program;



@end
