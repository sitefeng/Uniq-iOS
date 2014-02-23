//
//  JPStyle.m
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "JPStyle.h"

@implementation JPStyle


#pragma mark - Device Verification

+(BOOL) iPad
{
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
    return NO;
#endif
}


+(BOOL) iOS7
{
	return [[UIDevice currentDevice].systemVersion hasPrefix:@"7"];
}


+(BOOL) iPhone4Inch
{
    return ([UIScreen mainScreen].bounds.size.height == 568.0) ? YES : NO;
}


#pragma mark - User Interface Colors


+(UIColor*) interfaceTintColor
{
    return [UIColor colorWithRed:(148.0f/255.0f) green:(192.0/255.0f) blue:(190.0f/255.0f) alpha:1.0f];
    
}

+(UIColor*) defaultBorderColor
{
    return [UIColor blackColor];
}

//Dashlets

+ (UIImage*) dashletDefaultBackgroundImage
{
    return [UIImage imageNamed:@"dashletDefault"];
}


+(UIColor*) dashletDefaultBorderColor
{
    return [self colorWithHex:@"240059" alpha:1];
}


+(UIColor*) dashletDefaultTitleTextColor
{
    return [UIColor blackColor];
}


+(UIColor*) dashletDefaultDetailsTextColor
{
    return [UIColor purpleColor];
}


+(UIColor*) mainViewControllerDefaultBackgroundColor
{
    return [self colorWithHex:@"DFFCDC" alpha:1];
}


+(UIColor*) mainViewControllerPromotionalBackgroundColor
{
    return [self colorWithHex:@"FCE2DC" alpha:1];
}

+(UIColor*) searchBarBackgroundColor{
    
    
    return [UIColor lightGrayColor];
}


+(void)applyGlobalStyle
{
	[[UINavigationBar appearance] setTintColor:[JPStyle interfaceTintColor]];
	[[UISearchBar appearance] setTintColor:[JPStyle interfaceTintColor]];
	[[UITabBar appearance] setTintColor:[JPStyle interfaceTintColor]];
    
	// Set the colours of the tabbar and navbar in IOS7
	if ( [JPStyle iOS7] && [JPStyle iPad])
	{
		[[UINavigationBar appearance] setBarTintColor:[JPStyle interfaceTintColor]];
		[[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
	}
}


+ (UIColor*)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}


+ (UIColor*)colorWithHex:(NSString*)hex alpha:(CGFloat)alpha
{
    NSString *redHex;
    NSString *greenHex;
    NSString *blueHex;
    
    if ([hex length] == 6)
    {
        redHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(0, 2)]];
        greenHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(2, 2)]];
        blueHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(4, 2)]];
    }
    else if ([hex length] == 7)
    {
        redHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(1, 2)]];
        greenHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(3, 2)]];
        blueHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(5, 2)]];
    }
    else {
        redHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(2, 2)]];
        greenHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(4, 2)]];
        blueHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(6, 2)]];
    }
    
    unsigned redInt = 0;
    NSScanner *rScanner = [NSScanner scannerWithString:redHex];
    [rScanner scanHexInt:&redInt];
    
    unsigned greenInt = 0;
    NSScanner *gScanner = [NSScanner scannerWithString:greenHex];
    [gScanner scanHexInt:&greenInt];
    
    unsigned blueInt = 0;
    NSScanner *bScanner = [NSScanner scannerWithString:blueHex];
    [bScanner scanHexInt:&blueInt];
    
    return [self colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:alpha];
}


//// Colours
//#define kWhiteText 				0xFFFFFF
//#define kDeactiveText 			0xB0B0B0
//#define kRegularText 			0x4A4A4A
//#define kLightenedText 			0x7B7979
//#define kGreenRegularText 		0x586B70
//#define kGreenLightenedText 	0x648991
//#define kUnitBoardCell 			0xE2ECF1
//#define kLightBlueText 			0x6BE0D8
//#define kLightGrey 				0x666666
//
//// Cell Background Colors
//#define kLightBlue 				0x9AD4ED
//#define klightPink 				0xF7BBC5
//#define kRed 					0xF76858
//#define kYellow 				0xEDDC88
//#define kOrange 				0xFCAE54
//#define kGreen 					0x9AC555
//#define kBlue 					0x42A9De
//#define kPurple 				0xC39BCC
//#define kBrown 					0xB2A786
//#define kLightGreen 			0xBDCCD4
//#define kLightGreyBackground 	0xF2F2F2
//#define kDarkGreyBackground 	0xCFCED1
//#define kDarkLine 				0x8C9EA7
//#define kRefreshBackground 		0xCCCCCC
//#define kDarkBlueColorHex       0x6D8991
//#define kDarkBlueColorRGB       [UIColor colorWithRed:109/255.0 green:137/255.0 blue:145/255.0 alpha:1.0]
//#define kBorderColor			0x97BFBC




@end
