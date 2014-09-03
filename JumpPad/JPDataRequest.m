//
//  JPDataRequest.m
//  Uniq
//
//  Created by Si Te Feng on 8/30/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPDataRequest.h"


@implementation JPDataRequest


+ (instancetype)sharedRequest
{
    static JPDataRequest* _sharedRequest = nil;
    
    @synchronized(self)
    {
        if(!_sharedRequest)
        {
            _sharedRequest = [[JPDataRequest alloc] init];
            
            _sharedRequest.basePath = @"http://192.168.0.18:8000";
            
        }
    }
    
    return _sharedRequest;
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


- (void)requestItemDetailsWithId:(NSString *)itemId ofType:(JPDashletType)type
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
            
            if([self.delegate respondsToSelector:@selector(dataRequest:didLoadItemDetailsWithId:ofType:dataDict:isSuccessful:)])
                [self.delegate dataRequest:self didLoadItemDetailsWithId:itemId ofType:type dataDict:nil isSuccessful:NO];
            return;
        }
        
        NSDictionary* dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if([self.delegate respondsToSelector:@selector(dataRequest:didLoadItemDetailsWithId:ofType:dataDict:isSuccessful:)])
            [self.delegate dataRequest:self didLoadItemDetailsWithId:itemId ofType:type dataDict:dataDict isSuccessful:YES];
    
    }];

}





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
