//
//  iPhSchoolDetailView.h
//  Uniq
//
//  Created by Si Te Feng on 8/16/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//

#import "ProgramDetailViewGeneric.h"

@class School;

@interface iPhSchoolDetailView : UIView <ProgramDetailViewGeneric>


@property (nonatomic, strong) School *school;

@property (nonatomic, readonly, copy) NSString *title;

@property (nonatomic, assign) CGFloat viewHeight;


- (instancetype)initWithFrame:(CGRect)frame title: (NSString*)title school: (School*)school;

@end
