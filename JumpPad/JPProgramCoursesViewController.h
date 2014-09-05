//
//  iPadProgramCoursesViewController.h
//  Uniq
//
//  Created by Si Te Feng on 2014-06-01.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"


@interface JPProgramCoursesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
    NSIndexPath* _selectedIndexPath;
    
    UIUserInterfaceIdiom  _deviceType;
}


@property (nonatomic, strong) NSString* programTerm;
@property (nonatomic, strong) Program* program;



@property (nonatomic, strong) NSMutableArray* coursesToDisplay;//ProgramCourses

@property (nonatomic, strong) UITableView* tableView;



@end
