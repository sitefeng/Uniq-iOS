//
//  iPadProgramDetailView.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-08.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Program, iPadProgramDetailInfoView, iPadProgramDetailGraphView;

@interface iPadProgramDetailView : UIScrollView
{
    
    
    float _currentHeight;
    
    iPadProgramDetailInfoView* infoView;
    
    NSMutableArray* graphViews;
    
    
    
}





@property (nonatomic, strong) Program* program;







- (id)initWithFrame:(CGRect)frame andProgram: (Program*)prog;


- (void)reloadData;




@end
