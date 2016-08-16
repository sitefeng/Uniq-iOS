//
//  JPCloudFavoritesHelper.m
//  Uniq
//
//  Created by Si Te Feng on 8/23/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPCloudFavoritesHelper.h"
#import "JPFirebaseCentral.h"


@implementation JPCloudFavoritesHelper


- (void)uploadItemFavoritedWithUid:(NSString *)uid
{
    //Check if favorited program exists in user's list first
    NSString* deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    //Gets list of program uids for the device
    NSString* getURLStr = [NSString stringWithFormat:@"%@/favorites/userFavs/%@.json", FirebaseBaseURL, deviceUUID];
    
    NSURL* getURL = [NSURL URLWithString:getURLStr];
    
    NSMutableURLRequest* getReq = [[NSMutableURLRequest alloc] initWithURL:getURL];
    getReq.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:getReq queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
        if(connectionError)
        {
            NSLog(@"Get User Fav list Error: %@", connectionError.localizedDescription);
            [self.delegate cloudFavHelper:self didFinishUploadItemFavoritedWithUid:uid itemExistsAlready:YES success:NO];
            return;
        }
        
        //Increment firebase program fav count, and add program uid to user fav list if neccessary
        
        NSArray* programUids = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        BOOL uidExistsOnFirebase = NO;
        int currFavNum = 0;
        
        if(![programUids isEqual:[NSNull null]])
        {
            for(NSString* firebaseUid in programUids)
            {
                currFavNum++;
                if([firebaseUid isEqual: uid])
                    uidExistsOnFirebase = YES;
            }
        }
        
        if(uidExistsOnFirebase)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate cloudFavHelper:self didFinishUploadItemFavoritedWithUid:uid itemExistsAlready:YES success:YES];
            });
        }
        else
        {
            BOOL success = [self addProgramToUserFavListWithUid:uid currentFavNum: currFavNum];
            [self incrementProgramFavCountWithUid:uid];
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                if(success)
                {
                    [self.delegate cloudFavHelper:self didFinishUploadItemFavoritedWithUid:uid itemExistsAlready:YES success:YES];
                } else {
                    [self.delegate cloudFavHelper:self didFinishUploadItemFavoritedWithUid:uid itemExistsAlready:NO success:NO];
                }
                
            });
        }
        
    }];
    
}

/** If programUid has not been uploaded to the cloud previously,
 *  This method handles cloud data initialization
 *  To be used internally
 */

//fav num is the number of favorited programs for the device
//returns success status
- (BOOL)addProgramToUserFavListWithUid:(NSString*)programUid currentFavNum: (int)favNum;
{
    NSString* deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSString* reqURLStr = [NSString stringWithFormat:@"%@/favorites/userFavs/%@.json", FirebaseBaseURL, deviceUUID];
    NSURL* reqURL = [NSURL URLWithString:reqURLStr];
    
    NSMutableURLRequest* patchRequest = [[NSMutableURLRequest alloc] initWithURL:reqURL];
    
    patchRequest.HTTPMethod = @"PATCH";
    
    NSString* patchDataStr = [NSString stringWithFormat:@"{\"%i\" : \"%@\"}", favNum, programUid];
    patchRequest.HTTPBody = [patchDataStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError* error;
    [NSURLConnection sendSynchronousRequest:patchRequest returningResponse:nil error:&error];

    if(error)
    {
        NSLog(@"Add Program To Fav list Error: %@", error.localizedDescription);
        return NO;
    }
    
    return YES;
}


// If the programUid has already been initialized on the cloud
// To be used internally
//Returns success status
- (void)incrementProgramFavCountWithUid: (NSString*)programUid
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSInteger numFavsBefore = [self getItemFavCountSyncWithUid:programUid];
        
        if(numFavsBefore == -1) {
            return;
        }
        
        NSNumber* numFavsAfter = [NSNumber numberWithInteger:numFavsBefore+1];
        
        ///////////////////////////////////////////////
        //Write Incremented Count To Firebase
        NSString* putURLStr = [NSString stringWithFormat:@"%@/favorites/count/%@.json", FirebaseBaseURL, programUid];
        NSURL* putURL = [NSURL URLWithString:putURLStr];
        
        NSMutableURLRequest* putRequest = [[NSMutableURLRequest alloc] initWithURL:putURL];
        putRequest.HTTPMethod = @"PUT";
        
        NSString* numAfterString = [NSString stringWithFormat:@"%@", numFavsAfter];
        NSData* newNumData = [numAfterString dataUsingEncoding:NSUTF8StringEncoding];
        putRequest.HTTPBody = newNumData;
        
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:putRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                JPLog(@"cloud favorites Error: %@", error);
                return;
            }
            
            JPLog(@"Uploaded. Incremented program favorite count. [resp: %@]", response);
            
        }];
        
        [task resume];
        
    });
    
}


- (void)getItemFavCountAsyncWithUid:(NSString *)programUid completionHandler: (void (^)(BOOL success, NSInteger favoriteCount))completion {
    //Get Current Favorite Count
    NSString* getURLStr = [NSString stringWithFormat:@"%@/favorites/count/%@.json", FirebaseBaseURL, programUid];
    
    NSURL* getURL = [NSURL URLWithString:getURLStr];
    
    NSMutableURLRequest* getReq = [[NSMutableURLRequest alloc] initWithURL:getURL];
    getReq.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:getReq queue:[NSOperationQueue currentQueue] completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
         if(connectionError)
         {
             NSLog(@"Increment Connection error:%@", connectionError.localizedDescription);
             completion(NO, 0);
             return;
         }
         
         NSData* numFavsData = data;
         ///////////////////////////////////
         //Calculation
         NSNumber* numFavsBefore = @0;
         
         if(numFavsData)
             numFavsBefore = [NSJSONSerialization JSONObjectWithData:numFavsData options:NSJSONReadingAllowFragments error:nil];
         
         if(!numFavsBefore || [numFavsBefore isEqual:[NSNull null]])
             numFavsBefore = @0;
         
         NSInteger favNumInteger = [numFavsBefore integerValue];
         completion(YES, favNumInteger);
    }];

}


- (NSInteger)getItemFavCountSyncWithUid:(NSString *)programUid
{
    if (!programUid.length) {
        NSLog(@"Error: programUid is empty!");
        return 0;
    }
    //Get Current Favorite Count
    NSString* getURLStr = [NSString stringWithFormat:@"%@/favorites/count/%@.json", FirebaseBaseURL, programUid];
    
    NSURL* getURL = [NSURL URLWithString:getURLStr];
    
    NSMutableURLRequest* getReq = [[NSMutableURLRequest alloc] initWithURL:getURL];
    getReq.HTTPMethod = @"GET";
    
    NSError* connectionError;
    NSData* numFavsData = [NSURLConnection sendSynchronousRequest:getReq returningResponse:nil error:&connectionError];
    
    if(connectionError)
    {
        NSLog(@"Increment Connection error:%@", connectionError.localizedDescription);
        return -1;
    }
    
    ///////////////////////////////////
    //Calculation
    NSNumber* numFavsBefore = @0;
    
    if(numFavsData)
        numFavsBefore = [NSJSONSerialization JSONObjectWithData:numFavsData options:NSJSONReadingAllowFragments error:nil];
    
    if(!numFavsBefore || [numFavsBefore isEqual:[NSNull null]])
        numFavsBefore = @0;
    
    return [numFavsBefore integerValue];
    
}


@end


