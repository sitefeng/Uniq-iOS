//
//  ImportantDate.h
//  Uniq
//
//  Created by Si Te Feng on 2/10/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Faculty, Program;

@interface ImportantDate : NSManagedObject

@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * descriptor;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) Faculty *faculty;
@property (nonatomic, retain) Program *program;

@end
