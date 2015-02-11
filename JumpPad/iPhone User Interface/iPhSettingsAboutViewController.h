//
//  iPhSettingsAboutViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/18/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPhSettingsAboutViewController : UIViewController


@property (nonatomic, strong)NSString* name;

@property (nonatomic, strong) UITextView* descriptionView;


- (id)initWithName: (NSString*)name;



@end
