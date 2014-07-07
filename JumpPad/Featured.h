//
//  Featured.h
//  Uniq
//
//  Created by Si Te Feng on 7/6/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Featured : NSManagedObject

@property (nonatomic, retain) NSNumber * featuredId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * linkedUrl;
@property (nonatomic, retain) NSNumber * linkedUid;
@property (nonatomic, retain) NSString * imageLink;

@end
