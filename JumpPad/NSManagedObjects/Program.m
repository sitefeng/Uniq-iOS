//
//  Program.m
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//

#import "Program.h"
#import "Contact.h"
#import "Faculty.h"
#import "HighschoolCourse.h"
#import "ImageLink.h"
#import "ImportantDate.h"
#import "ProgramApplicationStat.h"
#import "ProgramCourse.h"
#import "ProgramRating.h"
#import "ProgramYearlyTuition.h"
#import "RelatedItem.h"
#import "SchoolLocation.h"

#import "JPLocation.h"
#import "Uniq-Swift.h"

@implementation Program

- (JPLocation *)requestLocationSynchronously {
    
    JPOfflineDataRequest *requst = [[JPOfflineDataRequest alloc] init];
    return [requst requestLocationForSchool:self.schoolSlug];
}

@end
