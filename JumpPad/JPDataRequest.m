//
//  JPDataRequest.m
//  Uniq
//
//  Created by Si Te Feng on 8/30/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPDataRequest.h"
#import "JPProgramRatingHelper.h"
#import "JPRatings.h"
#import "JPConnectivityManager.h"
#import "JPCoreDataHelper.h"


@implementation JPDataRequest


+ (instancetype)request
{
    JPDataRequest* request = [[JPDataRequest alloc] init];
    
    return request;
}


- (instancetype)init
{
    self = [super init];
    
    self.basePath = @"http://192.168.0.18:8000";
    
    _connectivity = [JPConnectivityManager sharedManager];
    
    
    return self;
}


- (void)requestAllSchoolsAllFields:(BOOL)allFields
{
    NSString* requestPath = @"";
    if(allFields)
        requestPath = [self.basePath stringByAppendingString:@"/schools"];
    else
        requestPath = [self.basePath stringByAppendingString:@"/explore/schools"];
    
    NSURL* reqURL = [NSURL URLWithString:requestPath];
    
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:reqURL];
    req.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(connectionError)
        {
            NSLog(@"Connection Error: %@", connectionError.localizedDescription);
            [SVStatusHUD showWithImage:[UIImage imageNamed:@"noWifi"] status:@"Offline Mode"];
            [self.delegate dataRequest:self didLoadAllItemsOfType:JPDashletTypeSchool allFields:allFields withDataArray:nil isSuccessful:NO];
            return;
        }
        
        NSArray* dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        [self.delegate dataRequest:self didLoadAllItemsOfType:JPDashletTypeSchool allFields:allFields withDataArray:dataArray isSuccessful:YES];
    }];
}


- (void)requestAllFacultiesFromSchool:(NSString *)schoolId allFields:(BOOL)allFields
{
    NSString* requestPath = @"";
    if(allFields) {
        requestPath = [self.basePath stringByAppendingFormat:@"/schools/%@/faculties",schoolId];
    }
    else {
        requestPath = [self.basePath stringByAppendingFormat:@"/explore/faculties/%@",schoolId];
    }
    
    NSURL* reqURL = [NSURL URLWithString:requestPath];
    
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:reqURL];
    req.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(connectionError)
        {
            NSLog(@"Connection Error: %@", connectionError.localizedDescription);
            [self.delegate dataRequest:self didLoadAllItemsOfType:JPDashletTypeFaculty allFields:allFields withDataArray:nil isSuccessful:NO];
            return;
        }
        
        NSArray* dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        [self.delegate dataRequest:self didLoadAllItemsOfType:JPDashletTypeFaculty allFields:allFields withDataArray:dataArray isSuccessful:YES];
    }];

}


- (void)requestAllProgramsFromFaculty:(NSString *)facultyId allFields:(BOOL)allFields
{
    NSString* requestPath = @"";
    if(allFields) {
        requestPath = [self.basePath stringByAppendingFormat:@"/faculties/%@/programs",facultyId];
    }
    else {
        requestPath = [self.basePath stringByAppendingFormat:@"/explore/programs/%@",facultyId];
    }
    
    NSURL* reqURL = [NSURL URLWithString:requestPath];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:reqURL];
    req.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(connectionError)
        {
            NSLog(@"Connection Error: %@", connectionError.localizedDescription);
            [self.delegate dataRequest:self didLoadAllItemsOfType:JPDashletTypeProgram allFields:allFields withDataArray:nil isSuccessful:NO];
            return;
        }
        
        NSArray* dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        [self.delegate dataRequest:self didLoadAllItemsOfType:JPDashletTypeProgram allFields:allFields withDataArray:dataArray isSuccessful:YES];
    }];
    
}



#pragma mark - Request Item Details

//With Ratings & favorites as well
- (void)requestItemDetailsWithId:(NSString *)itemId ofType:(JPDashletType)type
{
    if(![_connectivity isReachable])
    {
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"noWifi"] status:@"Offline Mode"];
        JPCoreDataHelper* coreDataHelper = [[JPCoreDataHelper alloc] init];
        NSDictionary* dataDict = [coreDataHelper retrieveItemDictionaryFromCoreDataWithItemId:itemId withType:type];
        
        if([self.delegate respondsToSelector:@selector(dataRequest:didLoadItemDetailsWithId:ofType:dataDict:isSuccessful:)])
        {
            if(dataDict)
                [self.delegate dataRequest:self didLoadItemDetailsWithId:itemId ofType:type dataDict:dataDict isSuccessful:YES];
            else
                [self.delegate dataRequest:self didLoadItemDetailsWithId:itemId ofType:type dataDict:nil isSuccessful:NO];
        }
        
        return;
    }
         
    NSString* requestPath = @"";
    
    if(type == JPDashletTypeSchool)
    {
        requestPath = [self.basePath stringByAppendingFormat:@"/schools/%@", itemId];
    }
    else if(type == JPDashletTypeFaculty)
    {
        requestPath = [self.basePath stringByAppendingFormat:@"/faculties/%@", itemId];
    }
    else if(type == JPDashletTypeProgram)
    {
        requestPath = [self.basePath stringByAppendingFormat:@"/programs/%@", itemId];
    }
    
    NSURL* reqURL = [NSURL URLWithString:requestPath];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:reqURL];
    req.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(connectionError)
        {
            NSLog(@"Connection Error: %@", connectionError.localizedDescription);
            
            if([self.delegate respondsToSelector:@selector(dataRequest:didLoadItemDetailsWithId:ofType:dataDict:isSuccessful:)])
                [self.delegate dataRequest:self didLoadItemDetailsWithId:itemId ofType:type dataDict:nil isSuccessful:NO];
            return;
        }
        
        NSDictionary* mainDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        _itemDetailsDictWithoutRatings = [mainDict mutableCopy];
        _itemDetailType = type;
        _itemDetailExpectedReturnNumber = 1;
        
        _cloudFavHelper = [[JPCloudFavoritesHelper alloc] init];
        _cloudFavHelper.delegate = self;
        NSInteger favNum = [_cloudFavHelper getItemFavCountWithUid:itemId];
        [_itemDetailsDictWithoutRatings setObject:[NSNumber numberWithInteger:favNum] forKey:@"numFavorites"];
        
        //Adding Ratings from Firebase
        _ratingHelper = [[JPProgramRatingHelper alloc] init];
        _ratingHelper.delegate = self;
        [_ratingHelper downloadRatingsWithProgramUid:itemId getAverageValue:YES];
      

    }];

}


