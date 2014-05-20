//
//  iPadProgramCompareViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Program;
@interface iPadProgramCompareViewController : UIViewController




@property (nonatomic, assign) NSUInteger dashletUid;

@property (nonatomic, strong) Program* program;





- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program;



@end
