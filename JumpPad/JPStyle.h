//
//  JPStyle.h
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JPStyle : NSObject


//Device Verification
+(BOOL) iPad;
+(BOOL) iOS7;
+(BOOL) iPhone4Inch;


/////////////////////////////
////User Interface Colors

// Color of Nav Bar and Search Bar
+(UIColor*) interfaceTintColor;

+(UIImage*) dashletDefaultBackgroundImage;
+(UIColor*) dashletTextColor;
+(UIColor*) dashletDefaultBorderColor;

+(UIColor*) dashletScrollViewDefaultbackgroundColor;
+(UIColor*) bannerDefaultbackgroundColor;
+(UIColor*) filterBarDefaultbackgroundColor;

//set the main background color
+(UIColor*) mainViewControllerDefaultBackgroundColor;
+(UIColor*) mainViewControllerPromotionalBackgroundColor;

//Default app theme
+(void)applyGlobalStyle;

//Color Conversion
+(UIColor*)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;
+(UIColor*)colorWithHex:(NSString*)hex alpha:(CGFloat)alpha;


@end
