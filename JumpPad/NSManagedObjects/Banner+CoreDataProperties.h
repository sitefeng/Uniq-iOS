//
//  Banner+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Banner.h"

NS_ASSUME_NONNULL_BEGIN

@interface Banner (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *bannerId;
@property (nullable, nonatomic, retain) NSString *bannerLink;
@property (nullable, nonatomic, retain) NSString *linkedUrl;
@property (nullable, nonatomic, retain) NSString *title;

@end

NS_ASSUME_NONNULL_END
