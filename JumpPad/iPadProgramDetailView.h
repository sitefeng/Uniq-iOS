//
//  iPadProgramDetailView.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-08.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Program;

@interface iPadProgramDetailView : UIScrollView
{
    
    
    float _currentHeight;
    
}





@property (nonatomic, assign) Program* program;


@property (nonatomic, strong) NSMutableDictionary* elementTitleDict; //a dict of UILabels
@property (nonatomic, strong) NSMutableDictionary* elementValueDict; //a dict of UILabels





- (id)initWithFrame:(CGRect)frame andProgram: (Program*)prog;







@end