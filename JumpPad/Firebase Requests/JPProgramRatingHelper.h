//
//  JPProgramRatingHelper.h
//  Uniq
//
//  Created by Si Te Feng on 8/14/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JPProgramRatingHelperDelegate;
@class JPRatings;
@interface JPProgramRatingHelper : NSObject <NSURLConnectionDataDelegate>


@property (nonatomic, weak) id<JPProgramRatingHelperDelegate> delegate;


- (void)uploadRatingsWithProgramUid: (NSString*)uid ratings:(JPRatings*)ratings;

/**
 * @param isAverage if true means get the average ratings of all the users, if false means get the rating for the current user based on UIDevice Id
 */
- (void)downloadRatingsWithProgramUid:(NSString *)uid getAverageValue: (BOOL)isAverage completionHandler: (void (^)(BOOL success, JPRatings *ratings))completion;

@end


@protocol JPProgramRatingHelperDelegate <NSObject>

@optional
- (void)ratingHelper: (JPProgramRatingHelper*)helper didUploadRatingsForProgramUid: (NSString*)uid error: (NSError*)error;

@end