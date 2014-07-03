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

@implementation iPadSchoolSummaryView

- (instancetype)initWithFrame:(CGRect)frame school:(School *)school
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        _readyToCalculateDistance = false;
        
        _school = school;
        
        self.summary = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 200, 35)];
        self.summary.textColor = [UIColor whiteColor];
        
        self.summary.font = [UIFont fontWithName:[JPFont defaultLightFont] size:20];
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
                if(i==2&&j==1) break;
                
                UIImageView* view = [[UIImageView alloc] initWithFrame:CGRectMake(15+ horizDist*j, 65+ vertDist*i, 30, 30)];
                view.image = [UIImage imageNamed:@"infoIcon"];
                [self.iconImages addObject:view];
                [self addSubview:view];
                
                UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(50+ horizDist*j, 65+vertDist*i, 160, 30)];
                label.font = [UIFont fontWithName:[JPFont defaultLightFont] size:15];
                label.textColor = [UIColor whiteColor];
                label.shadowColor = [UIColor whiteColor];
                label.text = [self labelTextForRow:i column:j];
                [self addSubview:label];
                
            }
            
        }
        
        float iconHeight = 210;
        
        _favoriteButton = [[UIButton alloc] initWithFrame:CGRectMake(30, iconHeight, 54, 54)];
        [_favoriteButton setImage:[UIImage imageNamed:@"favoriteIcon"] forState:UIControlStateNormal];
        [_favoriteButton setImage:[UIImage imageNamed:@"favoriteIconSelected"] forState:UIControlStateSelected];
        _favoriteButton.selected = NO;
        if(self.isFavorited)
            _favoriteButton.selected = YES;
        
        [_favoriteButton addTarget:self action:@selector(favoriteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton* website = [[UIButton alloc] initWithFrame:CGRectMake(30+ 87, iconHeight, 54, 54)];
        [website setImage:[UIImage imageNamed:@"iOSSafariIcon"] forState:UIControlStateNormal];
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




- (NSString*)labelTextForRow: (NSInteger)row column: (NSInteger)column
{
    
    return @"Not Set";
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
