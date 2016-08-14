//
//  User+CoreDataProperties.h
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *currentAvg;
@property (nullable, nonatomic, retain) NSString *interest;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSString *locationString;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSData *profileImage;
@property (nullable, nonatomic, retain) NSNumber *satGrammar;
@property (nullable, nonatomic, retain) NSNumber *satMath;
@property (nullable, nonatomic, retain) NSNumber *satReading;
@property (nullable, nonatomic, retain) NSSet<HighschoolCourse *> *courses;
@property (nullable, nonatomic, retain) NSSet<UserFavItem *> *favItems;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(HighschoolCourse *)value;
- (void)removeCoursesObject:(HighschoolCourse *)value;
- (void)addCourses:(NSSet<HighschoolCourse *> *)values;
- (void)removeCourses:(NSSet<HighschoolCourse *> *)values;

- (void)addFavItemsObject:(UserFavItem *)value;
- (void)removeFavItemsObject:(UserFavItem *)value;
- (void)addFavItems:(NSSet<UserFavItem *> *)values;
- (void)removeFavItems:(NSSet<UserFavItem *> *)values;

@end

NS_ASSUME_NONNULL_END