- (void)ratingHelper:(JPProgramRatingHelper *)helper didDownloadRatingsForProgramUid:(NSString *)uid ratings:(JPRatings *)ratings ratingExists:(BOOL)exists networkError:(NSError *)error
{
    if(error)
    {
        NSLog(@"Firebase avg rating network Error: %@", error.localizedDescription);
        if([self.delegate respondsToSelector:@selector(dataRequest:didLoadItemDetailsWithId:ofType:dataDict:isSuccessful:)])
            [self.delegate dataRequest:self didLoadItemDetailsWithId:uid ofType:JPDashletTypeProgram dataDict:nil isSuccessful:NO];
        return;
    }
    
    if(!exists)
    {
        NSArray* orderedArray = @[@50.00,@50.00,@50.00,@50.00,@50.00,@50.00,@50.00,@50.00];
        ratings = [[JPRatings alloc] initWithOrderedArray:orderedArray];
    }
    
    NSMutableDictionary* newDict = [_itemDetailsDictWithoutRatings mutableCopy];
    NSMutableDictionary* ratingsDict = [[ratings getFullKeyDictionaryRepresentation] mutableCopy];
    
    double guyRatioNotUsingFirebaseIfExistsOnServer = [[ratingsDict objectForKey:@"guyRatio"] doubleValue];
    
    //Get Guy Ratio from Amazon Server
    if([_itemDetailsDictWithoutRatings objectForKey:@"rating"] != [NSNull null])
    {
        NSDictionary* serverRatingDict = [_itemDetailsDictWithoutRatings objectForKey:@"rating"];
        if([serverRatingDict objectForKey:@"guyRatio"] != [NSNull null])
            guyRatioNotUsingFirebaseIfExistsOnServer = [[serverRatingDict objectForKey:@"guyRatio"] doubleValue];
    }
                                          
    [ratingsDict setObject:[NSNumber numberWithDouble:guyRatioNotUsingFirebaseIfExistsOnServer] forKey:@"guyRatio"];
    [newDict setObject:ratingsDict forKey:@"rating"];
    
    _itemDetailExpectedReturnNumber--;
    
    if([self.delegate respondsToSelector:@selector(dataRequest:didLoadItemDetailsWithId:ofType:dataDict:isSuccessful:)] && _itemDetailExpectedReturnNumber<=0)
        [self.delegate dataRequest:self didLoadItemDetailsWithId:uid ofType:_itemDetailType dataDict:newDict isSuccessful:YES];
}







//Without Ratings & Favorites from Firebase
- (void)requestItemBriefDetailsWithId: (NSString*)itemId ofType: (JPDashletType)type
{
    NSString* requestPath = @"";
    
    if(type == JPDashletTypeSchool)
    {
        requestPath = [self.basePath stringByAppendingFormat:@"/schools/%@", itemId];
    }
    else if(type == JPDashletTypeFaculty)
    {
        requestPath = [self.basePath stringByAppendingFormat:@"/faculties/%@", itemId];
    }
    else if(type == JPDashletTypeProgram)
    {
        requestPath = [self.basePath stringByAppendingFormat:@"/programs/%@", itemId];
    }
    
    NSURL* reqURL = [NSURL URLWithString:requestPath];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:reqURL];
    req.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(connectionError)
        {
            NSLog(@"Connection Error: %@", connectionError.localizedDescription);
            
            if([self.delegate respondsToSelector:@selector(dataRequest:didLoadItemBriefDetailsWithId:ofType:dataDict:isSuccessful:)])
                [self.delegate dataRequest:self didLoadItemBriefDetailsWithId:itemId ofType:type dataDict:nil isSuccessful:NO];
            return;
        }
        
        NSDictionary* dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if([self.delegate respondsToSelector:@selector(dataRequest:didLoadItemBriefDetailsWithId:ofType:dataDict:isSuccessful:)])
            [self.delegate dataRequest:self didLoadItemBriefDetailsWithId:itemId ofType:type dataDict:dataDict isSuccessful:YES];
        
    }];

    
}











@end
