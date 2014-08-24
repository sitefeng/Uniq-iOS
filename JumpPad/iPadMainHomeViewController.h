//
//  iPadMainHomeViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPUserLocator.h"
#import <CoreLocation/CoreLocation.h>

@class iPadHomeProfileBanner, iPadHomeToolbarView, User;
@interface iPadMainHomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, JPUserLocatorDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSManagedObjectContext* context;
    UIImagePickerController* pickerController;
    UIPopoverController* _popover;

    BOOL             _isEditing;
    BOOL             _addedNewCourse;
    
    NSMutableArray*  _highschoolCourses; 
    User          *  _user;
    
    NSMutableArray*  _coursesToSave;
    NSMutableArray*  _courseCellsToSave;
    
    JPUserLocator *  _userLocator;
    BOOL             _userLocated; //temp
}



@property (nonatomic, strong) iPadHomeProfileBanner* profileBanner;
@property (nonatomic, strong) iPadHomeToolbarView* toolbar;
@property (nonatomic, strong) UITableView* tableView;



- (IBAction)EditButtonPressed:(id)sender;
- (void)locationButtonPressed: (UIButton*)button;

- (void)profileImageAddButtonPressed: (UIButton*)button;


@end
