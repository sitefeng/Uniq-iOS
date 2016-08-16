//
//  JPProgramRatingHelper.m
//  Uniq
//
//  Created by Si Te Feng on 8/14/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPProgramRatingHelper.h"
#import "JPRatings.h"
#import "SVStatusHUD.h"
#import "TRVSMonitor.h"

#import "JPFirebaseCentral.h"

// temporarily deprecated

@implementation JPProgramRatingHelper


- (instancetype)init
{
    self = [super init];
    
    return self;
}



//Get average value for the program, check if user already voted
//change the avg accordingly and upload back, then change personal ratings

- (void)uploadRatingsWithProgramUid: (NSString*)uid ratings:(JPRatings*)ratings
{
    NSString* avgReqString = [NSString stringWithFormat:
                               @"%@/ratings/%@/avg.json", FirebaseBaseURL, uid];
    
    NSURL* avgReqURL = [NSURL URLWithString:avgReqString];
    NSMutableURLRequest* avgRequest = [NSMutableURLRequest requestWithURL:avgReqURL];
    [avgRequest setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:avgRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(connectionError)
        {
            NSLog(@"Error Retrieving average value: %@", connectionError.localizedDescription);
            [SVStatusHUD showWithImage:[UIImage imageNamed:@"uploadFailedHUD"] status:@"Offline Mode"];
            return;
        }
        
        //Get user's previous ratings
        NSDictionary* userDict = [self downloadRatingsSynchronouslyWithProgramUid:uid getAverageValue:NO];
        if([userDict objectForKey:@"error"] != nil)
            return;
        
        //Average dictionary
        NSDictionary* averageDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        //No one posted ratings before
        if(!averageDict || [averageDict isEqual: [NSNull null]])
        {
            [self uploadSpecificRatingsWithProgramId:uid ratings:ratings averageWeight:1];
            
        }
        else //averge ratings exists
        {
            JPRatings* avgRatings = [[JPRatings alloc] initWithShortKeyDictionary:averageDict];
            NSInteger avgWeight = [[averageDict objectForKey:@"w"] integerValue];
            
            if(!userDict) //User rating for first time
            {
                JPRatings* newRatings = [ratings getNewAvgRatingByAppendingAvg:avgRatings withWeight:avgWeight];
                [self uploadSpecificRatingsWithProgramId:uid ratings:newRatings averageWeight:avgWeight+1];
            }
            else //User changing the rating
            {
                JPRatings* updatedRatings = ratings;
                JPRatings* previousUserRatings = [[JPRatings alloc] initWithShortKeyDictionary:userDict];
                
                JPRatings* newAverage = [updatedRatings getNewAvgRatingByUpdatingAvg:avgRatings withWeight:avgWeight withOldUserRatings:previousUserRatings];
                
                [self uploadSpecificRatingsWithProgramId:uid ratings:newAverage averageWeight:avgWeight];
            }
        }
        
        [self uploadSpecificRatingsWithProgramId:uid ratings:ratings averageWeight:0];
        
    }];
    
    
}


//Just upload the user/average rating without anything else
- (void)uploadSpecificRatingsWithProgramId: (NSString*)uid ratings: (JPRatings*)ratings averageWeight: (NSInteger)avgWeight //0 means is not average
{
    NSString* deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    if(avgWeight > 0)
        deviceId = @"avg";
    NSString* uploadStr = [NSString stringWithFormat:
                           @"%@/ratings/%@/%@.json", FirebaseBaseURL,uid,deviceId];
    
    NSURL* uploadURL = [NSURL URLWithString:uploadStr];
    
    NSMutableDictionary* ratingsDict = [[ratings getShortKeyDictionaryRepresentation] mutableCopy];
    if(avgWeight == 0)
        [ratingsDict setObject:@1 forKey:@"w"];
    else
        [ratingsDict setObject:[NSNumber numberWithInteger:avgWeight] forKey:@"w"];
    
    NSData* ratingsData = [NSJSONSerialization dataWithJSONObject:ratingsDict options:0 error:nil];
    
    NSMutableURLRequest* postReq = [[NSMutableURLRequest alloc] initWithURL:uploadURL];
    [postReq setHTTPMethod:@"PUT"];
    [postReq setHTTPBody:ratingsData];
    
    [NSURLConnection sendAsynchronousRequest:postReq queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(connectionError)
        {
            NSLog(@"Post Ratings Error: %@", connectionError.localizedDescription);
            [self.delegate ratingHelper:self didUploadRatingsForProgramUid:uid error:connectionError];
            [SVStatusHUD showWithImage:[UIImage imageNamed:@"uploadFailedHUD"] status:@"Offline Mode"];
            return;
        }
        
        if(avgWeight == 0) //alert user if user ratings are sent
        {
            [SVStatusHUD showWithImage:[UIImage imageNamed:@"uploadCompleteHUD"] status:@"Ratings Sent"];
            [self.delegate ratingHelper:self didUploadRatingsForProgramUid:uid error:connectionError];
        }
        
        
    }];
    
}



#pragma mark - Downloading Ratings

- (void)downloadRatingsWithProgramUid:(NSString *)uid getAverageValue: (BOOL)isAverage completionHandler: (void (^)(BOOL success, JPRatings *ratings))completion {
    
    NSString* deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    if(isAverage)
        deviceId = @"avg";
    
    NSString* downloadStr = [NSString stringWithFormat:
                           @"%@/ratings/%@/%@.json", FirebaseBaseURL, uid,deviceId];
    
    NSURL* downloadURL = [NSURL URLWithString:downloadStr];
    
    NSMutableURLRequest* getReq = [[NSMutableURLRequest alloc] initWithURL:downloadURL];
    [getReq setHTTPMethod:@"GET"];

    [NSURLConnection sendAsynchronousRequest:getReq queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
        if(connectionError)
        {
            JPLog(@"Download connectionError: %@", connectionError.localizedDescription);
            completion(NO, nil);
            return;
        }
        
        NSDictionary* dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        JPRatings *ratings = [[JPRatings alloc] initWithDefaultValues];
        
        if([dataDict isEqual: [NSNull null]] || !dataDict)
        {
            JPLog(@"Program rating does not exist, returning generic blank program rating");
            // Continue anyway
            completion(YES, ratings);
        }
        else
        {
            ratings = [[JPRatings alloc] initWithShortKeyDictionary:dataDict];
            completion(YES, ratings);
        }
        
    }];
    
}



- (NSDictionary*)downloadRatingsSynchronouslyWithProgramUid:(NSString *)uid getAverageValue:(BOOL)isAverage
{
    NSString* deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    if(isAverage)
        deviceId = @"avg";
    
    NSString* downloadStr = [NSString stringWithFormat:
                             @"%@/ratings/%@/%@.json", FirebaseBaseURL, uid,deviceId];
    
    NSURL* downloadURL = [NSURL URLWithString:downloadStr];
    
    NSMutableURLRequest* getReq = [[NSMutableURLRequest alloc] initWithURL:downloadURL];
    [getReq setHTTPMethod:@"GET"];
    
    __block NSDictionary* ratingDict = nil;
    
    NSError* connectionError = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:getReq returningResponse:nil error:&connectionError];
    
    if(connectionError)
    {
        NSLog(@"private Download connectionError: %@", connectionError.localizedDescription);
        return @{@"error": @"error"};
    }
    
    NSDictionary* dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    if([dataDict isEqual: [NSNull null]] || !dataDict)
    {
        ratingDict = nil;
    }
    else {
        ratingDict = dataDict;
    }
    
    return ratingDict;
    
}





@end
