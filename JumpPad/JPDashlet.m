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


- (instancetype)initWithDashletUid: (NSInteger)uid
{
    self = [super init];
    if(self)
    {
        self.dashletUid = uid;
        
        //Retrieve Info from CoreData and fill in ALL Properties Automatically
        
        //Code!!!!!!!!!!!!!!!!
        
        
    }
    
    return self;
}


- (instancetype)initWithSchool:(School *)school
{
    self = [super init];
    if(self)
    {
        self.dashletUid = (int)([school.schoolId floatValue] * pow(10, 6));
        
        SchoolLocation* sLoc = school.location;
        
        float lat = [sLoc.lattitude doubleValue];
        float lon = [sLoc.longitude doubleValue];
        
        self.location = [[JPLocation alloc] initWithCooridinates:CGPointMake(lat, lon) city:sLoc.city ];
        
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
        
        self.yearEstablished = school.yearEstablished;
        self.population = school.population;
        
        NSURL* url = [NSURL URLWithString:school.logoUrl];
        self.icon = url;
       
        
    }
    
    return self;
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
    return [NSString stringWithFormat:@"Dashlet for %@[%ld]", self.title, (long)self.dashletUid];
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
