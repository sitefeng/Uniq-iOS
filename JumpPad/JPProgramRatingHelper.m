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


//Firebase Link:  https://uniq.firebaseio.com

@implementation JPProgramRatingHelper


- (instancetype)init
{
    self = [super init];
    
    return self;
}




- (void)uploadRatingsWithProgramUid: (NSString*)uid ratings:(JPRatings*)ratings
{
    NSString* deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString* uploadStr = [NSString stringWithFormat:
                           @"https://uniq.firebaseio.com/ratings/%@/%@.json",uid,deviceId];
    
    NSURL* uploadURL = [NSURL URLWithString:uploadStr];
    
    NSMutableDictionary* ratingsDict = [[ratings getShortKeyDictionaryRepresentation] mutableCopy];
    [ratingsDict setObject:@1 forKey:@"w"];
    NSData* ratingsData = [NSJSONSerialization dataWithJSONObject:ratingsDict options:0 error:nil];
    
    NSMutableURLRequest* postReq = [[NSMutableURLRequest alloc] initWithURL:uploadURL];
    [postReq setHTTPMethod:@"PUT"];
    [postReq setHTTPBody:ratingsData];
    
    [NSURLConnection sendAsynchronousRequest:postReq queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [self.delegate ratingHelper:self didUploadRatingsForProgramUid:uid error:connectionError];
        
        if(connectionError)
        {
            NSLog(@"Post Ratings Error: %@", connectionError.localizedDescription);
            [SVStatusHUD showWithImage:[UIImage imageNamed:@"uploadFailedHUD"] status:@"Currently Offline"];
            return;
        }
        
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"uploadCompleteHUD"] status:@"Ratings Sent"];
        
    }];
    
    
}



- (void)downloadRatingsWithProgramUid:(NSString *)uid
{
    NSString* deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString* downloadStr = [NSString stringWithFormat:
                           @"https://uniq.firebaseio.com/ratings/%@/%@.json",uid,deviceId];
    
    NSURL* downloadURL = [NSURL URLWithString:downloadStr];
    
    NSMutableURLRequest* getReq = [[NSMutableURLRequest alloc] initWithURL:downloadURL];
    [getReq setHTTPMethod:@"GET"];

    [NSURLConnection sendAsynchronousRequest:getReq queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
        if(connectionError)
        {
            NSLog(@"Download connectionError: %@", connectionError.localizedDescription);
            [self.delegate ratingHelper:self didDownloadRatingsForProgramUid:uid ratings:nil ratingExists:NO networkError:connectionError];
            return;
        }
        
        NSDictionary* dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if([dataDict isEqual:[NSNull null]])
        {
            [self.delegate ratingHelper:self didDownloadRatingsForProgramUid:uid ratings:nil ratingExists:NO networkError:nil];
        }
        else
        {
            JPRatings* ratings = [[JPRatings alloc] initWithShortKeyDictionary:dataDict];
            [self.delegate ratingHelper:self didDownloadRatingsForProgramUid:uid ratings:ratings ratingExists:YES networkError:nil];
        }
        
    }];
    
    
    
}





@end
