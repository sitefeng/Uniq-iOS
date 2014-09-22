//
//  JPDashlet.m
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "JPDashlet.h"
#import "School.h"
#import "Faculty.h"
#import "Program.h"
#import "JPLocation.h"
#import "SchoolLocation.h"
#import "ImageLink.h"
#import "NSObject+JPConvenience.h"
#import "ManagedObjects+JPConvenience.h"


@implementation JPDashlet

- (instancetype)init
{
    self = [super init];
    
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    
    context = [delegate managedObjectContext];
    
    return self;
}


- (instancetype)initWithItemId: (NSString*)itemId withType: (JPDashletType)type
{
    self = [self init];
    
    self.itemId = itemId;
    self.type = type;
    
    ImageLink* backgroundImage = nil;
    
    if(type == JPDashletTypeSchool)
    {
        NSFetchRequest* itemReq = [[NSFetchRequest alloc] initWithEntityName:@"School"];
        itemReq.predicate = [NSPredicate predicateWithFormat:@"schoolId = %@", itemId];
        NSError* err = nil;
        NSArray* schoolResults = [context executeFetchRequest:itemReq error:&err];
        School* school = (School*)[schoolResults firstObject];
        
        self.title = school.name;
        self.population = school.undergradPopulation;
        self.location = [[JPLocation alloc] initWithSchoolLocation:school.location];
        self.icon = [NSURL URLWithString:school.logoUrl];
        backgroundImage = [[school.images allObjects] firstObject];
                                 
    }
    else if(type == JPDashletTypeFaculty)
    {
        NSFetchRequest* itemReq = [[NSFetchRequest alloc] initWithEntityName:@"Faculty"];
        itemReq.predicate = [NSPredicate predicateWithFormat:@"facultyId = %@", itemId];
        NSError* err = nil;
        NSArray* facResults = [context executeFetchRequest:itemReq error:&err];
        Faculty* faculty = (Faculty*)[facResults firstObject];
        
        self.title = faculty.name;
        self.population = faculty.undergradPopulation;
        self.location = [[JPLocation alloc] initWithSchoolLocation:faculty.location];
        backgroundImage = [[faculty.images allObjects] firstObject];
    }
    else if(type == JPDashletTypeProgram)
    {
        NSFetchRequest* itemReq = [[NSFetchRequest alloc] initWithEntityName:@"Program"];
        itemReq.predicate = [NSPredicate predicateWithFormat:@"programId = %@", itemId];
        NSError* err = nil;
        NSArray* progResults = [context executeFetchRequest:itemReq error:&err];
        Program* program = (Program*)[progResults firstObject];
        
        self.title = program.name;
        self.population = program.undergradPopulation;
        self.location = [[JPLocation alloc] initWithSchoolLocation:program.location];
        backgroundImage = [[program.images allObjects] firstObject];
    }
    
    self.backgroundImages = [[NSMutableArray alloc]initWithObjects:[NSURL URLWithString:backgroundImage.imageLink], nil];
    
    return self;
}



#pragma mark - initialization with retrieved data

- (instancetype)initWithSchool:(School *)school
{
    self = [self init];
    if(self)
    {
        self.itemId = school.schoolId;
        
        SchoolLocation* sLoc = school.location;
        float lat = [sLoc.latitude doubleValue];
        float lon = [sLoc.longitude doubleValue];
        
        self.location = [[JPLocation alloc] initWithCooridinates:CGPointMake(lat, lon) city:sLoc.city province:sLoc.region];
        
        self.title = school.name;
        self.type = JPDashletTypeSchool;
        
        self.backgroundImages = [NSMutableArray array];
        
        NSArray* imageLinks = [school.images allObjects];
        for(ImageLink* link in imageLinks)
        {
            NSURL* url = [NSURL URLWithString:link.imageLink];
            if(url)
                [self.backgroundImages addObject:url];
        }
        
        self.population = school.undergradPopulation;
        
        NSURL* url = [NSURL URLWithString:school.logoUrl];
        self.icon = url;
       
        
    }
    
    return self;
}



- (instancetype)initWithFaculty: (Faculty*)faculty
{
    self = [self init];
    if(self)
    {
        self.itemId = faculty.facultyId;
        self.title = faculty.name;
        self.type = JPDashletTypeFaculty;
        
        SchoolLocation* sLoc = faculty.location;
        float lat = [sLoc.latitude doubleValue];
        float lon = [sLoc.longitude doubleValue];
        self.location = [[JPLocation alloc] initWithCooridinates:CGPointMake(lat, lon) city:sLoc.city province:sLoc.region];
        
        self.backgroundImages = [NSMutableArray array];
        
        NSArray* imageLinks = [faculty.images allObjects];
        for(ImageLink* link in imageLinks)
        {
            NSURL* url = [NSURL URLWithString:link.imageLink];
            if(url)
                [self.backgroundImages addObject:url];
        }
        
        self.population = faculty.undergradPopulation;
    }
    
    return self;
}


