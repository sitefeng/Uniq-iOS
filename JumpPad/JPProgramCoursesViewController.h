//
//  iPadProgramCoursesViewController.h
//  Uniq
//
//  Created by Si Te Feng on 2014-06-01.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JPProgramCoursesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
    NSIndexPath* _selectedIndexPath;
}



@property (nonatomic, assign) NSUInteger coursesYear;//1,2,3,4

@property (nonatomic, strong) NSSet* programCourses;



@property (nonatomic, strong) NSMutableArray* coursesToDisplay;//ProgramCourses

@property (nonatomic, strong) UITableView* tableView;



@end
