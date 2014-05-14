//
//  iPadProgramSummaryView.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-08.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramSummaryView.h"
#import "Program.h"
#import "ProgramCourse.h"
#import "JPFont.h"
#import "JPLocation.h"

#import "JPGlobal.h"


@implementation iPadProgramSummaryView //for basic information on top in a program

- (id)initWithFrame:(CGRect)frame program: (Program*)program  location:(JPLocation*)location
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        self.program = program;
        
        self.location = location;
        _readyToCalculateDistance = false;
        
        
        self.summary = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 200, 35)];
        self.summary.textColor = [JPStyle colorWithHex:@"C7E8FF" alpha:1];
        self.summary.font = [UIFont fontWithName:[JPFont defaultBoldFont] size:20];
        self.summary.shadowColor = [UIColor yellowColor];
        self.summary.text = @"SUMMARY";
        
        
        //Icon images and labels;
        self.iconImages = [NSMutableArray array];
        self.iconLabels = [NSMutableArray array];
        
        const int horizDist =200;
        const int vertDist = 40;
        
        for(int i=0; i<3; i++)
        {
            for(int j=0; j<2; j++)
            {
            
                UIImageView* view = [[UIImageView alloc] initWithFrame:CGRectMake(15+ horizDist*j, 65+ vertDist*i, 30, 30)];
                view.image = [UIImage imageNamed:@"infoIcon"];
                [self.iconImages addObject:view];
                [self addSubview:view];
                
                UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(50+ horizDist*j, 65+vertDist*i, 160, 30)];
                label.font = [UIFont fontWithName:[JPFont defaultMediumFont] size:15];
                label.textColor = [UIColor whiteColor];
                label.shadowColor = [UIColor yellowColor];
                label.text = [[self labelTextForRow:i column:j] uppercaseString];
                [self addSubview:label];
            
            }
            
        }
        
        //*************************************
        
        UIImage* deadlineImg = [UIImage imageNamed:@"iOSCalendarIcon"];
        UIImageView* deadlineView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 190, 35, 35)];
        
        deadlineView.image = deadlineImg;
        
        UILabel* deadlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 187, 300, 40)];
        deadlineLabel.font = [UIFont fontWithName:[JPFont defaultItalicFont] size:19];
        deadlineLabel.textColor = [JPStyle colorWithHex:@"FFD6D9" alpha:1];
        
        
        NSString* monthString = [self.program.admissionDeadline substringToIndex:2];//@"02"
        
        NSString* month = [JPGlobal monthStringWithInt:[monthString intValue]];//@"Feb"
        NSString* date = [self.program.admissionDeadline substringFromIndex:3];
        
        deadlineLabel.text = [NSString stringWithFormat:@"Application Deadline: %@ %@", month, date];
        
        [self addSubview:deadlineView];
        [self addSubview:deadlineLabel];
        
        //**************************************
        
        UIButton* email = [[UIButton alloc] initWithFrame:CGRectMake(80, 240, 54, 54)];
        [email setImage:[UIImage imageNamed:@"iOSMailIcon"] forState:UIControlStateNormal];
        [email addTarget:self action:@selector(emailButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton* website = [[UIButton alloc] initWithFrame:CGRectMake(200-54/2.0, 240, 54, 54)];
        [website setImage:[UIImage imageNamed:@"iOSSafariIcon"] forState:UIControlStateNormal];
        [website addTarget:self action:@selector(websiteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton* facebook = [[UIButton alloc] initWithFrame:CGRectMake(2*(200-54/2.0)-80, 240, 54, 54)];
        [facebook setImage:[UIImage imageNamed:@"facebookIcon"] forState:UIControlStateNormal];
        [facebook addTarget:self action:@selector(facebookButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:email];
        [self addSubview:website];
        [self addSubview:facebook];
        
        [self addSubview:self.summary];
  
    }
    return self;
}




- (NSString*)labelTextForRow: (NSInteger)row column: (NSInteger)col
{
    
    int num = col*10 + row;
    
    switch (num)
    {
        case 0:
            return [NSString stringWithFormat:@"Students: %@", self.program.population];
        case 1:
        {
            int yearNum = 0;
            NSArray* array = [self.program.courses allObjects];
            for(ProgramCourse* course in array)
            {
                if([course.enrollmentYear intValue] > yearNum)
                {
                    yearNum = [course.enrollmentYear intValue];
                }
            }
            
            return [NSString stringWithFormat:@"%i Years",yearNum];
            
        }
        case 2:
        {
            BOOL hasInternship = [self.program.isCoop boolValue];
            
            if(hasInternship)
                return @"Has Internship";
            else
                return @"No Internship";
            
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
            return @"Avg Unknown";
            
        default:
            return @"";
    }
    return @"";
    
    
}






- (void)emailButtonTapped: (UIButton*)sender
{
    
    [self.delegate emailButtonTapped];
    
}


- (void)websiteButtonTapped: (UIButton*)sender
{
    
    [self.delegate websiteButtonTapped];

}


- (void)facebookButtonTapped: (UIButton*)sender
{
    
    [self.delegate facebookButtonTapped];
    
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
    CGPoint dividerLineVert[] = {jpp(200, 50),jpp(200, 180)};
    
    CGContextAddLines(context, dividerLineVert, 2);
    CGContextDrawPath(context, kCGPathStroke);

    
    
    
    
    
    
}


@end
