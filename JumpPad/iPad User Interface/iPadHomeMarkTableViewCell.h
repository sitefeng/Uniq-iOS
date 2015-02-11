//
//  iPadHomeMarkTableViewCell.h
//  Uniq
//
//  Created by Si Te Feng on 6/23/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPadMainHomeViewController.h"

@interface iPadHomeMarkTableViewCell : UITableViewCell
{
    BOOL   _isEditing;
    
    UILabel* _staticPercentLabel;
    
}

@property (nonatomic, weak) iPadMainHomeViewController* tableViewController;


//Type
@property (nonatomic, strong) NSString* cellType;

//Display Mode
@property (nonatomic, assign) float coursePercentage;
@property (nonatomic, strong) NSString* courseTitle;
@property (nonatomic, strong) NSString* courseLevel;

@property (nonatomic, strong, readonly) UILabel* titleLabel;

@property (nonatomic, strong, readonly) UIImageView* imageView; //Auto set
@property (nonatomic, strong, readonly) LDProgressView* progressBar;
@property (nonatomic, strong, readonly) UILabel* percentageLabel;


//Editing Mode
@property (nonatomic, strong, readonly) UITextField* titleField;
@property (nonatomic, strong, readonly) UISegmentedControl* levelSegControl;
@property (nonatomic, strong, readonly) UITextField* markField;


//New Course Mode
@property (nonatomic, strong, readonly) UILabel* addLabel;

- (void)addNewCourseMode;
- (void)editMode;



@end