- (instancetype)initWithProgram: (Program*)program
{
    self = [self init];
    if(self)
    {
        self.itemId = program.programId;
        self.title = program.name;
        self.type = JPDashletTypeProgram;
        
        SchoolLocation* sLoc = program.location;
        float lat = [sLoc.latitude doubleValue];
        float lon = [sLoc.longitude doubleValue];
        self.location = [[JPLocation alloc] initWithCooridinates:CGPointMake(lat, lon) city:sLoc.city province:sLoc.region];
        self.backgroundImages = [NSMutableArray array];
        
        NSArray* imageLinks = [program.images allObjects];
        for(ImageLink* link in imageLinks)
        {
            NSURL* url = [NSURL URLWithString:link.imageLink];
            if(url)
                [self.backgroundImages addObject:url];
        }
        
        self.population = program.undergradPopulation;
    }
    
    return self;
}



- (instancetype)initWithDictionary:(NSDictionary*)dict ofDashletType:(JPDashletType)type
{
    self = [self init];
    if(self)
    {
        self.type = type;
        
        //If the dictionary already contains a managedObject, retrieve it.
        if([dict objectForKey:@"itemObject"])
        {
            self.backgroundImages = [NSMutableArray array];
            if(type == JPDashletTypeSchool)
            {
                School* school = [dict objectForKey:@"itemObject"];
                self.itemId = school.schoolId;
                self.title = school.name;
                self.population = school.undergradPopulation;
                self.location = [[JPLocation alloc] initWithSchoolLocation:school.location];
                
                NSArray* imageLinks = [school.images allObjects];
                for(ImageLink* imageLink in imageLinks)
                {
                    NSURL* imgUrl = [NSURL URLWithString:imageLink.imageLink];
                    if(imgUrl)
                       [self.backgroundImages addObject:imgUrl];
                }
                
                self.icon = [NSURL URLWithString:school.logoUrl];
                
            }
            else if(type == JPDashletTypeFaculty)
            {
                Faculty* faculty = [dict objectForKey:@"itemObject"];
                self.itemId = faculty.facultyId;
                self.title = faculty.name;
                self.population = faculty.undergradPopulation;
                self.location = [[JPLocation alloc] initWithSchoolLocation:faculty.location];
                
                NSArray* imageLinks = [faculty.images allObjects];
                for(ImageLink* imageLink in imageLinks)
                {
                    NSURL* imgUrl = [NSURL URLWithString:imageLink.imageLink];
                    if(imgUrl)
                        [self.backgroundImages addObject:imgUrl];
                }

            }
            else if(type == JPDashletTypeProgram)
            {
                Program* program = [dict objectForKey:@"itemObject"];
                self.itemId = program.programId;
                self.title = program.name;
                self.population = program.undergradPopulation;
                self.location = [[JPLocation alloc] initWithSchoolLocation:program.location];
                
                NSArray* imageLinks = [program.images allObjects];
                for(ImageLink* imageLink in imageLinks)
                {
                    NSURL* imgUrl = [NSURL URLWithString:imageLink.imageLink];
                    if(imgUrl)
                        [self.backgroundImages addObject:imgUrl];
                }
            }
        }
        else //if dictionary is raw info from server
        {
            self.itemId = [dict objectForKey:@"id"];
            self.title = [dict objectForKey:@"name"];
            NSString* populationStr = [dict objectForKey:@"undergradPopulation"];
            self.population = [self numberFromNumberString:populationStr];
            self.location = [[JPLocation alloc] initWithLocationDict:[dict objectForKey:@"location"]];
            
            self.backgroundImages = [NSMutableArray array];
            
            NSArray* imageDicts = [dict objectForKey:@"images"];
            for(NSDictionary* imageDict in imageDicts)
            {
                NSString* type = [imageDict objectForKey:@"type"];
                NSString* urlStr = [imageDict objectForKey:@"link"];
                NSURL* imgURL = [NSURL URLWithString:urlStr];
                if(!imgURL)
                    continue;
                
                if([type isEqual:@"logo"])
                {
                    self.icon = imgURL;
                }
                else
                {
                    [self.backgroundImages addObject:imgURL];
                }
            }
        }
        
    }
    return self;
}



- (BOOL)isFavorited
{
    NSFetchRequest* favItemReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
    favItemReq.predicate = [NSPredicate predicateWithFormat:@"favItemId = %@", self.itemId];
    NSArray* favResult = [context executeFetchRequest:favItemReq error:nil];
    
    if([favResult count]>0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}



#pragma mark - Comparision Methods


- (NSComparisonResult)compareWithName:(JPDashlet *)otherDashlet {
    return [self.title compare:otherDashlet.title];
    
}

- (NSComparisonResult)compareWithLocation:(JPDashlet *)otherDashlet {
    
    return [self.title compare:otherDashlet.title];
    
}

- (NSComparisonResult)compareWithAverage:(JPDashlet *)otherDashlet {
    return [self.title compare:otherDashlet.title];
    
}

- (NSComparisonResult)compareWithPopulation:(JPDashlet *)otherDashlet {
    return [self.title compare:otherDashlet.title];
    
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"D-> %@[%@]", self.title, self.itemId];
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    JPDashlet* dashlet = [[JPDashlet alloc] init];
    
    dashlet.itemId = self.itemId;
    dashlet.location = [self.location copyWithZone:zone];
    
    dashlet.title = [self.title copyWithZone:zone];
    dashlet.type = self.type;
    dashlet.backgroundImages = [self.backgroundImages copyWithZone:zone];
    dashlet.icon = [self.icon copy];
    
    return dashlet;
}












@end
