//
//  RelatedItem.h
//  Uniq
//
//  Created by Si Te Feng on 9/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Faculty, Program, School;

@interface RelatedItem : NSManagedObject

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * itemId;
@property (nonatomic, retain) Program *program;
@property (nonatomic, retain) Faculty *faculty;
@property (nonatomic, retain) School *school;

@end
