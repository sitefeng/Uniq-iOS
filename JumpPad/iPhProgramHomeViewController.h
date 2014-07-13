//
//  iPhProgramHomeViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPhProgramAbstractViewController.h"


@class Program, iPhImageScrollView, iPhProgramDetailView;
@interface iPhProgramHomeViewController : iPhProgramAbstractViewController
{
    iPhImageScrollView*  _panImageView;
    
    
    
    UIScrollView*  _detailScrollView;
    
    iPhProgramDetailView* _highlighView;
    iPhProgramDetailView* _ratioView;
}





- (instancetype)initWithProgram: (Program*)program;





@end
