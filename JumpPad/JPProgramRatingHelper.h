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

- (void)downloadRatingsWithProgramUid: (NSString*)uid getAverageValue: (BOOL)isAverage;


@end


@protocol JPProgramRatingHelperDelegate <NSObject>

- (void)ratingHelper: (JPProgramRatingHelper*)helper didUploadRatingsForProgramUid: (NSString*)uid error: (NSError*)error;

- (void)ratingHelper:(JPProgramRatingHelper *)helper didDownloadRatingsForProgramUid:(NSString *)uid ratings: (JPRatings*)ratings ratingExists: (BOOL)exists networkError: (NSError*)error;

@end