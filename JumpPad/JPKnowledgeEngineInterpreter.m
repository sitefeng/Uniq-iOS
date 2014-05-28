//
//  JPKnowledgeEngineParser.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-27.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPKnowledgeEngineInterpreter.h"

#import "UniqKEOne.h"
#import "UniqKEKeyword.h"
#import "UniqKEFunction.h"

#import "NSString+JPKnowledgeEngine.h"
#import "Program.h"
#import "Faculty.h"
#import "School.h"

@interface JPKnowledgeEngineInterpreter()

//Redeclaration for editability
@property (nonatomic, strong) NSString* functionName;
@property (nonatomic, strong) NSString* category;

@property (nonatomic, strong) NSString* responseTitle;
@property (nonatomic, strong) NSArray*  responseData;

@property (nonatomic, assign) NSInteger numberOfData;
@property (nonatomic, strong) NSArray* dataTypes;


@end


@implementation JPKnowledgeEngineInterpreter


- (id)initWithQueryString: (NSString*)string
{
    self = [super init];
    if(self)
    {
        JumpPadAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        context = delegate.managedObjectContext;
        
        _functionArray = [NSMutableArray array];
        
        
        self.queryString = string;
        
        [self syncKnowledgeEngine];
        
        
    }
    
    return self;
}


- (void)syncKnowledgeEngine
{
    NSFetchRequest* engineRequest = [NSFetchRequest fetchRequestWithEntityName:@"UniqKEOne"];
    NSArray* knowledgeEngine = [context executeFetchRequest:engineRequest error:nil];
    
    NSManagedObject* knowledgeOne;
    
    if([knowledgeEngine count] != 1)
    {
        for(UniqKEOne* ke in knowledgeEngine)
        {
            [context deleteObject:ke];
        }
        
        NSEntityDescription* keDescription= [NSEntityDescription entityForName:@"UniqKEOne" inManagedObjectContext:context];
         knowledgeOne = [[NSManagedObject alloc] initWithEntity:keDescription insertIntoManagedObjectContext:context];
        [context insertObject:knowledgeOne];
    }
    else
    {
        knowledgeOne = [knowledgeEngine firstObject];
    }
    
    //Delete the Entities to be updated if it already exists in Core Data DB
    NSFetchRequest* functionRequest = [NSFetchRequest fetchRequestWithEntityName:@"UniqKEFunction"];
    functionRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"schoolId" ascending:YES]];
    
    NSArray* response = [context executeFetchRequest:functionRequest error:nil];
    
    for(UniqKEFunction* function in response)
    {
        [context deleteObject:function];
    }

    
    //Readding the file contents
    NSError* error = nil;
    NSArray* jsonEngineArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:@"UniqKnowledgeEngineOne.json"] options:NSJSONReadingMutableContainers error: &error];
    
    if(error)
    {
        JPLog(@"KE sync error: %@", error);
    }
    
    for(NSDictionary* functionDict in jsonEngineArray)
    {
        //Add the function Entities
        NSEntityDescription* schoolDescription = [NSEntityDescription entityForName:@"UniqKEFunction" inManagedObjectContext:context];
        
        UniqKEFunction *newFunction = (UniqKEFunction*)[[NSManagedObject alloc] initWithEntity:schoolDescription insertIntoManagedObjectContext:context];
        
        if([functionDict valueForKey:@"name"] != [NSNull null])
           [newFunction setValue:@"name" forKey:@"name"];
        if([functionDict valueForKey:@"category"] != [NSNull null])
            [newFunction setValue:@"category" forKey:@"category"];
        if([functionDict valueForKey:@"keywords"] != [NSNull null])
            [newFunction setValue:@"keywords" forKey:@"keywords"];
        
        [newFunction setValue:knowledgeOne forKey:@"knowledgeEngine"];
        
        
        
        for(id keyword in [functionDict valueForKey:@"keywords"])
        {
            NSEntityDescription* keywordDisc = [NSEntityDescription entityForName:@"UniqKEKeyword" inManagedObjectContext:context];
            
            NSManagedObject* keywordObj = [[NSManagedObject alloc] initWithEntity:keywordDisc insertIntoManagedObjectContext:context];
            
            if(keyword != [NSNull null])
            {
                [keywordObj setValue:@"keyword" forKey:@"keyword"];
                [newFunction addKeywordsObject:keywordObj];
            }
            
        }
        
        
        
    }
    
    error = nil;
    [context save:&error];
    
    if(error)
    {
        JPLog(@"KE sync save error: %@", error);
    }
    
}



- (void)interpret
{
    _modifiedString = [self.queryString trim];
    
    _querySubstrings = [_modifiedString getAllSubstrings];

    _functionArray = nil;
    
    for(NSString* querySubstring in _querySubstrings)
    {
        NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"UniqKEKeyword"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"keyword" ascending:YES]];
        request.fetchLimit = 5;
        request.predicate = [NSPredicate predicateWithFormat:@"keyword == %@",querySubstring];
        
        NSArray* array = [context executeFetchRequest:request error:nil];
        
        if([array count]>0)
        {
            [_querySubstrings removeObject:querySubstring];
        }
        
        for(UniqKEKeyword* keyword in array)
        {
            [_functionArray addObject: keyword.function];
        }
    }
    
    
    
    NSLog(@"Number of Functions associated: %i", [_functionArray count]);
    
    UniqKEFunction* function = [_functionArray firstObject];
    
    
    self.category = function.category;
    self.functionName = function.name;

    
    if([function.category isEqual:@"program"])
    {
        
        [self analyzeProgramQuery];
        
        
    }

    
    
    
    
    
    
    
    
    
    
}





- (void)analyzeProgramQuery
{
    
    UniqKEFunction* function = [_functionArray firstObject];
    

    NSMutableArray* results = nil;
    
    for(NSString* query in _querySubstrings)
    {
        NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Program"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
        request.fetchLimit = 50;
        request.predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@",query];
        
        NSArray* array = [context executeFetchRequest:request error:nil];
        
        for(Program* program in array)
        {
            [results addObject:program];
        }

    }
    
    Program* result = [results firstObject];
    
    _companionString = [result name];
    _locationString = result.faculty.school.name;
    
    
    id answer = [result valueForKey: function.name];
    
    if([function.name isEqual:@"tuitions"])
    {
        answer = [[answer anyObject] valueForKey:@"domesticTuition"];
    }
    
    self.responseTitle = [NSString stringWithFormat:@"The %@ for %@ within %@ is: %@", function.name, _companionString, _locationString, answer];
    
    JPLog(@"self.responseTitle: %@", self.responseTitle);
        
        
        

    
    
    
    
}





















@end
