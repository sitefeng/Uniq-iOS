//
//  JPKnowledgeEngineParser.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-27.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  NSManagedObjectContext;
@interface JPKnowledgeEngineInterpreter : NSObject
{
    NSManagedObjectContext* context;
    
    NSString*   _modifiedString;
    NSMutableArray*     _querySubstrings;
    
    NSMutableArray* _functionArray;

    
    
    NSString*  _companionString; //for
    
    NSString*  _locationString; //within
    
}





@property (nonatomic, strong) NSString* queryString;


@property (nonatomic, strong, readonly) NSString* functionName;
@property (nonatomic, strong, readonly) NSString* category;

@property (nonatomic, strong, readonly) NSString* responseTitle;
@property (nonatomic, strong, readonly) NSArray*  responseData; //An array of information based on the query type.

//responsedate types
@property (nonatomic, assign, readonly) NSInteger numberOfData;
@property (nonatomic, strong, readonly) NSArray* dataTypes;//array of NSString







- (id)initWithQueryString: (NSString*)string;

- (void)interpret;

@end
