//
//  SchoolRanking.h
//  Uniq
//
//  Created by Si Te Feng on 9/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class School;

@interface SchoolRanking : NSManagedObject

@property (nonatomic, retain) NSNumber * ranking;
@property (nonatomic, retain) NSString * rankingSource;
@property (nonatomic, retain) NSNumber * schoolRankingId;
@property (nonatomic, retain) School *school;

@end
