//
//  RelatedItem.h
//  Uniq
//
//  Created by Si Te Feng on 2/10/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Faculty, Program, School;

@interface RelatedItem : NSManagedObject

@property (nonatomic, retain) NSString * itemId;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) Faculty *faculty;
@property (nonatomic, retain) Program *program;
@property (nonatomic, retain) School *school;

@end
