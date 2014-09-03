//
//  NSObject_JPConvenience.m
//  Uniq
//
//  Created by Si Te Feng on 9/1/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "NSObject+JPConvenience.h"

@implementation NSObject (JPConvenience)




- (NSNumber*)numberFromNumberString: (NSString*)string
{
    if([string rangeOfString:@","].location == NSNotFound)
        return [NSNumber numberWithDouble:[string doubleValue]];
    
    NSArray* componentArray = [string componentsSeparatedByString:@","];
 
    NSMutableString* noCommaString = [@"" mutableCopy];
    
    for(NSString* comp in componentArray)
    {
        [noCommaString appendString:comp];
    }
    
    return [NSNumber numberWithDouble:[noCommaString doubleValue]];
}




- (NSNumber*)numberFromPhoneString: (NSString*)string
{
    if([string rangeOfString:@"-"].location == NSNotFound)
        return [NSNumber numberWithLongLong:[string longLongValue]];
    
    NSArray* componentArray = [string componentsSeparatedByString:@"-"];
    
    NSMutableString* noDashString = [@"" mutableCopy];
    
    for(NSString* comp in componentArray)
    {
        [noDashString appendString:comp];
    }
    
    return [NSNumber numberWithLongLong:[noDashString longLongValue]];
}



- (JPDashletType)dashletTypeFromTypeString: (NSString*)type
{
    if([type isEqual:@"school"])
    {
        return JPDashletTypeSchool;
    }
    else if([type isEqual:@"faculty"])
    {
        return JPDashletTypeFaculty;
    }
    else if([type isEqual:@"program"])
    {
        return JPDashletTypeProgram;
    }
    else
    {
        return -1;
    }
}






@end
