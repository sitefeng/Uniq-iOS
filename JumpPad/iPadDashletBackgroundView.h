//
//  iPadDashletBackgroundView.h
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPadDashletBackgroundView : UIView





//Icon for College, null if it's not a school
@property (nonatomic, strong, readonly) UIImage* icon;

@property (nonatomic, strong) NSString* itemUID;

@property (nonatomic, strong) NSString* iconName;

@property (nonatomic, strong) NSArray* backgroundImageNames;


@end
