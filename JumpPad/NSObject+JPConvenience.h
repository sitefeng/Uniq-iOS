//
//  NSObject_JPConvenience.h
//  Uniq
//
//  Created by Si Te Feng on 9/1/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JPConvenience)



- (NSNumber*)numberFromNumberString: (NSString*)string; //@"47,291" -> @4729
- (NSNumber*)numberFromPhoneString: (NSString*)string; //@"416-498" -> @416498






- (JPDashletType)dashletTypeFromTypeString: (NSString*)type;






@end
