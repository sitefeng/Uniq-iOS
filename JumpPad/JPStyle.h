//
//  JPStyle.h
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface JPStyle : NSObject


//Device Verification
+(BOOL) isiPad;
+(BOOL) iOS7;
+(BOOL) iPhone4Inch;


/////////////////////////////
////User Interface Colors

//Default app theme
+(UIColor*) interfaceTintColor;
+(void)applyGlobalStyle;



//Color Conversion
+(UIColor*)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;
+(UIColor*)colorWithHex:(NSString*)hex alpha:(CGFloat)alpha;

//Beatiful colors
+ (UIColor*)rainbowColorWithIndex: (NSUInteger)index; //7 colors
+ (UIColor*)translucentRainbowColorWithIndex: (NSUInteger)index;
+ (UIColor*)whiteTranslucentRainbowColorWithIndex: (NSUInteger)index;
+ (UIColor*)backgroundRainbowColorWithIndex: (NSUInteger)index;

//Colors from String
+ (UIColor*) colorWithName: (NSString*)colorName;
+ (UIColor*) colorWithLetter: (NSString*)letter;
+ (UIColor*)colorWithLetterVariated: (NSString*)letter;

@end



@interface UIImage (Beautify)

+ (UIImage*)imageWithColor:(UIColor *)color;
- (UIImage*)imageWithAlpha: (CGFloat)alpha;
- (UIImage*)imageWithColor: (UIColor*)color;

@end
