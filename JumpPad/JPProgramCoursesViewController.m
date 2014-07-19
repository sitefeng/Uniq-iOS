//
//  iPadProgramCoursesViewController.m
//  Uniq
//
//  Created by Si Te Feng on 2014-06-01.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPProgramCoursesViewController.h"
#import "UniqAppDelegate.h"
#import "JPGlobal.h"
#import "JPProgramCoursesTableViewCell.h"
#import "ProgramCourse.h"


@interface JPProgramCoursesViewController ()

@end



NSString* const kCoursesCellIdentifier;

@implementation JPProgramCoursesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIBarButtonItem* dismissItem = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStyleDone target:self action:@selector(dismissViewController)];
        
        [self.navigationItem setLeftBarButtonItem:dismissItem animated:NO];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _deviceType = [[UIDevice currentDevice] userInterfaceIdiom];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _selectedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:1];
   
    self.title = [NSString stringWithFormat:@"%@ Courses",[JPGlobal schoolYearStringWithInteger:self.coursesYear]];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.parentViewController.view.bounds.size.width, self.parentViewController.view.bounds.size.height) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    
    
    self.coursesToDisplay = [NSMutableArray array];
    
    for(ProgramCourse* course in self.programCourses)
    {
        if([course.enrollmentYear integerValue] == self.coursesYear)
        {
            [self.coursesToDisplay addObject:course];
        }
        
    }
    
    [self.coursesToDisplay sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        ProgramCourse* course1 = (ProgramCourse*)obj1;
        ProgramCourse* course2 = (ProgramCourse*)obj2;
        
        if([course1.courseCode compare:course2.courseCode] == NSOrderedAscending)
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        else
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
    }];
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.coursesToDisplay count];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JPProgramCoursesTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:kCoursesCellIdentifier];
    
    if(!cell)
    {
        cell = [[JPProgramCoursesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCoursesCellIdentifier];
    }
    
    
    ProgramCourse* course = self.coursesToDisplay[indexPath.row];
    cell.deviceType = _deviceType;
    cell.courseCode = course.courseCode;
    cell.courseNameLabel.text = course.courseName;
    cell.courseDescriptionView.text = course.courseDescription;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(_selectedIndexPath.row != indexPath.row)
    {
        return 80.0f;
    }
    else
    {
        return 190;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_selectedIndexPath.row != indexPath.row)
        _selectedIndexPath = indexPath;
    else
        _selectedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:indexPath.section];
    
    [self.tableView reloadData];
}













- (void)dismissViewController
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
