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


//New Methods
+ (UIColor*) programViewTitleColor
{
    return [self colorWithHex:@"500000" alpha:1];
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





+ (UIColor*)rainbowColorWithIndex: (NSUInteger)index //6 colors
{
    UIColor* color = [UIColor lightGrayColor];
    
    switch (index%7)
    {
        
        case 0:
            color = [self colorWithHex:@"FF617B" alpha:1]; //pink
            break;
        
        case 1:
            color = [self colorWithHex:@"D291FF" alpha:1];
            break;
        
        case 2:
            color = [self colorWithHex:@"80ABFF" alpha:1];
            break;
        case 3:
            color = [self colorWithHex:@"8AFFCD" alpha:1];
            break;
        case 4:
            color = [self colorWithHex:@"00CE32" alpha:1];
            break;
        case 5:
            color = [self colorWithHex:@"FFA73D" alpha:1];
            break;
        case 6:
            color = [self colorWithHex:@"B2E004" alpha:1];
            break;
            
        default:
            NSLog(@"--Error--No Color Available");
            break;
    }

    
    return  color;
}




+ (UIColor*)translucentRainbowColorWithIndex: (NSUInteger)index
{
    UIColor* color = [self rainbowColorWithIndex:index];
    
    return  [color colorWithAlphaComponent:0.4];
}


+ (UIColor*)whiteTranslucentRainbowColorWithIndex: (NSUInteger)index
{
    CGFloat red,green,blue, a;
    UIColor* tempColor = [self rainbowColorWithIndex:index];
    
    BOOL returnColor = [tempColor getRed:&red green:&green blue:&blue alpha:&a];
    
    if(returnColor)
    {
        tempColor = [UIColor colorWithRed:red+0.2 green:green+0.2 blue:blue+0.2 alpha:a];
    }
  
    return tempColor;
}


+ (UIColor*)backgroundRainbowColorWithIndex: (NSUInteger)index
{
    UIColor* color = [UIColor lightGrayColor];
    
    switch (index%7)
    {
        case 0:
            color = [self colorWithHex:@"FF5733" alpha:1]; //red
            break;
        case 1:
            color = [self colorWithHex:@"FFA230" alpha:1];//orange
            break;
        case 2:
            color = [self colorWithHex:@"13D8BF" alpha:1];//indigo
            break;
        case 3:
            color = [self colorWithHex:@"13D8BF" alpha:1];//blue
            break;
        case 4:
            color = [self colorWithHex:@"7EB98D" alpha:1];//green
            break;
        case 5:
            color = [self colorWithHex:@"7187C7" alpha:1];//dark blue
            break;
        case 6:
            color = [self colorWithHex:@"7E43E0" alpha:1]; //purple
            break;
            
        default:
            NSLog(@"--Error--No Color Available");
            break;
    }
    
    
    return  color;
}





+ (UIColor*)colorWithName: (NSString*)colorName
{
    UIColor* returnColor = [UIColor darkGrayColor];
    
    if([colorName isEqualToString:@"blue"]) //light blue bars
    {
        returnColor = [self colorWithHex:@"00A5FF" alpha:1];
    }
    else if([colorName isEqualToString:@"green"]) //light green button
    {
        returnColor = [self colorWithHex:@"00CF03" alpha:1];
    }
    else if([colorName isEqualToString:@"darkRed"]) //dark red text
    {
        returnColor = [self colorWithHex:@"500000" alpha:1];
    }
    else if([colorName isEqualToString:@"red"]) //calendar header
    {
        returnColor = [self colorWithHex:@"FF5F5C" alpha:1];
    }
    else if([colorName isEqual:@"grey"])
    {
        returnColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
    }
    else
    {
        NSLog(@"--Error--No Color Available");
    }
    
    return returnColor;
}



@end








@implementation UIImage (Beautify)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (UIImage*)imageWithAlpha: (CGFloat) alpha
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect area = CGRectMake(0,0, self.size.width, self.size.height);
    
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -area.size.height);
    
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    CGContextSetAlpha(context, alpha);
    
    CGContextDrawImage(context, area, self.CGImage);
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}









@end








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




