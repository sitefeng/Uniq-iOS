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
    
//    self.basePath = @"http://192.168.0.44:8000";
    self.basePath = @"http://uniq-env-mdwnryqp7y.elasticbeanstalk.com";
    
    _connectivity = [JPConnectivityManager sharedManager];
    
    
    return self;
}


- (void)requestAllSchoolsAllFields:(BOOL)allFields
{
    if(![_connectivity isReachable])
    {
        JPCoreDataHelper* coreDataHelper = [[JPCoreDataHelper alloc] init];
        NSArray* dictArray = [coreDataHelper retrieveItemsArrayFromCoreDataWithParentItemId:nil withChildType:JPDashletTypeSchool];
        if([self.delegate respondsToSelector:@selector(dataRequest:didLoadAllItemsOfType:allFields:withDataArray:isSuccessful:)])
            [self.delegate dataRequest:self didLoadAllItemsOfType:JPDashletTypeSchool allFields:allFields withDataArray:dictArray isSuccessful:YES];
        NSLog(@"Loaded School List from Core Data");
        return;
    }
    
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
            
            [self.delegate dataRequest:self didLoadAllItemsOfType:JPDashletTypeSchool allFields:allFields withDataArray:nil isSuccessful:NO];
            return;
        }
        
        NSArray* dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        [self.delegate dataRequest:self didLoadAllItemsOfType:JPDashletTypeSchool allFields:allFields withDataArray:dataArray isSuccessful:YES];
    }];
}


- (void)requestAllFacultiesFromSchool:(NSString *)schoolId allFields:(BOOL)allFields
{
    if(![_connectivity isReachable])
    {
        JPCoreDataHelper* coreDataHelper = [[JPCoreDataHelper alloc] init];
        NSArray* dictArray = [coreDataHelper retrieveItemsArrayFromCoreDataWithParentItemId:schoolId withChildType:JPDashletTypeFaculty];
        if([self.delegate respondsToSelector:@selector(dataRequest:didLoadAllItemsOfType:allFields:withDataArray:isSuccessful:)])
            [self.delegate dataRequest:self didLoadAllItemsOfType:JPDashletTypeFaculty allFields:allFields withDataArray:dictArray isSuccessful:YES];
        NSLog(@"Loaded Faculty List from Core Data");
        return;
    }
    
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
    if(![_connectivity isReachable])
    {
        JPCoreDataHelper* coreDataHelper = [[JPCoreDataHelper alloc] init];
        NSArray* dictArray = [coreDataHelper retrieveItemsArrayFromCoreDataWithParentItemId:facultyId withChildType:JPDashletTypeProgram];
        if([self.delegate respondsToSelector:@selector(dataRequest:didLoadAllItemsOfType:allFields:withDataArray:isSuccessful:)])
            [self.delegate dataRequest:self didLoadAllItemsOfType:JPDashletTypeProgram allFields:allFields withDataArray:dictArray isSuccessful:YES];
        NSLog(@"Loaded Program List from Core Data");
        return;
    }
    
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
        NSMutableDictionary *itemDetailsDict = [mainDict mutableCopy];
        _itemDetailExpectedReturnNumber = 1;
        
        _cloudFavHelper = [[JPCloudFavoritesHelper alloc] init];
        _cloudFavHelper.delegate = self;
        
        NSInteger favNum = [_cloudFavHelper getItemFavCountSyncWithUid:itemId];
        [itemDetailsDict setObject:[NSNumber numberWithInteger:favNum] forKey:@"numFavorites"];
        
        //Adding Ratings from Firebase
        _ratingHelper = [[JPProgramRatingHelper alloc] init];
        _ratingHelper.delegate = self;
        [_ratingHelper downloadRatingsWithProgramUid:itemId getAverageValue:YES completionHandler:^(BOOL success, JPRatings *ratings) {
            
            NSDictionary *ratingsDict = ratings.getFullKeyDictionaryRepresentation;
            [itemDetailsDict setObject:ratingsDict forKey:@"rating"];
            
            _itemDetailExpectedReturnNumber--;
            
            [self.delegate dataRequest:self didLoadItemDetailsWithId:itemId ofType:type dataDict:itemDetailsDict isSuccessful:YES];
        }];
      
    }];
}


//Without Ratings & Favorites from Firebase
- (void)requestItemBriefDetailsWithId: (NSString*)itemId ofType: (JPDashletType)type
{
    if(![_connectivity isReachable])
    {
        JPCoreDataHelper* coreDataHelper = [[JPCoreDataHelper alloc] init];
        NSDictionary* dataDict = [coreDataHelper retrieveItemDictionaryFromCoreDataWithItemId:itemId withType:type];
        
        if([self.delegate respondsToSelector:@selector(dataRequest:didLoadItemBriefDetailsWithId:ofType:dataDict:isSuccessful:)]) {
            if(dataDict)
                [self.delegate dataRequest:self didLoadItemBriefDetailsWithId:itemId ofType:type dataDict:dataDict isSuccessful:YES];
            else
                [self.delegate dataRequest:self didLoadItemBriefDetailsWithId:itemId ofType:type dataDict:nil isSuccessful:NO];
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
            
            if([self.delegate respondsToSelector:@selector(dataRequest:didLoadItemBriefDetailsWithId:ofType:dataDict:isSuccessful:)])
                [self.delegate dataRequest:self didLoadItemBriefDetailsWithId:itemId ofType:type dataDict:nil isSuccessful:NO];
            return;
        }
        
        NSDictionary* dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if([self.delegate respondsToSelector:@selector(dataRequest:didLoadItemBriefDetailsWithId:ofType:dataDict:isSuccessful:)])
            [self.delegate dataRequest:self didLoadItemBriefDetailsWithId:itemId ofType:type dataDict:dataDict isSuccessful:YES];
        
    }];

    
}



#pragma mark - Featured Items

- (void)requestAllFeaturedItems
{
    NSString* requestPath = [self.basePath stringByAppendingString:@"/featured"];
    
    NSURL* reqURL = [NSURL URLWithString:requestPath];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:reqURL];
    req.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(connectionError)
        {
            NSLog(@"Connection Error: %@", connectionError.localizedDescription);
            
            if([self.delegate respondsToSelector:@selector(dataRequest:didLoadAllFeaturedItems:isSuccessful:)])
                [self.delegate dataRequest:self didLoadAllFeaturedItems:nil isSuccessful:NO];
            return;
        }

        NSArray* featuredArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if([self.delegate respondsToSelector:@selector(dataRequest:didLoadAllFeaturedItems:isSuccessful:)])
            [self.delegate dataRequest:self didLoadAllFeaturedItems:featuredArray isSuccessful:YES];
        
        
    }];
    
}





@end
