//
//  iPadProgramCoursesTableViewCell.h
//  Uniq
//
//  Created by Si Te Feng on 2014-06-01.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPadProgramCoursesTableViewCell : UITableViewCell
{
    
    
    
}



@property (nonatomic, strong) NSString* courseCode; // first row
@property (nonatomic, strong) UILabel* courseNameLabel;  //second row
@property (nonatomic, strong) UITextView* courseDescriptionView;  //Third element


@property (nonatomic, strong) UILabel* courseCodeLabel; //Automatically set
@property (nonatomic, strong) UIView* iconView; //Automatically set




@end
