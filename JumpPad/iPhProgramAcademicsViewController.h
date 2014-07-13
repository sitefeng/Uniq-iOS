//
//  iPhProgramAcademicsViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Program;
@interface iPhProgramAcademicsViewController : UIViewController




@property (nonatomic, strong) Program* program;





- (instancetype)initWithProgram: (Program*)program;


@end
