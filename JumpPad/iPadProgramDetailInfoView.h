//
//  iPadProgramDetailInfoView.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-11.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPadProgramDetailInfoView : UIView







@property (nonatomic, strong) NSMutableDictionary* elementTitleDict; //a dict of UILabels
@property (nonatomic, strong) NSMutableDictionary* elementValueDict; //a dict of UILabels


@property (nonatomic, assign) float  viewHeight;







- (id)initWithFrame:(CGRect)frame  title:(NSString*)title  paragraph:(NSString*) paragraph;









@end
