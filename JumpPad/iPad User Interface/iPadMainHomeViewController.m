//
//  iPadMainHomeViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

//#import <CoreLocation/CoreLocation.h>

#import "iPadMainHomeViewController.h"

#import "JPFont.h"
#import "JPStyle.h"

#import "Uniq-Swift.h"
#import "UniqAppDelegate.h"

#import "iPadHomeMarkTableViewCell.h"
#import "User.h"
#import "HighschoolCourse.h"
#import "JPUserLocator.h"
#import "JPHighschoolCourse.h"


@interface iPadMainHomeViewController ()
{
    NSArray* _courseLevelStrings;
}



@end

NSString* const reuseIdentifier = @"reuseIdentifier";


@implementation iPadMainHomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _isEditing = NO;
    _addedNewCourse = NO;
    _coursesToSave = [NSMutableArray array];
    _courseCellsToSave = [NSMutableArray array];
    _userLocated = NO;
    
    _courseLevelStrings = @[@"4C", @"4M", @"4U"];
    
    UniqAppDelegate* app = [[UIApplication sharedApplication] delegate];
    context = [app managedObjectContext];
    
    pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    
    [self loadInfoFromCoreData];
    
    //Initializing UI elements
    self.profileBanner = [[iPadHomeProfileBanner alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+kiPadNavigationBarHeight, kiPadWidthPortrait, 300)];
    self.profileBanner.clipsToBounds = YES;
    
    NSData* profileImageData = [_user valueForKey:@"profileImage"];
    UIImage* profileImage = [UIImage imageWithData:profileImageData];
    if(profileImage)
        self.profileBanner.userImage = profileImage;
    else
        self.profileBanner.userImage = [UIImage imageNamed:@"profileIcon"];
    
    self.profileBanner.userNameLabel.text = _user.name;
    self.profileBanner.userLocationLabel.text = _user.locationString;
    self.profileBanner.userAverage = 0.0f;
    [self reloadUserOverallAverage];
    
    self.profileBanner.homeViewController = self;
    [self.view addSubview:self.profileBanner];
    
    
    //Settings Button
    UIButton* settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(kiPadWidthPortrait - 65, CGRectGetMaxY(self.profileBanner.frame)-65,  44,  44)];
    [settingsButton setImage:[UIImage imageNamed:@"settingsIcon"] forState:UIControlStateNormal];
    [settingsButton setImage:[[UIImage imageNamed:@"settingsIcon"] imageWithAlpha:0.5] forState:UIControlStateHighlighted];
    [settingsButton addTarget:self action:@selector(settingsButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingsButton];
    
    UILabel* settingsLabel = [[UILabel alloc] initWithFrame:CGRectMake(-20, settingsButton.frame.size.height, settingsButton.frame.size.width+40, 20)];
    settingsLabel.textAlignment = NSTextAlignmentCenter;
    settingsLabel.font = [JPFont fontWithName:[JPFont defaultFont] size:12];
    settingsLabel.text = @"App Settings";
    [settingsButton addSubview:settingsLabel];

    //tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.profileBanner.frame), kiPadWidthPortrait, kiPadHeightPortrait - CGRectGetMaxY(self.profileBanner.frame)-kiPadTabBarHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[iPadHomeMarkTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //Prevent transparent tab bar
    self.tabBarController.tabBar.translucent = YES;
}

- (void)reloadUserOverallAverage
{
    //Overall course average
    float accumulator = 0;
    for(HighschoolCourse* course in _highschoolCourses)
    {
        float courseMark = [course.courseMark floatValue];
        accumulator += courseMark;
    }
    
    float userAverage = accumulator / [_highschoolCourses count];
    _user.currentAvg = [NSNumber numberWithFloat:userAverage];
    self.profileBanner.userAverage = [_user.currentAvg floatValue];
}


- (float)overallSATAverage
{
    float average = 0;
    average += [_user.satReading floatValue];
    average += [_user.satMath floatValue];
    average += [_user.satGrammar floatValue];
    
    return average;
}


