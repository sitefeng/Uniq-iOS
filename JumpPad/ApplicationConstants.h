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

#define kSearchBarPlaceholderText @"Filter Universities (search coming soon)"











#pragma mark - Debug Tools

#ifdef DEBUG
#define JPLog(fmt, ...) NSLog((@"%s [%d]: " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#define log(fmt, ...) NSLog((@"[%d]: " fmt), __LINE__, ##__VA_ARGS__);

#else

#define log(x...)
#define JPLog(x...)

#endif





#endif
