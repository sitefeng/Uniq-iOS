//
//  iPhProgramContactViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPhProgramAbstractViewController.h"


@class Program, iPhMapPanView;
@interface iPhProgramContactViewController : iPhProgramAbstractViewController
{
    iPhMapPanView*   _mapPanView;
}






- (instancetype)initWithProgram: (Program*)program;


@end
