//
//  iPhFacultyDetailView.h
//  Uniq
//
//  Created by Si Te Feng on 8/16/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//


@class Faculty;
@interface iPhFacultyDetailView : UIView



@property (nonatomic, strong) Faculty *faculty;
@property (nonatomic, readonly, copy) NSString *title;

@property (nonatomic, assign) CGFloat viewHeight;


@end
