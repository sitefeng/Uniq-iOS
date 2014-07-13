//
//  iPhProgramViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Program, JPCoreDataHelper;
@interface iPhProgramViewController : UITabBarController
{
    JPCoreDataHelper*  _helper;
}




@property (nonatomic, assign) NSUInteger dashletUid;

@property (nonatomic, strong) Program* program;







- (instancetype)initWithDashletUid: (NSUInteger)dashletUid;


@end
