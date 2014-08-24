//
//  iPadHomeMarkTableViewCell.m
//  Uniq
//
//  Created by Si Te Feng on 6/23/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadHomeMarkTableViewCell.h"

#import "LDProgressView.h"
#import "JPFont.h"
#import "JPImageRetriever.h"

@interface iPadHomeMarkTableViewCell()

@property (nonatomic, strong) LDProgressView* progressBar;
@property (nonatomic, strong) UILabel* percentageLabel;
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) UILabel* titleLabel;

//Editing Mode
@property (nonatomic, strong) UITextField* titleField;
@property (nonatomic, strong) UISegmentedControl* levelSegControl;
@property (nonatomic, strong) UITextField* markField;
@property (nonatomic, strong) UIButton* deleteButton;

@property (nonatomic, strong) UILabel* addLabel;

@end

@implementation iPadHomeMarkTableViewCell

@synthesize imageView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _isEditing = NO;
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30,(44-35)/2.0, 35, 35)];
        self.imageView.image = [JPImageRetriever courseImageWithCourseName:nil];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 8, 250, 28)];
        self.titleLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:23];
        [self addSubview:self.titleLabel];
        
        
        self.progressBar =  [[LDProgressView alloc] initWithFrame:CGRectMake(350, 14, 300, 20)];
        self.progressBar.tintColor = [JPStyle colorWithName:@"blue"];
        self.progressBar.flat = @true;
        self.progressBar.animate = @false;
        self.progressBar.type = LDProgressStripes;
        self.progressBar.showText = @false;
        
        [self addSubview:self.progressBar];
        
        
        self.percentageLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.progressBar.frame) + 10, 0, 60, 44)];
        self.percentageLabel.textAlignment = NSTextAlignmentRight;
        self.percentageLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:28];
        [self addSubview:self.percentageLabel];
        
        
        _staticPercentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.percentageLabel.frame), self.percentageLabel.frame.origin.y, 63, self.percentageLabel.frame.size.height)];
        _staticPercentLabel.font = self.percentageLabel.font;
        _staticPercentLabel.text = @"%";
        
        [self addSubview:_staticPercentLabel];
        
    }
    return self;
}


#pragma mark - Changing Cell Modes

- (void)addNewCourseMode
{
    self.titleLabel.hidden = YES;
    self.imageView.hidden = YES;
    self.progressBar.hidden = YES;
    self.percentageLabel.hidden = YES;
    _staticPercentLabel.hidden = YES;
    
    if(!self.addLabel)
    {
        self.addLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kiPadWidthPortrait, 44)];
        self.addLabel.textAlignment = NSTextAlignmentCenter;
        self.addLabel.font = self.percentageLabel.font;
        self.addLabel.text = @"+ Add New Course";
        [self addSubview:self.addLabel];
    }
    
}


- (void)editMode
{
    self.percentageLabel.hidden = YES;
    
    if ([self.cellType isEqual:@"course"])
    {
        self.titleLabel.hidden = YES;
        
        if(!self.titleField)
        {
            self.titleField = [[UITextField alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, 150, self.titleLabel.frame.size.height)];
            self.titleField.font = self.titleLabel.font;
            self.titleField.autocorrectionType = UITextAutocorrectionTypeNo;
            [self.titleField setBorderStyle:UITextBorderStyleNone];
            self.titleField.clearsOnBeginEditing = YES;
            self.titleField.delegate = self.tableViewController;
            self.titleField.tag = 1;
            [self addSubview:self.titleField];
        }
        self.titleField.hidden = NO;
        
        if(!self.levelSegControl)
        {
            self.levelSegControl = [[UISegmentedControl alloc] initWithItems:@[@"4C",@"4M",@"4U"]];
            self.levelSegControl.frame = CGRectMake(CGRectGetMaxX(self.titleField.frame) + 10, 5, 200, 44-10);

            [self.levelSegControl setApportionsSegmentWidthsByContent:YES];
            [self addSubview:self.levelSegControl];
        }
        self.levelSegControl.hidden = NO;
        
        self.progressBar.frame = CGRectMake(CGRectGetMaxX(self.levelSegControl.frame) + 10, self.progressBar.frame.origin.y, 200, self.progressBar.frame.size.height);
    }
    
    if(!self.markField)
    {
        self.markField = [[UITextField alloc] initWithFrame:self.percentageLabel.frame];
        self.markField.font = self.percentageLabel.font;
        self.markField.clearsOnBeginEditing =YES;
        self.markField.textAlignment = NSTextAlignmentRight;
        self.markField.keyboardType = UIKeyboardTypeDecimalPad;
        self.markField.borderStyle = UITextBorderStyleNone;
        self.markField.delegate = self.tableViewController;
        self.markField.tag=2;
        
        UILabel* percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.markField.frame.size.width + 5, self.markField.frame.origin.y, 60, self.markField.frame.size.height)];
        percentLabel.font = self.markField.font;
        percentLabel.text = @"%";
        [self.markField addSubview:percentLabel];
        [self addSubview:self.markField];
    }
    
    self.markField.hidden = NO;
    
    if([self.cellType isEqual:@"sat"])
        _staticPercentLabel.hidden = YES;
    else
        _staticPercentLabel.hidden = NO;
    
}



