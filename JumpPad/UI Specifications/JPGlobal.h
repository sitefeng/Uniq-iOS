//
//  JPGlobal.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPGlobal : NSObject


+ (instancetype)instance;






+ (NSString*)monthStringWithInt: (int)month;
+ (NSString*)ratingStringWithIndex: (NSInteger)index;
+ (NSString*)ratingFullStringWithIndex: (NSInteger)index;


+ (NSString*)paragraphStringWithName: (NSString*)name;
+ (void)openURL: (NSURL*)url;




UIImage* imageFromView(UIView *view);



@end
