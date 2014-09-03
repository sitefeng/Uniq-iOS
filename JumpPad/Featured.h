//
//  Featured.h
//  Uniq
//
//  Created by Si Te Feng on 9/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Featured : NSManagedObject

@property (nonatomic, retain) NSString * imageLink;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * itemId;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * subtitle;

@end
