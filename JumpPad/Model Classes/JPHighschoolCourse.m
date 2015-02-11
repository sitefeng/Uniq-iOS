//
//  JPHighschoolCourse.m
//  Uniq
//
//  Created by Si Te Feng on 8/24/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPHighschoolCourse.h"

@implementation JPHighschoolCourse


- (instancetype)initWithCode: (NSString*)code courseLevel: (NSInteger)level courseMark: (float)mark
{
    self = [super init];
    
    self.courseCode = code;
    self.courseMark = mark;
    self.courseLevel = level;
    
    return self;
}




@end
