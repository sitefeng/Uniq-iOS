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

#import "Uniq-Swift.h"


@implementation JPDashlet

- (instancetype)init
{
    self = [super init];
    
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    
    context = [delegate managedObjectContext];
    
    return self;
}


- (instancetype)initFromCoreDataWithItemId: (NSString*)itemId withType: (JPDashletType)type {
    self = [self init];
    
    self.itemId = itemId;
    self.type = type;
    
    if(type == JPDashletTypeSchool)
    {
        NSFetchRequest* itemReq = [[NSFetchRequest alloc] initWithEntityName:@"School"];
        itemReq.predicate = [NSPredicate predicateWithFormat:@"schoolId = %@", itemId];
        NSError* err = nil;
        NSArray* schoolResults = [context executeFetchRequest:itemReq error:&err];
        School* school = (School*)[schoolResults firstObject];
        
        [self initializeWithSchool:school];
                                 
    }
    else if(type == JPDashletTypeFaculty)
    {
        NSFetchRequest* itemReq = [[NSFetchRequest alloc] initWithEntityName:@"Faculty"];
        itemReq.predicate = [NSPredicate predicateWithFormat:@"facultyId = %@", itemId];
        NSError* err = nil;
        NSArray* facResults = [context executeFetchRequest:itemReq error:&err];
        Faculty* faculty = (Faculty*)[facResults firstObject];
        
        [self initializeWithFaculty:faculty];
    }
    else if(type == JPDashletTypeProgram)
    {
        NSFetchRequest* itemReq = [[NSFetchRequest alloc] initWithEntityName:@"Program"];
        itemReq.predicate = [NSPredicate predicateWithFormat:@"programId = %@", itemId];
        NSError* err = nil;
        NSArray* progResults = [context executeFetchRequest:itemReq error:&err];
        Program* program = (Program*)[progResults firstObject];
        
        [self initializeWithProgram:program];
    }
    
    return self;
}



#pragma mark - initialization with retrieved data

- (instancetype)initWithSchool:(School *)school
{
    self = [self init];
    if(self) {
        [self initializeWithSchool:school];
    }
    
    return self;
}


- (instancetype)initWithFaculty: (Faculty*)faculty
{
    self = [self init];
    if(self) {
        [self initializeWithFaculty:faculty];
    }
    
    return self;
}


- (instancetype)initWithProgram: (Program*)program
{
    self = [self init];
    if(self) {
        [self initializeWithProgram:program];
    }
    
    return self;
}


- (void)initializeWithSchool: (School *)school {
    self.itemId = school.schoolId;
    self.schoolSlug = school.slug;
    
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
    self.population = school.undergradPopulation;
    self.icon = [NSURL URLWithString:school.logoUrl];
}


- (void)initializeWithFaculty: (Faculty *)faculty {
    self.itemId = faculty.facultyId;
    self.facultySlug = faculty.slug;
    self.schoolSlug = faculty.schoolSlug;
    
    self.title = faculty.name;
    self.population = faculty.undergradPopulation;
    self.location = [[JPLocation alloc] initWithSchoolLocation:faculty.location];
    self.location = [self swapToSchoolLocationIfNecessary:self.location schoolSlug:faculty.schoolSlug];
    
    NSArray* imageLinks = [faculty.images allObjects];
    for(ImageLink* imageLink in imageLinks)
    {
        NSURL* imgUrl = [NSURL URLWithString:imageLink.imageLink];
        if(imgUrl)
            [self.backgroundImages addObject:imgUrl];
    }
    self.population = faculty.undergradPopulation;

}

- (void)initializeWithProgram: (Program *)program {
    self.itemId = program.programId;
    self.programSlug = program.slug;
    self.facultySlug = program.facultySlug;
    self.schoolSlug = program.schoolSlug;
    
    self.title = program.name;
    self.population = program.undergradPopulation;
    self.location = [[JPLocation alloc] initWithSchoolLocation:program.location];
    self.location = [self swapToSchoolLocationIfNecessary: self.location schoolSlug:program.schoolSlug];
    
    NSArray* imageLinks = [program.images allObjects];
    for(ImageLink* imageLink in imageLinks)
    {
        NSURL* imgUrl = [NSURL URLWithString:imageLink.imageLink];
        if(imgUrl)
            [self.backgroundImages addObject:imgUrl];
    }
    self.population = program.undergradPopulation;
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
                [self initializeWithSchool: school];
            }
            else if(type == JPDashletTypeFaculty)
            {
                Faculty* faculty = [dict objectForKey:@"itemObject"];
                [self initializeWithFaculty: faculty];
            }
            else if(type == JPDashletTypeProgram)
            {
                Program* program = [dict objectForKey:@"itemObject"];
                [self initializeWithProgram: program];
            }
        }
        else //if dictionary is raw info from server
        {
            self.itemId = [dict objectForKey:@"id"];
            
            if (type == JPDashletTypeSchool) {
                self.schoolSlug = [dict objectForKey:@"slug"];
            } else if (type == JPDashletTypeFaculty) {
                self.schoolSlug = [dict objectForKey:@"schoolSlug"];
                self.facultySlug = [dict objectForKey:@"slug"];
            } else if (type == JPDashletTypeProgram) {
                self.schoolSlug = [dict objectForKey:@"schoolSlug"];
                self.facultySlug = [dict objectForKey:@"facultySlug"];
                self.programSlug = [dict objectForKey:@"slug"];
            }
            
            self.title = [dict objectForKey:@"name"];
            NSString* populationStr = [dict objectForKey:@"undergradPopulation"];
            self.population = [self numberFromNumberString:populationStr];
            
            NSDictionary *locationDict = [dict objectForKey:@"location"];
            
            // if location dictionary is empty (in the case of a program), trace back to the school location
            if ([locationDict isEqual:[NSNull null]] || locationDict.allKeys.count == 0) {
                NSString *schoolSlug = [dict objectForKey:@"schoolSlug"];
                JPOfflineDataRequest *offlineRequest = [[JPOfflineDataRequest alloc] init];
                self.location = [offlineRequest requestLocationForSchool:schoolSlug];
            } else {
                self.location = [[JPLocation alloc] initWithLocationDict:locationDict];
            }
            
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


- (JPLocation *)swapToSchoolLocationIfNecessary: (JPLocation *)location schoolSlug: (NSString *)slug {
    if (location.cityName.length > 0) {
        return location;
    }
    
    JPOfflineDataRequest *offlineRequest = [[JPOfflineDataRequest alloc] init];
    return [offlineRequest requestLocationForSchool:slug];
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
