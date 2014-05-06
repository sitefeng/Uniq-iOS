//
//  ApplicationConstants.h
//  JumpPad
//
//  Created by Si Te Feng on 12/5/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#ifndef JumpPad_ApplicationConstants_h
#define JumpPad_ApplicationConstants_h


#pragma mark - Helper Functions

#define CGRectMakeWithOriginXYAndSize(originX, originY, size) CGRectMake(originX, originY, size.width, size.height)

#define jpp(x,y)      CGPointMake(x,y)
#define jps(w,h)      CGSizeMake(w,h)
#define jpr(x,y,w,h)  CGRectMake(x,y,w,h)



#pragma mark - Default Names

#define kSearchBarPlaceholderText @"Filter for Name"



#define MIXPANEL_TOKEN @"5b5fabc80437ba330dd37ae889f26dae"




#pragma mark - Typedef Enums

typedef enum
{
    JPSortTypeAlphabetical = 0,
    JPSortTypeClosest,
    JPSortTypeHighestEntryAvg,
    JPSortTypeLargestCollege
}JPSortType;


typedef enum
{
    JPDashletTypeSchool,
    JPDashletTypeFaculty,
    JPDashletTypeProgram
    
}JPDashletType;





#pragma mark - Debug Tools

#ifdef DEBUG
#define JPLog(fmt, ...) NSLog((@"%s [%d]: " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define log(fmt, ...) NSLog((@"[%d]: " fmt), __LINE__, ##__VA_ARGS__);

#define debugMode YES

#else

#define log(x...)
#define JPLog(x...)

#define debugMode NO

#endif





#endif
