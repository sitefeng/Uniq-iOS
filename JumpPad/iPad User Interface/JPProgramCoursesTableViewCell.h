//
//  iPadProgramCoursesTableViewCell.h
//  Uniq
//
//  Created by Si Te Feng on 2014-06-01.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoscrollLabel.h"

@interface JPProgramCoursesTableViewCell : UITableViewCell
{
    
    
    
}


@property (nonatomic, assign) UIUserInterfaceIdiom deviceType;

@property (nonatomic, strong) NSString* courseCode; // first row
@property (nonatomic, strong) NSString* courseName; //second row
@property (nonatomic, strong) UITextView* courseDescriptionView;  //Third element


@property (nonatomic, strong) UILabel* courseCodeLabel; //Automatically set
@property (nonatomic, strong) AutoScrollLabel* courseNameLabel;
@property (nonatomic, strong) UIView* iconView; //Automatically set




@end
