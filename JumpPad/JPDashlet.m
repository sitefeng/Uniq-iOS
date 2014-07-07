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

@implementation JPDashlet


#pragma mark - initialization with item id only

- (instancetype)initWithDashletUid: (NSUInteger)uid
{
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    context = [delegate managedObjectContext];
    
    NSUInteger schoolInt = uid / 1000000;
    
    NSUInteger facultyInt = (uid % 1000000) / 1000;
    NSUInteger programInt = uid % 1000;
    
    NSUInteger facultyUid = schoolInt*1000000 + facultyInt * 1000;
    
    self = [super init];
    
    if(self)
    {
        if(programInt == 0) //not a program
        {
            if(facultyInt == 0) //not a faculty, should be a school
            {
                NSFetchRequest* schoolReq = [[NSFetchRequest alloc] initWithEntityName:@"School"];
                
                schoolReq.predicate = [NSPredicate predicateWithFormat:@"schoolId = %@", [NSNumber numberWithInteger:schoolInt]];
                
                NSArray* schoolResult = [context executeFetchRequest:schoolReq error:nil];
                
                self = [self initWithSchool:(School *)[schoolResult firstObject]];
                
            }
            else //is a faculty
            {
                NSFetchRequest* facultyReq = [[NSFetchRequest alloc] initWithEntityName:@"Faculty"];
                facultyReq.predicate = [NSPredicate predicateWithFormat:@"facultyId = %@", [NSNumber numberWithInteger:facultyInt]];
                NSArray* facultyResult = [context executeFetchRequest:facultyReq error:nil];
                
                self = [self initWithFaculty:(Faculty *)[facultyResult firstObject] fromSchool:schoolInt*1000000];
            }
        }
        else //is a program
        {
            NSFetchRequest* programReq = [[NSFetchRequest alloc] initWithEntityName:@"Program"];
            programReq.predicate = [NSPredicate predicateWithFormat:@"programId = %@", [NSNumber numberWithInteger:programInt]];
            NSArray* programResult = [context executeFetchRequest:programReq error:nil];
            
            self = [self initWithProgram:(Program*)[programResult firstObject] fromFaculty:facultyUid];
            
        }
    
    }
    
    
    return self;
}




#pragma mark - initialization with retrieved data

- (instancetype)initWithSchool:(School *)school
{
    self = [super init];
    if(self)
    {
        self.dashletUid = [school.schoolId integerValue] * 1000000;
        
        SchoolLocation* sLoc = school.location;
        
        float lat = [sLoc.lattitude doubleValue];
        float lon = [sLoc.longitude doubleValue];
        
        self.location = [[JPLocation alloc] initWithCooridinates:CGPointMake(lat, lon) city:sLoc.city province:sLoc.province];
        
        self.title = school.name;
        self.featuredTitle = self.title;
        self.type = JPDashletTypeSchool;
        
        self.backgroundImages = [NSMutableArray array];
        
        NSArray* imageLinks = [school.images allObjects];
        for(ImageLink* link in imageLinks)
        {
            NSURL* url = [NSURL URLWithString:link.imageLink];
            if(url)
                [self.backgroundImages addObject:url];
        }
        
        self.population = school.population;
        
        NSURL* url = [NSURL URLWithString:school.logoUrl];
        self.icon = url;
       
        
    }
    
    return self;
}



- (instancetype)initWithFaculty: (Faculty*)faculty fromSchool: (NSInteger)schoolDashletUid
{
    self = [super init];
    if(self)
    {
        NSUInteger partialFaculty = [faculty.facultyId integerValue];
        self.dashletUid = schoolDashletUid + partialFaculty * 1000;
        
        self.title = faculty.name;
        self.featuredTitle = [faculty.name stringByAppendingString:[NSString stringWithFormat:@", %@", faculty.school.name]];
        self.type = JPDashletTypeFaculty;
        
        SchoolLocation* sLoc = faculty.school.location;
        float lat = [sLoc.lattitude doubleValue];
        float lon = [sLoc.longitude doubleValue];
        self.location = [[JPLocation alloc] initWithCooridinates:CGPointMake(lat, lon) city:sLoc.city province:sLoc.province];
        
        self.backgroundImages = [NSMutableArray array];
        
        NSArray* imageLinks = [faculty.images allObjects];
        for(ImageLink* link in imageLinks)
        {
            NSURL* url = [NSURL URLWithString:link.imageLink];
            if(url)
                [self.backgroundImages addObject:url];
        }
        
        self.population = faculty.population;
        
    }
    
    return self;

}



- (instancetype)initWithProgram: (Program*)program fromFaculty:(NSInteger)facultyDashletUid {
    
    self = [super init];
    if(self)
    {
        NSUInteger partialprogram = [program.programId integerValue];
        
        self.dashletUid = facultyDashletUid + partialprogram;
        
        self.title = program.name;
        self.featuredTitle = [program.name stringByAppendingString:[NSString stringWithFormat:@", %@", program.faculty.school.name]];
        self.type = JPDashletTypeProgram;
        
        SchoolLocation* sLoc = program.faculty.school.location;
        float lat = [sLoc.lattitude doubleValue];
        float lon = [sLoc.longitude doubleValue];
        self.location = [[JPLocation alloc] initWithCooridinates:CGPointMake(lat, lon) city:sLoc.city province:sLoc.province];
        self.backgroundImages = [NSMutableArray array];
        
        NSArray* imageLinks = [program.images allObjects];
        for(ImageLink* link in imageLinks)
        {
            NSURL* url = [NSURL URLWithString:link.imageLink];
            if(url)
                [self.backgroundImages addObject:url];
        }
        
        self.population = program.population;

    }
    
    return self;
}


- (BOOL)isFavorited
{
    NSFetchRequest* favItemReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
    favItemReq.predicate = [NSPredicate predicateWithFormat:@"itemId = %@", [NSNumber numberWithInteger:self.dashletUid]];
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
    return [NSString stringWithFormat:@"Dashlet-> %@[%ld]", self.title, (long)self.dashletUid];
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    JPDashlet* dashlet = [[JPDashlet alloc] init];
    
    dashlet.dashletUid = self.dashletUid;
    dashlet.location = [self.location copyWithZone:zone];
    
    dashlet.title = [self.title copyWithZone:zone];
    dashlet.type = self.type;
    dashlet.backgroundImages = [self.backgroundImages copyWithZone:zone];
    dashlet.icon = [self.icon copy];
    
    return dashlet;
}












@end