#pragma mark - Setters and Getters
- (void)setCoursePercentage:(float)coursePercentage
{
    _coursePercentage = coursePercentage;
    
    if([self.cellType isEqual:@"course"])
    {
        self.percentageLabel.text = [NSString stringWithFormat:@"%.01f", coursePercentage];
        self.progressBar.progress = coursePercentage/100.0f;
    }
    else if([self.cellType isEqual:@"sat"])
    {
        self.percentageLabel.text = [NSString stringWithFormat:@"%.00f", coursePercentage];
        self.progressBar.progress = coursePercentage/800.0f;
    }
    
    if(self.markField)
    {
        if([self.cellType isEqual:@"course"])
            self.markField.text = [NSString stringWithFormat:@"%.01f", coursePercentage];
        else if([self.cellType isEqual:@"sat"])
            self.markField.text = [NSString stringWithFormat:@"%.0f", coursePercentage];
    }
    
}



- (void)setCourseTitle:(NSString *)courseTitle
{
    _courseTitle = courseTitle;
    
    self.titleLabel.text = courseTitle;
    
    if(self.courseLevel)
    {
        self.titleLabel.text = [NSString stringWithFormat:@"%@ %@", courseTitle, self.courseLevel];
    }
    
    self.imageView.image = [JPImageRetriever courseImageWithCourseName:courseTitle];
    
    if(self.titleField)
    {
        self.titleField.text = courseTitle;
    }
    
}

- (void)setCourseLevel:(NSString *)courseLevel
{
    _courseLevel = courseLevel;
    
    if(![courseLevel isEqual:@"4U"] && ![courseLevel isEqual:@"4M"] && ![courseLevel isEqual:@"4C"])
    {
        return;
    }
    
    if(self.courseTitle!=nil && ![self.courseTitle isEqual: @""])
    {
        self.titleLabel.text = [NSString stringWithFormat:@"%@ %@", self.courseTitle, self.courseLevel];
    }
    
    if(self.levelSegControl)
    {
        if([courseLevel isEqual:@"4C"])
        {
            self.levelSegControl.selectedSegmentIndex = 0;
        }
        else if([courseLevel isEqual:@"4M"])
        {
            self.levelSegControl.selectedSegmentIndex = 1;
        }
        else if([courseLevel isEqual:@"4U"])
        {
            self.levelSegControl.selectedSegmentIndex = 2;
        }
    }
    
}


- (void)setCellType:(NSString *)cellType
{
    _cellType = cellType;
    
    if([cellType isEqual:@"sat"] || [cellType isEqual:@"course"])
    {
        _cellType = cellType;
    }
    else
    {
        _cellType = @"course";
    }
    if([cellType isEqual:@"course"])
    {
        self.percentageLabel.frame = CGRectMake(self.percentageLabel.frame.origin.x, self.percentageLabel.frame.origin.y, 60, self.percentageLabel.frame.size.height);
        _staticPercentLabel.hidden = NO;
    }
    else if([cellType isEqual:@"sat"])
    {
        self.percentageLabel.frame = CGRectMake(self.percentageLabel.frame.origin.x, self.percentageLabel.frame.origin.y, 60, self.percentageLabel.frame.size.height);
        _staticPercentLabel.hidden = YES;
        self.percentageLabel.text = [NSString stringWithFormat:@"%.00f", self.coursePercentage];
    }
    
    
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse
{
    self.titleLabel.hidden = NO;
    self.titleLabel.text = @"";
    self.imageView.hidden = NO;
    self.progressBar.hidden = NO;
    self.progressBar.progress = 0;
    self.progressBar.frame = CGRectMake(350, 10, 300, 20);
    self.percentageLabel.hidden = NO;
    self.percentageLabel.text = @"";
    _staticPercentLabel.hidden = NO;
    self.courseLevel = @"";
    
    [self.titleField removeFromSuperview];
    self.titleField = nil;
    [self.levelSegControl removeFromSuperview];
    self.levelSegControl = nil;
    [self.markField removeFromSuperview];
    self.markField = nil;
    [self.addLabel removeFromSuperview];
    self.addLabel = nil;
}



@end
