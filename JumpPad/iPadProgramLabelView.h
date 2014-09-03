//
//  iPadProgramLabelView.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPDataRequest.h"


@class Program, AsyncImageView;

@interface iPadProgramLabelView : UIView <JPDataRequestDelegate>
{
    NSManagedObjectContext* context;
    
}



@property (nonatomic, strong) Program* program;

@property (nonatomic, strong) AsyncImageView* imageView;
@property (nonatomic, strong) UILabel* label;



- (id)initWithFrame:(CGRect)frame program: (Program*)program;



@end
