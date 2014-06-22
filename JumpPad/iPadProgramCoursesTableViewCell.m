//
//  iPadProgramCoursesTableViewCell.m
//  Uniq
//
//  Created by Si Te Feng on 2014-06-01.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramCoursesTableViewCell.h"

#import "JPFont.h"
#import "JPStyle.h"

@interface iPadProgramCoursesTableViewCell()




@end

const NSUInteger kIconLabelTag = 341;

@implementation iPadProgramCoursesTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        
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
        
//        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
//        iconLabel.transform = transform;

        [self.iconView addSubview:iconLabel];
        [self addSubview:self.iconView];
        
        CGSize contentSize = self.contentView.frame.size;
        
        self.courseDescriptionView = [[UITextView alloc] initWithFrame:CGRectMake(25, 70, contentSize.width -10, 115)];
        self.courseDescriptionView.backgroundColor = [UIColor clearColor];
        self.courseDescriptionView.editable = NO;
        self.courseDescriptionView.selectable = NO;
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











- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
 
}









@end



