//
//  Banner.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-11.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Banner : NSManagedObject

@property (nonatomic, retain) NSNumber * bannerId;
@property (nonatomic, retain) NSString * bannerLink;
@property (nonatomic, retain) NSString * linkedUrl;
@property (nonatomic, retain) NSString * title;

@end
