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

@implementation iPadProgramLabelView

//For Program Detail
- (id)initWithFrame:(CGRect)frame dashletNum:(NSInteger)number program: (Program*)program
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [JPStyle colorWithName:@"tWhite"];
        
        _program = program;
        self.dashletUid = number;
        
        UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        context = [delegate managedObjectContext];
        
        NSInteger schoolId = self.dashletUid / 1000000;
        
        NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"School"];
        request.predicate = [NSPredicate predicateWithFormat:@"schoolId = %i", schoolId];
        
        School* school = [[context executeFetchRequest:request error:nil] firstObject];
        
        //ImageView
        self.imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(20,4,36,36)];
        self.imageView.imageURL = [NSURL URLWithString:school.logoUrl];
        [self.imageView showActivityIndicator];
        
        
        //UILabel
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 730, 34)];
        self.label.textColor = [JPStyle colorWithHex:@"000000" alpha:1];
//        self.label.shadowColor = [UIColor blackColor];
        self.label.font = [UIFont fontWithName:[JPFont defaultThinFont] size:30];
        self.label.text = [NSString stringWithFormat:@"%@", _program.name];
        
        
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
