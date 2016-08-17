//
//  iPhSchoolDetailView.h
//  Uniq
//
//  Created by Si Te Feng on 8/16/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class School;

@interface iPhSchoolDetailView : UIView


@property (nonatomic, strong) School *school;

@property (nonatomic, readonly, copy) NSString *title;

@property (nonatomic, assign) CGFloat viewHeight;

@end
