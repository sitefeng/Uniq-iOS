//
//  JPItemUID.h
//  JumpPad
//
//  Created by Si Te Feng on 12/11/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

//This Class represents a unique identifier for either a college, faculty, or program
//The following UID can be handled by this class:
/*
 
 -> 0001-001-001  (10 digit code separated by dashes in NSString form)
 
 -> 0001001001    (10 digit code in NSString form)
 
 */

@interface JPItemUID : NSString






+ (JPItemUID*)itemUIDFromString: (NSString*)string;



- (NSUInteger)collegeNumber;
- (NSUInteger)facultyNumber;
- (NSUInteger)programNumber;




// implementing later
//- (NSString*)collegeName;
//- (NSUInteger)facultyName;
//- (NSUInteger)programName;







@end
