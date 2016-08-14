//
//  iPadProgramSummaryView.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-08.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPProgramSummaryView.h"
#import "Program.h"
#import "ProgramCourse.h"
#import "JPFont.h"
#import "JPLocation.h"
#import "User.h"
#import "JPGlobal.h"
#import "DXAlertView.h"
#import "JPCoreDataHelper.h"


static const NSInteger numRow = 3;
static const NSInteger numCol = 2;

typedef NS_ENUM(NSInteger, JPProgramSummaryLabelType) {
    JPProgramSummaryLabelTypePopulation = 0,
    JPProgramSummaryLabelTypeLocation,
    JPProgramSummaryLabelTypeDuration,
    JPProgramSummaryLabelTypeDistance,
    JPProgramSummaryLabelTypeFavorites,
    JPProgramSummaryLabelTypeAverage
};


@interface JPProgramSummaryView()

// Array of UITextLabels
@property (nonatomic, strong) NSMutableArray *summaryLabels;

@end

@implementation JPProgramSummaryView //for basic information on top in a program

- (id)initWithFrame:(CGRect)frame program: (Program*)program 
{
    self = [self initWithFrame:frame program:program isPhoneInterface:NO];
    return self;
}


- (id)initWithFrame:(CGRect)frame program: (Program*)program isPhoneInterface: (BOOL)isPhone
{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.program = program;
    
    self.isIphoneInterface = isPhone;
    _readyToCalculateDistance = false;
    
    _summaryLabels = [[NSMutableArray alloc] init];
    
    CGFloat viewWidth = frame.size.width;
    self.summary = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, viewWidth - 40, 35)];
    self.summary.textColor = [UIColor whiteColor];
    self.summary.font = [UIFont fontWithName:[JPFont defaultLightFont] size:20];
    self.summary.text = @"SUMMARY";
    
    //Icon images and labels;
    NSArray* iconImageNames = [NSMutableArray arrayWithObjects:@"SStudents",@"SLocation",@"SDuration",@"SDistance",@"favoriteIconHighlighted",@"SAverage", nil];
    
    int horizDist =200;
    if(self.isIphoneInterface)
        horizDist = 165;
    
    const int vertDist = 40;
    for(int i=0; i<numRow; i++)
    {
        for(int j=0; j<numCol; j++)
        {
            UIImageView* view = [[UIImageView alloc] initWithFrame:CGRectMake(15+ horizDist*j, 65+ vertDist*i, 30, 30)];
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.image = [UIImage imageNamed:iconImageNames[i*numCol+j]];
            view.userInteractionEnabled = YES;
            view.tag = i*numCol+j;
            UITapGestureRecognizer* tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageItemTapped:)];
            [view addGestureRecognizer:tapRec];
            [self addSubview:view];
            
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(50+ horizDist*j, 65+vertDist*i, horizDist-40, 30)];
            label.font = [UIFont fontWithName:[JPFont defaultLightFont] size:15];
            label.textColor = [UIColor whiteColor];
            label.text = [self labelTextForRow:i column:j];
            [self.summaryLabels addObject:label];
            [self addSubview:label];
        }
    }
    
    //*************************************
    CGFloat deadlineViewWidth = 35;
    if(self.isIphoneInterface)
        deadlineViewWidth = 30;
    UIImageView* deadlineView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 190, deadlineViewWidth, deadlineViewWidth)];
    deadlineView.image = [UIImage imageNamed:@"calendarIcon"];
    
    CGFloat labelXPos = 60;
    if(self.isIphoneInterface)
        labelXPos = 55;
    UILabel* deadlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelXPos, 187, 300, 40)];
    deadlineLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:19];
    deadlineLabel.textColor = [UIColor whiteColor];
    
    NSString* monthString = [self.program.applicationDeadline substringToIndex:2];//@"02"
    
    NSString* month = [JPGlobal monthStringWithInt:[monthString intValue]];//@"Feb"
    NSString* date = [self.program.applicationDeadline substringFromIndex:3];
    
    deadlineLabel.text = [NSString stringWithFormat:@"App Deadline: %@ %@", month, date];
    
    [self addSubview:deadlineView];
    [self addSubview:deadlineLabel];
    
    //**************************************
    CGFloat buttonStartPos = 30;
    CGFloat buttonDistance = 87;
    if(self.isIphoneInterface)
    {
        buttonDistance = 75;
    }
    //Or Phone Button
    _favoriteButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonStartPos, 240, 54, 54)];
    
    if(!self.isIphoneInterface)
    {
        [_favoriteButton setImage:[UIImage imageNamed:@"favoriteIcon"] forState:UIControlStateNormal];
        [_favoriteButton setImage:[UIImage imageNamed:@"favoriteIconHighlighted"] forState:UIControlStateHighlighted];
        [_favoriteButton setImage:[UIImage imageNamed:@"favoriteIconSelected"] forState:UIControlStateSelected];
        _favoriteButton.selected = NO;
        [_favoriteButton addTarget:self action:@selector(favoriteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [_favoriteButton setImage:[UIImage imageNamed:@"phoneIcon"] forState:UIControlStateNormal];
        [_favoriteButton addTarget:self action:@selector(phoneButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton* email = [[UIButton alloc] initWithFrame:CGRectMake(buttonStartPos+ buttonDistance, 240, 54, 54)];
    [email setImage:[UIImage imageNamed:@"email"] forState:UIControlStateNormal];
    [email setImage:[UIImage imageNamed:@"emailOpen"] forState:UIControlStateHighlighted];
    [email addTarget:self action:@selector(emailButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* website = [[UIButton alloc] initWithFrame:CGRectMake(buttonStartPos+ buttonDistance*2, 240, 54, 54)];
    [website setImage:[UIImage imageNamed:@"safariIcon"] forState:UIControlStateNormal];
    [website addTarget:self action:@selector(websiteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* facebook = [[UIButton alloc] initWithFrame:CGRectMake(buttonStartPos+buttonDistance*3, 240, 54, 54)];
    [facebook setImage:[UIImage imageNamed:@"facebookIcon"] forState:UIControlStateNormal];
    [facebook addTarget:self action:@selector(facebookButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_favoriteButton];
    [self addSubview:email];
    [self addSubview:website];
    [self addSubview:facebook];
    [self addSubview:self.summary];
    
    return self;
}



- (NSString*)labelTextForRow: (NSInteger)row column: (NSInteger)col
{
    
    NSUInteger num = col*10 + row;
    
    switch (num)
    {
        case 0:
            return [NSString stringWithFormat:@"%@ Students", self.program.undergradPopulation];
        case 1:
        {
            int yearNum = 0;
            NSArray* array = [self.program.courses allObjects];
            for(ProgramCourse* course in array)
            {
                //Todo nonurgent
                if([course.enrollmentTerm intValue] > yearNum)
                {
                    yearNum = [course.enrollmentTerm intValue];
                }
            }
            
            return [NSString stringWithFormat:@"%i Years",yearNum];
            
        }
        case 2:
        {
            NSInteger numFavorites = [self.program.numFavorites integerValue];
            return [NSString stringWithFormat:@"%ld Favorited", (long)numFavorites];
            
        }
        case 10:
        {
            NSString* location = @"Unknown";
            
            if(self.location.cityName) {
                location = [NSMutableString stringWithFormat:@"%@",self.location.cityName];
            }
            
            return location;
        }
        case 11:
        {
            NSString* province = @"Unknown";
            
            if(self.location.provinceName) {
                province = self.location.provinceName;
            }
            
            return province;
        }
        case 12:
        {
            NSString* avgString = self.program.avgAdm;
            
            if(avgString && ![avgString isEqual:@""])
            {
                return [NSString stringWithFormat:@"%@%% Avg", avgString];
            }
            else
            {
                return @"Avg Unkown";
            }
            
        }
            
        default:
            return @"";
    }
    return @"";
    
    
}



#pragma mark - Callback Methods
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

- (void)phoneButtonTapped: (UIButton*)sender
{
    if([self.delegate respondsToSelector:@selector(phoneButtonTapped)])
    {
        [self.delegate phoneButtonTapped];
    }
}


- (void)setIsFavorited:(BOOL)isFavorited
{
    _isFavorited = isFavorited;
    _favoriteButton.selected = isFavorited;
}



/////////////
- (void)setProgram:(Program *)program
{
    _program = program;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        JPLocation *location = [program requestLocationSynchronously];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.location = location;
            [self reloadView];
        });
    });
}

                                                
- (NSInteger)indexForLabelOfType:(JPProgramSummaryLabelType)labelType {
    return labelType;
}


// TODO: Implement updating for other summary types
- (void)reloadView {
    
    // update location text
    for(int i=0; i<numRow; i++)
    {
        for(int j=0; j<numCol; j++)
        {
            NSInteger index = i*numCol+j;
            UILabel *label = self.summaryLabels[index];
            label.text = [self labelTextForRow:i column:j];
        }
    }
}

#pragma mark - Drawing

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing Horizontal line
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGFloat lengths[] = {2, 2};
    CGContextSetLineDash(context, 0.0f, lengths, 2);
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    
    CGPoint dividerLine[] = {jpp(20, 50),jpp(384-20, 50)};
    
    CGContextAddLines(context, dividerLine, 2);
    CGContextDrawPath(context, kCGPathStroke);

    // Drawing vertical line
    CGFloat vertXPos = 195;
    if(self.isIphoneInterface)
        vertXPos = 170;
    
    CGPoint dividerLineVert[] = {jpp(vertXPos, 50),jpp(vertXPos, 180)};
    
    CGContextAddLines(context, dividerLineVert, 2);
    CGContextDrawPath(context, kCGPathStroke);
}



@end
