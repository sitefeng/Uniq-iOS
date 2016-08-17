//
//  iPhFacultyDetailView.h
//  Uniq
//
//  Created by Si Te Feng on 8/16/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//


#import "ProgramDetailViewGeneric.h"

@class Faculty;
@interface iPhFacultyDetailView : UIView <ProgramDetailViewGeneric>



@property (nonatomic, strong) Faculty *faculty;
@property (nonatomic, readonly, copy) NSString *title;

@property (nonatomic, assign) CGFloat viewHeight;


- (instancetype)initWithFrame:(CGRect)frame title: (NSString*)title faculty: (Faculty*)faculty;


@end
