//
//  iPadProgramCoursesTableViewCell.m
//  Uniq
//
//  Created by Si Te Feng on 2014-06-01.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPProgramCoursesTableViewCell.h"

#import "JPFont.h"
#import "JPStyle.h"

@interface JPProgramCoursesTableViewCell() //Also used as Authors Cell




@end

const NSUInteger kIconLabelTag = 341;

@implementation JPProgramCoursesTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        self.courseCodeLabel= [[UILabel alloc] initWithFrame:CGRectMake(85, 12, 450, 30)];
        self.courseCodeLabel.font = [UIFont fontWithName:[JPFont defaultItalicFont] size:20];
        self.courseCodeLabel.textColor = [JPStyle colorWithName:@"darkRed"];
        
        [self addSubview:self.courseCodeLabel];
        
        
        self.courseNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 36, 450, 30)];
        self.courseNameLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
        
        [self addSubview:self.courseNameLabel];
        
        
        self.iconView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
        self.iconView.backgroundColor = [JPStyle rainbowColorWithIndex:(arc4random()%6)];
        
        
        UILabel* iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.iconView.frame.size.width, self.iconView.frame.size.height)];
        iconLabel.textColor = [UIColor whiteColor];
        iconLabel.tag = kIconLabelTag;
        iconLabel.font = [UIFont fontWithName:[JPFont defaultMediumFont] size:30];
        iconLabel.textAlignment = NSTextAlignmentCenter;
        iconLabel.text = [[self.courseCodeLabel.text substringToIndex:1] uppercaseString];
        


        [self.iconView addSubview:iconLabel];
        [self addSubview:self.iconView];

        
        self.courseDescriptionView = [[UITextView alloc] initWithFrame:CGRectMake(25, 70, 410, 115)];
        self.courseDescriptionView.backgroundColor = [UIColor clearColor];
        self.courseDescriptionView.editable = NO;
        self.courseDescriptionView.selectable = NO;
        self.courseDescriptionView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.courseDescriptionView.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
        
        [self addSubview:self.courseDescriptionView]; 
        
        
        self.clipsToBounds = YES;
        
        
    }
    return self;
}




- (void)setCourseCode:(NSString *)courseCode
{
    _courseCode = courseCode;
    
    self.courseCodeLabel.text = courseCode;
    
    UILabel* iconLabel = (UILabel*)[self.iconView viewWithTag:kIconLabelTag];
    
    iconLabel.text = [[courseCode substringToIndex:1] uppercaseString];

    self.iconView.backgroundColor = [JPStyle colorWithLetter: iconLabel.text];
    
}




- (void)setDeviceType:(UIUserInterfaceIdiom)deviceType
{
    if(deviceType == UIUserInterfaceIdiomPhone)
    {
        self.courseDescriptionView.frame = CGRectMake(5, 70, kiPhoneWidthPortrait-10, 115);
        self.courseDescriptionView.font = [UIFont fontWithName:[JPFont defaultThinFont] size:14];
        self.courseCodeLabel.frame = CGRectMake(self.courseCodeLabel.frame.origin.x, self.courseCodeLabel.frame.origin.y, 270, 30);
        self.courseNameLabel.frame = CGRectMake(self.courseNameLabel.frame.origin.x, self.courseNameLabel.frame.origin.y, 270, 30);
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}









@end



