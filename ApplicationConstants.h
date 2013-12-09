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

#define ccp(x,y) CGPointMake(x,y)







#pragma mark - Debug Tools

#ifdef DEBUG
#define JPLog(fmt, ...) NSLog((@"%s [%d]: " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#define log(fmt, ...) NSLog((@"[%d]: " fmt), __LINE__, ##__VA_ARGS__);

#else

#define log(x...)
#define JPLog(x...)

#endif





#endif
