//
//  iPadProgramLabelView.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramLabelView.h"
#import "AsyncImageView.h"
#import "UniqAppDelegate.h"

#import "Program.h"
#import "School.h"
#import "JPFont.h"
#import "JPDataRequest.h"
#import "ManagedObjects+JPConvenience.h"


@implementation iPadProgramLabelView

//For Program Detail
- (id)initWithFrame:(CGRect)frame program: (Program*)program
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [JPStyle colorWithName:@"tWhite"];
        
        self.program = program;
        
        UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        context = [delegate managedObjectContext];
        
        JPDataRequest* dataReq = [[JPDataRequest alloc] init];
        dataReq.delegate = self;
        [dataReq requestItemBriefDetailsWithId:self.program.schoolId ofType:JPDashletTypeSchool];
        
        
        //ImageView
        self.imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(20,4,36,36)];
        [self.imageView showActivityIndicator];
        
        
        //UILabel
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 730, 34)];
        self.label.textColor = [JPStyle colorWithHex:@"000000" alpha:1];
        self.label.font = [UIFont fontWithName:[JPFont defaultThinFont] size:30];
        self.label.text = [NSString stringWithFormat:@"%@", self.program.name];
        
        
        [self addSubview:self.imageView];
        [self addSubview:self.label];
        
    }
    return self;
}


//For General Use
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [JPStyle colorWithName:@"tWhite"];
        
        UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        context = [delegate managedObjectContext];

        
        //ImageView
        self.imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(20,4,36,36)];
        [self.imageView showActivityIndicator];
        
        
        //UILabel
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 730, 34)];
        self.label.textColor = [JPStyle colorWithHex:@"000000" alpha:1];
        self.label.shadowColor = [UIColor blackColor];
        self.label.font = [UIFont fontWithName:[JPFont defaultThinFont] size:30];
        
        [self addSubview:self.imageView];
        [self addSubview:self.label];
        
    }
    return self;
    
}



- (void)dataRequest:(JPDataRequest *)request didLoadItemBriefDetailsWithId:(NSString *)itemId ofType:(JPDashletType)type dataDict:(NSDictionary *)dict isSuccessful:(BOOL)success
{
    School* school = [[School alloc] initWithDictionary:dict];
    
    self.imageView.imageURL = [NSURL URLWithString:school.logoUrl];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
