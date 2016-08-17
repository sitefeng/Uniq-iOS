//
//  iPhSchoolDetailView.m
//  Uniq
//
//  Created by Si Te Feng on 8/16/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//

#import "iPhSchoolDetailView.h"

#import "JPFont.h"
#import "School.h"

@interface iPhSchoolDetailView()

@property (nonatomic, copy, readwrite) NSString *title;

@end


@implementation iPhSchoolDetailView

- (instancetype)initWithFrame:(CGRect)frame title: (NSString*)title school: (School*)school
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.school = school;
        self.title = title;
        
        if([title isEqual:@"About"])
        {
            UITextView* textView =[[UITextView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            textView.editable = NO;
            textView.selectable = NO;
            textView.backgroundColor = [UIColor clearColor];
            textView.font = [UIFont fontWithName:[JPFont defaultFont] size:15];
            textView.showsVerticalScrollIndicator = NO;
            
            textView.text = school.about;
            
            [self addSubview:textView];
            
            self.viewHeight = 170;
        }
    }
    return self;
}

@end
