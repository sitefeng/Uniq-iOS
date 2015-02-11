//
//  NSString+JPKnowledgeEngine.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-28.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "NSString+JPKnowledgeEngine.h"

@implementation NSString (JPKnowledgeEngine)




- (NSMutableArray*)getAllSubstrings
{
    
    NSMutableArray* spaceIndexes = [NSMutableArray array];
    NSMutableArray* spaceIndexesUncumm = [NSMutableArray array];
    
    NSMutableArray* substrings = [NSMutableArray array];
    NSString* changedString = [self copy];
    
    NSString* tempString = nil;
    NSUInteger tempLocation = [changedString rangeOfString:@" "].location;
    
    while(tempLocation != NSNotFound)
    {
        NSUInteger cummulatedIndex = tempLocation;
        NSUInteger count = [spaceIndexes count];
        
        if(count>=1)
        {
            cummulatedIndex = [spaceIndexes[count-1] integerValue] + tempLocation + 1;
        }
        
        [spaceIndexes addObject:[NSNumber numberWithInteger:cummulatedIndex]];
        [spaceIndexesUncumm addObject: [NSNumber numberWithInteger:tempLocation]];
         
        tempString = [changedString substringToIndex:tempLocation];
        
        if(tempString!=nil || ![tempString isEqual:@""])
            [substrings addObject: tempString];

        //Prevent going over the string length
        if(changedString.length-1 <= tempLocation)
        {
            break;
        }
            
        changedString = [changedString substringFromIndex:tempLocation+1];
        tempLocation = [changedString rangeOfString:@" "].location;
        
    }
    
    if(changedString!=nil || ![changedString isEqual:@""])
        [substrings addObject:changedString];
    
    // taking double strings
    
    if([spaceIndexes count] >= 2)
    {
//        changedString = [self copy];
        tempString = [self copy];
        int second =1;
        int i =0;
        tempLocation = [spaceIndexes[second] integerValue];
    
        while(tempLocation != NSNotFound)
        {
            tempString = [self substringToIndex:tempLocation];
            if(i>0)
            {
                tempString = [tempString substringFromIndex:[spaceIndexes[i-1] integerValue]+1];
            }
            
            
            if(tempString!=nil || ![tempString isEqual:@""])
                [substrings addObject: tempString];
            

            
            if([spaceIndexes count]-1 <= i+1)
            {
                tempLocation = NSNotFound;
            }
            else
            {
                tempLocation = [spaceIndexes[i+2] integerValue];
            }
            
            i++;

        }
    
        tempString = [self copy];
        if(i>0)
        {
            tempString = [tempString substringFromIndex:[spaceIndexes[i-1] integerValue]+1];
        }
        if(tempString!=nil || ![tempString isEqual:@""])
            [substrings addObject:tempString];
        
    }

    
    return  substrings;
    
}



- (NSString*)getRidOfCharacters
{

    return nil;
}



- (NSString*)trim
{
//    NSCharacterSet* characters = [NSCharacterSet characterSetWithCharactersInString:@" "];
//    
//    return [self stringByTrimmingCharactersInSet:characters];
    NSCharacterSet* characters = [NSCharacterSet characterSetWithCharactersInString:@"~!@#$%^()_=`[]{}\\|; :'\",.<>/?"];

    NSMutableString* tempString = [[self stringByTrimmingCharactersInSet:characters] mutableCopy];
    
    [tempString lowercaseString];
    
    [tempString replaceOccurrencesOfString:@"." withString:@"" options:NSLiteralSearch range:NSMakeRange(0, tempString.length)];
    [tempString replaceOccurrencesOfString:@"," withString:@"" options:NSLiteralSearch range:NSMakeRange(0, tempString.length)];
    [tempString replaceOccurrencesOfString:@"?" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, tempString.length)];
    [tempString replaceOccurrencesOfString:@"!" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, tempString.length)];
    [tempString replaceOccurrencesOfString:@"@" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, tempString.length)];
    [tempString replaceOccurrencesOfString:@"#" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, tempString.length)];
    
    
    return tempString;


}









@end