- (void)loadInfoFromCoreData
{
    //Making Sure One and Only one user exists
    NSFetchRequest* userReq = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    
    NSError *error = nil;
    NSArray* userResponse= [context executeFetchRequest:userReq error:&error];
    if(error)
    {
        NSLog(@"user error");
    }
    if(!userResponse||[userResponse count] != 1)
    {
        for(User* user in userResponse)
        {
            [context deleteObject:user];
        }
        
        NSEntityDescription* userDesc = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
        User* newUser = (User*)[[NSManagedObject alloc] initWithEntity: userDesc insertIntoManagedObjectContext:context];
        newUser.satMath    = @0;
        newUser.satReading = @0;
        newUser.satGrammar = @0;
        newUser.name = @"Nickname";
        _user = newUser;
        [context insertObject:newUser];
    }
    else
    {
        _user = [userResponse firstObject];
    }
    
    
    //Retrieve User Course Data
    NSFetchRequest* courseReq = [[NSFetchRequest alloc] initWithEntityName:@"HighschoolCourse"];
    courseReq.predicate = [NSPredicate predicateWithFormat:@"user != %@", [NSNull null]];
    
    error = nil;
    _highschoolCourses = [[context executeFetchRequest:courseReq error:&error] mutableCopy];
    
    if(error)
    {
        NSLog(@"courses error");
    }

}



- (void)settingsButtonTapped: (UIButton*)button
{
    iPadSettingsSplitViewController* settingsVC = [[iPadSettingsSplitViewController alloc] initWithNibName:nil bundle:nil];
    
    UniqAppDelegate* app = (UniqAppDelegate*)[[UIApplication sharedApplication] delegate];
    UIViewController* currentController = app.window.rootViewController;
    
    settingsVC.originalTabBarController = (UITabBarController*)currentController;
    
    app.window.rootViewController = settingsVC;
    app.window.rootViewController = currentController;

    [UIView transitionWithView:self.navigationController.view.window duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        app.window.rootViewController = settingsVC;
    } completion:nil];
    
}




#pragma mark - Table View DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numCourses = 0;
    
    if(section==0)
    {
        numCourses = [_highschoolCourses count];
        
        numCourses = _isEditing ? numCourses+1 : numCourses;
    }
    else if(section==1)
    {
        numCourses = 3;
    }
    
    return numCourses;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    iPadHomeMarkTableViewCell* cell  = [[iPadHomeMarkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
   
    cell.tableViewController = self;
    
    if(indexPath.section == 0)
    {
        cell.cellType = @"course";
        
        if(_isEditing)
        {
            if(indexPath.row == [_highschoolCourses count])
            {
                [cell addNewCourseMode];
            }
            else
            {
                [cell editMode];
                
                if(indexPath.row < [_highschoolCourses count])
                {
                    HighschoolCourse* course = _highschoolCourses[indexPath.row];
                    cell.courseTitle = [course.courseCode copy];
                    cell.courseLevel = [course.courseLevel copy];
                    cell.coursePercentage = [course.courseMark floatValue];
                }
                
                //Include the new course cell into array so values in the cell can later be stored
                if(_addedNewCourse)
                {
                    [_courseCellsToSave addObject:cell];
                    _addedNewCourse = NO;
                }
            }
            
        }
        else //not editing
        {
            HighschoolCourse* course = _highschoolCourses[indexPath.row];
            cell.courseTitle = [course.courseCode copy];
            cell.courseLevel = [course.courseLevel copy];
            cell.coursePercentage = [course.courseMark floatValue];
        }

        
    }
    else if(indexPath.section == 1)
    {
        cell.cellType = @"sat";
        
        if(_isEditing)
            [cell editMode];
        
        switch (indexPath.row) {
            case 0:
                cell.courseTitle = @"Reading";
                cell.coursePercentage = [_user.satReading floatValue];
                break;
            case 1:
                cell.courseTitle = @"Mathematics";
                cell.coursePercentage = [_user.satMath floatValue];
                break;
            case 2:
                cell.courseTitle = @"Grammar";
                cell.coursePercentage = [_user.satGrammar floatValue];
                break;
            default:
                break;
        }
        
        
        
    }

    
    return cell;
    
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section ==0)
    {
        return @"Highschool Courses Taking";
    }
    else if(section ==1)
    {
        float satAverage = [self overallSATAverage];
        return [NSString stringWithFormat:@"SAT Score (Total: %.00f/2400)", satAverage];
    }
    
    return @"";
}


- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if(section==0)
    {
        if([_highschoolCourses count] <= 1)
            return [@"                                         (Tap \"Edit\" on top right corner to add a new course)" uppercaseString];
        else
            return @"Only for senior level courses with course code recognized by the college/university";
    }
    else if(section == 1)
    {
        float satAverage = [self overallSATAverage];
        if(satAverage > (2307 + arc4random()%30))
            return [NSString stringWithFormat:@"WOW! Actually got %.00f on the SATs??? Congrats!!", satAverage];
        else
            return @"Exam is out of 800 for each section";
    }

    return @"";
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_isEditing && indexPath.section == 0 && indexPath.row != [_highschoolCourses count])
    {
        return YES;
    }
    
    return NO;
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == [_highschoolCourses count])
    {
        return YES;
    }
    
    return NO;
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //if add new course row is tapped
    if(_isEditing && indexPath.section==0 && indexPath.row == [_highschoolCourses count])
    {
        //Save Whatever is from before first
        [self saveCoursesFromTableView];
        [self saveSATsFromTableView];
        
        //Add a New Course Row
        _addedNewCourse = YES;

        HighschoolCourse* course = (HighschoolCourse*)[NSEntityDescription insertNewObjectForEntityForName:@"HighschoolCourse" inManagedObjectContext:context];
        
        course.courseCode = @"New Course";
        course.courseLevel = @"4C";
        course.courseMark = @0.0f;
        
        [_highschoolCourses addObject:course];
        [_coursesToSave addObject:course];
        
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        if(indexPath.section == 0)
        {
            HighschoolCourse* course = (HighschoolCourse*)[_highschoolCourses objectAtIndex:indexPath.row];
            [_highschoolCourses removeObject:course];
            
            if([_coursesToSave containsObject:course])
                [_coursesToSave removeObject:course];
            
            [_user removeCoursesObject:course];
            
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
        
    }
    
//    [self.tableView reloadData];
    
}



#pragma mark - UIBarButtonItem Callback Methods

- (IBAction)EditButtonPressed:(id)sender {
    
    UIBarButtonItem* editButton = (UIBarButtonItem*)sender;
    
    if([editButton.title isEqual:@"Edit"])
    {
        editButton.title = @"Save";
        _isEditing = YES;
        [self.profileBanner setEditing: YES];
    }
    else //is Save
    {
        editButton.title = @"Edit";
        _isEditing = NO;

        [self.profileBanner setEditing: NO];
        [self saveProfilePhoto];
        
        //Saving Name
        if([self.profileBanner.userNameLabel.text isEqual:@""]
        || [self.profileBanner.userNameLabel.text isEqual:@" "]
        || [self.profileBanner.userNameLabel.text isEqual:@"  "]) {
            _user.name = @"Nickname";
            self.profileBanner.userNameLabel.text = _user.name;
        }
        else {
            _user.name = self.profileBanner.userNameLabel.text;
        }
        
        //Saving Course Marks
        [self saveCoursesFromTableView];
        [self saveSATsFromTableView];
        
    }
    
    [self.tableView reloadData];
    
}


- (void)saveCoursesFromTableView
{
    for(HighschoolCourse* course in _coursesToSave)
    {
        //Getting Cell Information and Store in Core Data
        iPadHomeMarkTableViewCell* cell = [_courseCellsToSave objectAtIndex:[_coursesToSave indexOfObject:course]];
        NSInteger cellRow = [self.tableView indexPathForCell:cell].row;
        HighschoolCourse* highschoolCourseChanged = [_highschoolCourses objectAtIndex:cellRow];
        
        course.courseCode = [highschoolCourseChanged.courseCode copy];
        course.courseLevel = [highschoolCourseChanged.courseLevel copy];
        course.courseMark = [highschoolCourseChanged.courseMark copy];
        course.user = _user;
    }
    
    [_courseCellsToSave removeAllObjects];
    [_coursesToSave removeAllObjects];
    
    //Add changes to original array: Depricated: _highschoolCourses is now updated for every letter change in each cell
    //Checking the cell's content desn't work for hidden cells
//    for(unsigned long i = 0; i<[_highschoolCourses count]; i++)
//    {
//        HighschoolCourse* origCourse = _highschoolCourses[i];
//        iPadHomeMarkTableViewCell* cell = (iPadHomeMarkTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//        
//        origCourse.courseCode = cell.titleField.text;
//        origCourse.courseLevel = _courseLevelStrings[cell.levelSegControl.selectedSegmentIndex];
//        origCourse.courseMark = [NSNumber numberWithFloat:[cell.markField.text floatValue]];
//        
//        _highschoolCourses[i] = origCourse;
//    }
    
    [self reloadUserOverallAverage];
    
    NSError* error;
    [context save:&error];
    if(error)
    {
        NSLog(@"Save Error");
    }
    
}


