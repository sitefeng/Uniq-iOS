//
//  iPadProgramComparisonViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/4/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPadProgramComparisonViewController : UIViewController
{
    NSInteger  _numPrograms; 
    
}


@property (nonatomic, strong) NSArray* programs; //Programs to Compare


- (instancetype)initWithPrograms: (NSArray*)programs;

@end
