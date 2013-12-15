//
//  iOSDashletDetailsElementView.h
//  JumpPad
//
//  Created by Si Te Feng on 12/11/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iOSDashletDetailsElementView : UIView
{
    
@private
    
    NSDictionary* _attributes;
    
    
}



@property (nonatomic, strong) UIImage* iconImage;
@property (nonatomic, strong) UIImageView* imageView;

@property(nonatomic, strong) NSString* value;
@property(nonatomic, strong) UILabel* label;



- (instancetype)initWithIconName:(NSString*)iconName andValue:(NSString*)value;




@end
