//
//  iPadProgramLabelView.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Program, AsyncImageView;

@interface iPadProgramLabelView : UIView
{
    NSManagedObjectContext* context;
    Program* _program;
    
}



@property (nonatomic, assign) NSInteger dashletUid;

@property (nonatomic, strong) AsyncImageView* imageView;
@property (nonatomic, strong) UILabel* label;



- (id)initWithFrame:(CGRect)frame dashletNum:(NSInteger)number program: (Program*)program;



@end
