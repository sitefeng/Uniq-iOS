//
//  iPhFacultyDetailView.m
//  Uniq
//
//  Created by Si Te Feng on 8/16/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//

#import "iPhFacultyDetailView.h"

#import "JPFont.h"
#import "Faculty.h"


@interface iPhFacultyDetailView()

@property (nonatomic, copy, readwrite) NSString *title;

@end

@implementation iPhFacultyDetailView

- (instancetype)initWithFrame:(CGRect)frame title: (NSString*)title faculty: (Faculty*)faculty
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.faculty = faculty;
        self.title = title;
        
        if([title isEqual:@"About"])
        {
            UITextView* textView =[[UITextView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            textView.editable = NO;
            textView.selectable = NO;
            textView.backgroundColor = [UIColor clearColor];
            textView.font = [UIFont fontWithName:[JPFont defaultFont] size:15];
            textView.showsVerticalScrollIndicator = NO;
            
            textView.text = faculty.about;
            
            [self addSubview:textView];
            
            self.viewHeight = 170;
        }
    }
    return self;
}


@end
