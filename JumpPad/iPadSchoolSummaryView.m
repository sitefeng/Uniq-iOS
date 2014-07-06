//
//  iPadSchoolSummaryView.m
//  Uniq
//
//  Created by Si Te Feng on 7/3/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadSchoolSummaryView.h"
#import "JPFont.h"
#import "JPLocation.h"
#import "JPGlobal.h"
#import "School.h"
#import "Faculty.h"
#import "SchoolLocation.h"

static const NSInteger kLabelConst =321;

@implementation iPadSchoolSummaryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        _readyToCalculateDistance = false;
        _itemType = -1;
        
        self.summary = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 200, 35)];
        self.summary.textColor = [UIColor whiteColor];
        
        self.summary.font = [UIFont fontWithName:[JPFont defaultLightFont] size:20];
        self.summary.text = @"SUMMARY";
        
        
        NSArray* iconImageNames = [NSMutableArray arrayWithObjects:@"SStudents",@"SLocation",@"SAlumni",@"SDistance",@"SPrograms",@"SFunding", nil];
        
        const int horizDist =200;
        const int vertDist = 40;
        
        for(int i=0; i<3; i++)
        {
            for(int j=0; j<2; j++)
            {
                UIImageView* view = [[UIImageView alloc] initWithFrame:CGRectMake(15+ horizDist*j, 65+ vertDist*i, 30, 30)];
                view.image = [UIImage imageNamed:iconImageNames[i*2+j]];
                [self addSubview:view];
                
                UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(50+ horizDist*j, 65+vertDist*i, 160, 30)];
                label.tag = j*10 + i + kLabelConst;
                label.font = [UIFont fontWithName:[JPFont defaultLightFont] size:15];
                label.textColor = [UIColor whiteColor];
                label.text = [self labelTextForRow:i column:j];
                [self addSubview:label];
                
            }
        }
        
        float iconHeight = 210;
        
        _favoriteButton = [[UIButton alloc] initWithFrame:CGRectMake(30, iconHeight, 54, 54)];
        [_favoriteButton setImage:[UIImage imageNamed:@"favoriteIcon"] forState:UIControlStateNormal];
        [_favoriteButton setImage:[UIImage imageNamed:@"favoriteIconSelected3"] forState:UIControlStateHighlighted];
        [_favoriteButton setImage:[UIImage imageNamed:@"favoriteIconSelected"] forState:UIControlStateSelected];
        _favoriteButton.selected = NO;
        if(self.isFavorited)
            _favoriteButton.selected = YES;
        
        [_favoriteButton addTarget:self action:@selector(favoriteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton* website = [[UIButton alloc] initWithFrame:CGRectMake(30+ 87, iconHeight, 54, 54)];
        [website setImage:[UIImage imageNamed:@"safariIcon"] forState:UIControlStateNormal];
        [website addTarget:self action:@selector(websiteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton* twitter = [[UIButton alloc] initWithFrame:CGRectMake(30+ 174, iconHeight, 54, 54)];
        [twitter setImage:[UIImage imageNamed:@"twitterIcon"] forState:UIControlStateNormal];
        [twitter addTarget:self action:@selector(twitterButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton* facebook = [[UIButton alloc] initWithFrame:CGRectMake(30+261, iconHeight, 54, 54)];
        [facebook setImage:[UIImage imageNamed:@"facebookIcon"] forState:UIControlStateNormal];
        [facebook addTarget:self action:@selector(facebookButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:self.summary];
        [self addSubview:_favoriteButton];
        [self addSubview:twitter];
        [self addSubview:website];
        [self addSubview:facebook];
        
    }
    return self;

}




- (NSString*)labelTextForRow: (NSInteger)row column: (NSInteger)col
{
    NSUInteger num = col*10 + row;
    
    switch (num)
    {
        case 0:
        {
            if(_itemType == JPDashletTypeSchool)
                return [NSString stringWithFormat:@"%@ Students", self.school.population];
            else
                return [NSString stringWithFormat:@"%@ Students", self.faculty.population];
        }
        case 1:
        {
            if(_itemType == JPDashletTypeSchool)
                return [NSString stringWithFormat:@"%@ Alumni", self.school.alumniNumber];
            else //faculty
                return [NSString stringWithFormat:@"%@ Alumni", self.faculty.alumniNumber];
            
        }
        case 2:
        {
            if(_itemType == JPDashletTypeSchool)
                return [NSString stringWithFormat:@"%@ Programs", self.school.numPrograms];
            else //faculty
                return [NSString stringWithFormat:@"%@ Programs", self.faculty.numPrograms];
        }
        case 10:
        {
            NSMutableString* location = [NSMutableString string];
            
            if(self.location.cityName)
            {
                location = [NSMutableString stringWithFormat:@"%@, ",self.location.cityName];
            }
            else
            {
                location = [@"Unknown, " mutableCopy];
            }
            if(self.location.provinceName)
            {
                [location appendString:self.location.provinceName];
            }
            else
            {
                [location appendString:@"--"];
            }
            
            return location;
        }
        case 11:
        {
            return @"--- kms Away";
        }
        case 12:
        {
            if(_itemType == JPDashletTypeSchool)
                return [NSString stringWithFormat:@"$%@ Funding", self.school.totalFunding];
            else //faculty
                return [NSString stringWithFormat:@"$%@ Funding", self.faculty.totalFunding];
        }
            
        default:
            return @"";
    }
    return @"";
}


- (void)reloadLabelInfo
{
    for(int i=0; i<3; i++)
    {
        for(int j=0; j<2; j++)
        {
            UILabel* label = (UILabel*)[self viewWithTag:j*10 + i + kLabelConst];
            
            label.text = [self labelTextForRow:i column:j];
        }
        
    }
}




- (void)twitterButtonTapped: (UIButton*)sender
{
    [self.delegate twitterButtonTapped];
}


- (void)websiteButtonTapped: (UIButton*)sender
{
    [self.delegate websiteButtonTapped];
}


- (void)facebookButtonTapped: (UIButton*)sender
{
    [self.delegate facebookButtonTapped];
}



- (void)favoriteButtonTapped: (UIButton*)sender
{
    if(sender.selected == NO)
    {
        [self.delegate favoriteButtonSelected:YES];
        self.isFavorited = YES;
    }
    else //Deselect
    {
        [self.delegate favoriteButtonSelected:NO];
        self.isFavorited = NO;
    }
    
}


#pragma mark - Setter Methods

- (void)setIsFavorited:(BOOL)isFavorited
{
    _isFavorited = isFavorited;
    _favoriteButton.selected = isFavorited;
}

- (void)setSchool:(School *)school
{
    _school = school;
    CGPoint coord = CGPointMake([school.location.lattitude floatValue], [school.location.longitude floatValue]);
    self.location = [[JPLocation alloc] initWithCooridinates:coord city:school.location.city province:school.location.province];
    _itemType = JPDashletTypeSchool;
    [self reloadLabelInfo];
}

- (void)setFaculty:(Faculty *)faculty
{
    _faculty = faculty;
    _school = faculty.school;
    CGPoint coord = CGPointMake([_school.location.lattitude floatValue], [_school.location.longitude floatValue]);
    self.location = [[JPLocation alloc] initWithCooridinates:coord city:_school.location.city province:_school.location.province];
    _itemType = JPDashletTypeFaculty;
    [self reloadLabelInfo];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing Horizontal line
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context, 2);
    CGPoint dividerLine[] = {jpp(20, 50),jpp(384-20, 50)};
    
    CGContextAddLines(context, dividerLine, 2);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context, 2);
    CGPoint dividerLineVert[] = {jpp(195, 50),jpp(195, 180)};
    
    CGContextAddLines(context, dividerLineVert, 2);
    CGContextDrawPath(context, kCGPathStroke);
    
}









@end
