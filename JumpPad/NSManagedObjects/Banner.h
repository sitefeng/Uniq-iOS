//
//  Banner.h
//  Uniq
//
//  Created by Si Te Feng on 2/10/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Banner : NSManagedObject

@property (nonatomic, retain) NSNumber * bannerId;
@property (nonatomic, retain) NSString * bannerLink;
@property (nonatomic, retain) NSString * linkedUrl;
@property (nonatomic, retain) NSString * title;

@end