- (void)saveSATsFromTableView
{
    //Saving SAT Scores
    iPadHomeMarkTableViewCell* satCell = (iPadHomeMarkTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    _user.satReading = [NSNumber numberWithFloat:[satCell.markField.text floatValue]];
    satCell = (iPadHomeMarkTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    _user.satMath = [NSNumber numberWithFloat:[satCell.markField.text floatValue]];
    satCell = (iPadHomeMarkTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    _user.satGrammar = [NSNumber numberWithFloat:[satCell.markField.text floatValue]];
}


#pragma mark - Cell TextField Delegate
- (void)cellValueDidChange: (iPadHomeMarkTableViewCell*)cell toValue: (id)newValue forField: (NSInteger)num;
{
    NSIndexPath* cellIndex = [self.tableView indexPathForCell:cell];
    
    if(cellIndex.section == 0)
    {
        HighschoolCourse* course = [_highschoolCourses objectAtIndex:cellIndex.row];
        if(num == 0)
            course.courseCode = newValue;
        else if(num == 1)
            course.courseLevel = newValue;
        else if(num == 2)
            course.courseMark = newValue;
    }
    else //sat
    {
        if(cellIndex.row == 0)
            _user.satReading = newValue;
        else if(cellIndex.row == 1)
            _user.satMath = newValue;
        else if(cellIndex.row == 2)
            _user.satGrammar = newValue;
    }
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:kKeyboardRetractAnimationSpeed animations:^{
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.profileBanner.frame), kiPadWidthPortrait, kiPadHeightPortrait - CGRectGetMaxY(self.profileBanner.frame)-kiPadKeyboardHeightPortrait);
    }];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:kKeyboardRetractAnimationSpeed animations:^{
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.profileBanner.frame), kiPadWidthPortrait, kiPadHeightPortrait - CGRectGetMaxY(self.profileBanner.frame)-kiPadTabBarHeight);
    }];
}


#pragma mark - Location Services

- (void)locationButtonPressed: (UIButton*)button
{
    if(_userLocated)
        [self.profileBanner stopAnimatingActivityIndicator];
    
    if(!_userLocator)
    {
        _userLocator = [[JPUserLocator alloc] initWithUser:_user];
        _userLocator.delegate = self;
        [_userLocator startLocating];
    }
}


- (void)userLocatedWithLocationName: (NSString*)name coordinates: (CLLocationCoordinate2D)coord
{
    if(name && ![name isEqual: @""])
        self.profileBanner.userLocationLabel.text = name;
//    _user.locationString = name;
//    _user.longitude = [NSNumber numberWithFloat:coord.longitude];
//    _user.latitude = [NSNumber numberWithFloat:coord.latitude];
    
    [context save:nil];
    
    NSLog(@"UserLocation: %@,%@,%@", _user.locationString, _user.longitude, _user.latitude);
    
    _userLocated = YES;
    [self.profileBanner stopAnimatingActivityIndicator];
}


- (BOOL)shouldSaveUserLocation
{
    return YES;
}



#pragma mark - Profile Icon Change

- (void)profileImageAddButtonPressed: (UIButton*)button
{
    UIActionSheet* actionSheet;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"Change Profile Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo Album",@"Camera", nil];
    else
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"Add Profile Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo Album", nil];

    
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}


- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) //camera
    {
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _popover = [[UIPopoverController alloc] initWithContentViewController:pickerController];
        pickerController.allowsEditing = YES;
        [_popover presentPopoverFromRect:self.profileBanner.userImageAddButton.frame inView:self.profileBanner permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    else if(buttonIndex == 1)
    {
        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerController.allowsEditing = YES;
        [self presentViewController:pickerController animated:YES completion:nil];
    }
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    self.profileBanner.userImage = image;
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        [self dismissViewControllerAnimated:YES completion:nil];
    else
        [_popover dismissPopoverAnimated:YES];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        [self dismissViewControllerAnimated:YES completion:nil];
    else
        [_popover dismissPopoverAnimated:YES];
}


- (void)saveProfilePhoto
{
    UIImage* profileImage = self.profileBanner.userImage;
    
    NSData* imageData = UIImagePNGRepresentation(profileImage);
    
    [_user setValue:imageData forKey:@"profileImage"];
    
    NSError* error = nil;
    [context save:&error];
    if(error)
        NSLog(@"Profile Photo Error");
    
}




@end
