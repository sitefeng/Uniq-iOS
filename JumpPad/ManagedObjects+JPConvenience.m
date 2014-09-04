//
//  ManagedObjects+JPConvenience.m
//  Uniq
//
//  Created by Si Te Feng on 9/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "ManagedObjects+JPConvenience.h"
#import "NSObject+JPConvenience.h"


@implementation School (JPConvenience)

- (instancetype)initWithDictionary: (NSDictionary*)dict
{
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [delegate managedObjectContext];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"School" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    if([dict objectForKey:@"about"] != [NSNull null])
        self.about = [dict objectForKey:@"about"];
    if([dict objectForKey:@"alumniNumber"] != [NSNull null])
        self.alumniNumber = [self numberFromNumberString: [dict objectForKey:@"alumniNumber"]];
    if([dict objectForKey:@"avgAdm"] != [NSNull null])
        self.avgAdm = [[NSDecimalNumber alloc] initWithString: [dict objectForKey:@"avgAdm"]];
    if([dict objectForKey:@"gradPopulation"] != [NSNull null])
        self.gradPopulation = [self numberFromNumberString:[dict objectForKey:@"gradPopulation"]];
    if([dict objectForKey:@"logoUrl"] != [NSNull null])
        self.logoUrl = [dict objectForKey:@"logoUrl"];
    if([dict objectForKey:@"name"] != [NSNull null])
        self.name = [dict objectForKey:@"name"];
    if([dict objectForKey:@"numFaculties"] != [NSNull null])
        self.numFaculties = [NSNumber numberWithLong:[[dict objectForKey:@"numFaculties"] longValue]];
    if([dict objectForKey:@"id"] != [NSNull null])
        self.schoolId = [dict objectForKey:@"id"];
    if([dict objectForKey:@"totalFunding"] != [NSNull null])
        self.totalFunding = [self numberFromNumberString:[dict objectForKey:@"totalFunding"]];
    if([dict objectForKey:@"undergradPopulation"] != [NSNull null])
        self.undergradPopulation = [self numberFromNumberString:[dict objectForKey:@"undergradPopulation"]];
    if([dict objectForKey:@"yearEstablished"] != [NSNull null])
        self.yearEstablished = [NSNumber numberWithLong:[[dict objectForKey:@"yearEstablished"] longValue]];

    if([dict objectForKey:@"contacts"] != [NSNull null])
    {
        NSArray* contactsArray = [dict objectForKey:@"contacts"];
        NSMutableSet* contactsSet = [[NSMutableSet alloc] init];
        for(NSDictionary* contactDict in contactsArray)
        {
            Contact* contact = [[Contact alloc] initWithDictionary:contactDict];
            [contactsSet addObject:contact];
        }
        self.contacts = contactsSet;
    }
    
    
    if([dict objectForKey:@"images"] != [NSNull null])
    {
        NSArray* imageDictArray = [dict objectForKey:@"images"];
        NSMutableSet* imageSet = [[NSMutableSet alloc] init];
        
        for(NSDictionary* imageDict in imageDictArray)
        {
            if([[imageDict objectForKey:@"type"] isEqual:@"logo"])
            {
                NSString* logoStr = [imageDict objectForKey:@"link"];
                if([logoStr isKindOfClass:[NSString class]])
                    self.logoUrl = logoStr;
            }
            else
            {
                ImageLink* imageLink = [[ImageLink alloc] initWithDictionary:imageDict];
                [imageSet addObject:imageLink];
            }
        }
        self.images = imageSet;
        
    }
    
    if([dict objectForKey:@"location"] != [NSNull null])
    {
        SchoolLocation* schoolLoc = [[SchoolLocation alloc] initWithDictionary:[dict objectForKey:@"location"]];
        
        self.location = schoolLoc;
    }

    
    return self;
}


- (NSDictionary*)dictionaryRepresentation
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    
    return dict;
}



@end


@implementation Faculty (JPConvenience)


- (instancetype)initWithDictionary: (NSDictionary*)dict
{
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [delegate managedObjectContext];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Faculty" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    if([dict objectForKey:@"about"] != [NSNull null])
        self.about = [dict objectForKey:@"about"];
    if([dict objectForKey:@"alumniNumber"] != [NSNull null])
        self.alumniNumber = [self numberFromNumberString: [dict objectForKey:@"alumniNumber"]];
    if([dict objectForKey:@"avgAdm"] != [NSNull null])
        self.avgAdm = [[NSDecimalNumber alloc] initWithString: [dict objectForKey:@"avgAdm"]];
    if([dict objectForKey:@"gradPopulation"] != [NSNull null])
        self.gradPopulation = [self numberFromNumberString:[dict objectForKey:@"gradPopulation"]];
    if([dict objectForKey:@"logoUrl"] != [NSNull null])
        self.logoUrl = [dict objectForKey:@"logoUrl"];
    if([dict objectForKey:@"name"] != [NSNull null])
        self.name = [dict objectForKey:@"name"];
    if([dict objectForKey:@"id"] != [NSNull null])
        self.facultyId = [dict objectForKey:@"id"];
    if([dict objectForKey:@"schoolId"] != [NSNull null])
        self.schoolId = [dict objectForKey:@"schoolId"];
    if([dict objectForKey:@"totalFunding"] != [NSNull null])
        self.totalFunding = [self numberFromNumberString:[dict objectForKey:@"totalFunding"]];
    if([dict objectForKey:@"undergradPopulation"] != [NSNull null])
        self.undergradPopulation = [self numberFromNumberString:[dict objectForKey:@"undergradPopulation"]];
    if([dict objectForKey:@"yearEstablished"] != [NSNull null])
        self.yearEstablished = [NSNumber numberWithLong:[[dict objectForKey:@"yearEstablished"] longValue]];
    
    if([dict objectForKey:@"contacts"] != [NSNull null])
    {
        NSArray* contactsArray = [dict objectForKey:@"contacts"];
        NSMutableSet* contactsSet = [[NSMutableSet alloc] init];
        for(NSDictionary* contactDict in contactsArray)
        {
            Contact* contact = [[Contact alloc] initWithDictionary:contactDict];
            [contactsSet addObject:contact];
        }
        self.contacts = contactsSet;
    }
    
    if([dict objectForKey:@"images"] != [NSNull null])
    {
        NSArray* imageDictArray = [dict objectForKey:@"images"];
        NSMutableSet* imageSet = [[NSMutableSet alloc] init];
        
        for(NSDictionary* imageDict in imageDictArray)
        {
            if([[imageDict objectForKey:@"type"] isEqual:@"logo"])
            {
                NSString* logoStr = [imageDict objectForKey:@"link"];
                if([logoStr isKindOfClass:[NSString class]])
                    self.logoUrl = logoStr;
            }
            else
            {
                ImageLink* imageLink = [[ImageLink alloc] initWithDictionary:imageDict];
                [imageSet addObject:imageLink];
            }
        }
        self.images = imageSet;
        
    }
    
    if([dict objectForKey:@"location"] != [NSNull null])
    {
        SchoolLocation* schoolLoc = [[SchoolLocation alloc] initWithDictionary:[dict objectForKey:@"location"]];
        self.location = schoolLoc;
    }
    
    if([dict objectForKey:@"importantDates"] != [NSNull null])
    {
        NSArray* dataArray = [dict objectForKey:@"importantDates"];
        NSMutableSet* dateSet = [[NSMutableSet alloc] init];
        for(NSDictionary* dateDict in dataArray)
        {
            ImportantDate* importantDate = [[ImportantDate alloc] initWithDictionary:dateDict];
            [dateSet addObject:importantDate];
        }
        self.importantDates = dateSet;
    }
    
    return self;
}


@end


@implementation Program (JPConvenience)


- (instancetype)initWithDictionary: (NSDictionary*)dict
{
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [delegate managedObjectContext];
    NSEntityDescription* programEntity = [NSEntityDescription entityForName:@"Program" inManagedObjectContext:context];
    self = [super initWithEntity:programEntity insertIntoManagedObjectContext:context];
    
    //todo: fix
    self.applicationDeadline = @"01/14";
    
    if([dict objectForKey:@"id"] != [NSNull null])
        self.programId = [dict objectForKey:@"id"];
    if([dict objectForKey:@"name"] != [NSNull null])
        self.name = [dict objectForKey:@"name"];
    if([dict objectForKey:@"shortName"] != [NSNull null])
        self.shortName = [dict objectForKey:@"shortName"];
    if([dict objectForKey:@"about"] != [NSNull null])
        self.about = [dict objectForKey:@"about"];
    if([dict objectForKey:@"avgAdm"] != [NSNull null])
        self.avgAdm = [[NSDecimalNumber alloc] initWithString: [dict objectForKey:@"avgAdm"]];
    if([dict objectForKey:@"applicationProcess"] != [NSNull null])
        self.appProcess = [dict objectForKey:@"applicationProcess"];
    if([dict objectForKey:@"gradPopulation"] != [NSNull null])
        self.gradPopulation = [self numberFromNumberString:[dict objectForKey:@"gradPopulation"]];
    if([dict objectForKey:@"undergradPopulation"] != [NSNull null])
        self.undergradPopulation = [self numberFromNumberString:[dict objectForKey:@"undergradPopulation"]];
    if([dict objectForKey:@"yearEstablished"] != [NSNull null])
        self.yearEstablished = [NSNumber numberWithLong:[[dict objectForKey:@"yearEstablished"] longValue]];
    
    ///////////////////////////
    if([dict objectForKey:@"slug"] != [NSNull null])
        self.slug = [dict objectForKey:@"slug"];
    
    if([dict objectForKey:@"schoolId"] != [NSNull null])
        self.schoolId = [dict objectForKey:@"schoolId"];
    if([dict objectForKey:@"facultyId"] != [NSNull null])
        self.facultyId = [dict objectForKey:@"facultyId"];
    if([dict objectForKey:@"slug"] != [NSNull null])
        self.slug = [dict objectForKey:@"slug"];
    
    if([dict objectForKey:@"degree"] != [NSNull null])
        self.degree = [dict objectForKey:@"degree"];
    if([dict objectForKey:@"degreeAbbrev"] != [NSNull null])
        self.degreeAbbrev = [dict objectForKey:@"degreeAbbrev"];
    
    if([dict objectForKey:@"numApplicants"] != [NSNull null])
        self.numApplicants = [self numberFromNumberString:[dict objectForKey:@"numApplicants"]];
    if([dict objectForKey:@"numAccepted"] != [NSNull null])
        self.numAccepted = [self numberFromNumberString:[dict objectForKey:@"numAccepted"]];
    

    /////////////////////////////////
    if([dict objectForKey:@"contacts"] != [NSNull null])
    {
        NSArray* contactsArray = [dict objectForKey:@"contacts"];
        NSMutableSet* contactsSet = [[NSMutableSet alloc] init];
        for(NSDictionary* contactDict in contactsArray)
        {
            Contact* contact = [[Contact alloc] initWithDictionary:contactDict];
            [contactsSet addObject:contact];
        }
        self.contacts = contactsSet;
    }
    
    if([dict objectForKey:@"images"] != [NSNull null])
    {
        NSArray* imageDictArray = [dict objectForKey:@"images"];
        NSMutableSet* imageSet = [[NSMutableSet alloc] init];
        
        for(NSDictionary* imageDict in imageDictArray)
        {
            ImageLink* imageLink = [[ImageLink alloc] initWithDictionary:imageDict];
            [imageSet addObject:imageLink];
        }
        self.images = imageSet;
    }
    
    if([dict objectForKey:@"location"] != [NSNull null])
    {
        SchoolLocation* schoolLoc = [[SchoolLocation alloc] initWithDictionary:[dict objectForKey:@"location"]];
        self.location = schoolLoc;
    }
    
    if([dict objectForKey:@"importantDates"] != [NSNull null])
    {
        NSArray* dataArray = [dict objectForKey:@"importantDates"];
        NSMutableSet* dateSet = [[NSMutableSet alloc] init];
        for(NSDictionary* dateDict in dataArray)
        {
            ImportantDate* importantDate = [[ImportantDate alloc] initWithDictionary:dateDict];
            [dateSet addObject:importantDate];
        }
        self.importantDates = dateSet;
    }
    
    if([dict objectForKey:@"fees"] != [NSNull null])
    {
        NSDictionary* feeDict = [dict objectForKey:@"fees"];
        
        id domFees = [feeDict objectForKey:@"domestic"];
        id intFees = [feeDict objectForKey:@"international"];
        
        if([domFees isKindOfClass:[NSArray class]])
        {
            NSArray* domesticFees = (NSArray*)domFees;
            NSArray* internationalFees = @[];
            if([intFees isKindOfClass:[NSArray class]])
                internationalFees = (NSArray*)intFees;
            
            NSMutableSet* tuitionSet = [[NSMutableSet alloc] init];
            
            for(int i=0; i<[domesticFees count]; i++)
            {
                NSDictionary* domFeeDict = [domesticFees objectAtIndex:i];
                NSDictionary* intFeeDict = [internationalFees objectAtIndex:i];
                
                NSEntityDescription* tuitionEntity = [NSEntityDescription entityForName:@"ProgramYearlyTuition" inManagedObjectContext:context];
                ProgramYearlyTuition* tuition = [[ProgramYearlyTuition alloc] initWithEntity:tuitionEntity insertIntoManagedObjectContext:context];
                if([domFeeDict objectForKey:@"totalFees"] != [NSNull null])
                    tuition.domesticTuition = [domFeeDict objectForKey:@"totalFees"];
                if([domFeeDict objectForKey:@"term"] != [NSNull null])
                    tuition.term = [domFeeDict objectForKey:@"term"];
                if([intFeeDict objectForKey:@"totalFees"] != [NSNull null])
                    tuition.internationalTuition = [intFeeDict objectForKey:@"totalFees"];

                [tuitionSet addObject:tuition];
            }

            self.tuitions = tuitionSet;
        }
    }
    
    if([dict objectForKey:@"rating"] != [NSNull null])
    {
        NSDictionary* ratingDict = [dict objectForKey:@"rating"];
        
        if(([ratingDict objectForKey:@"guyRatio"]!=[NSNull null]) && ratingDict)
        {
            NSEntityDescription* ratingDescription = [NSEntityDescription entityForName:@"ProgramRating" inManagedObjectContext:context];
            ProgramRating* rating = [[ProgramRating alloc] initWithEntity:ratingDescription insertIntoManagedObjectContext:context];
            rating.guyToGirlRatio = [NSNumber numberWithFloat:[[ratingDict objectForKey:@"guyRatio"] floatValue]];
            self.rating = rating;
        }
    }
    
    if([dict objectForKey:@"internship"] != [NSNull null])
    {
        NSDictionary* intershipDict = [dict objectForKey:@"internship"];
        
        NSMutableString* string = [NSMutableString string];
        
        if([intershipDict objectForKey:@"specific"] != [NSNull null])
            [string appendFormat:@"Specific:%@ | ",[intershipDict objectForKey:@"specific"]];
        if([intershipDict objectForKey:@"earnings"] != [NSNull null])
            [string appendFormat:@"Earnings:%@ | ",[intershipDict objectForKey:@"earnings"]];
        if([intershipDict objectForKey:@"general"] != [NSNull null])
            [string appendFormat:@"General:%@",[intershipDict objectForKey:@"general"]];
        
        self.internshipAbout = string;
    }
    
    
    if([dict objectForKey:@"degreeRequirements"] != [NSNull null])
    {
        NSDictionary* degreeReq = [dict objectForKey:@"degreeRequirements"];
        
        NSArray* currTerms = [degreeReq objectForKey:@"curriculumTerms"];
        NSMutableArray* modTerms = [NSMutableArray arrayWithArray:currTerms];
        
        if([degreeReq objectForKey:@"curriculum"] != [NSNull null])
        {
            NSArray* curriculumTermArray = [degreeReq objectForKey:@"curriculum"];
            
            //Checking if term array count in more than curr term count, if so, the extra terms are electives
            if([curriculumTermArray count] > [currTerms count])
            {
                int extra = [curriculumTermArray count] - [currTerms count];
                for(int i = 1; i<=extra; i++)
                    [modTerms addObject:[NSString stringWithFormat:@"Electives %d", i]];
            }
            
            NSMutableSet* courseSet = [[NSMutableSet alloc] init];
            for(int i=0; i<[curriculumTermArray count]; i++)
            {
                NSString* termName = [modTerms objectAtIndex:i];
                NSArray* termDict = [curriculumTermArray objectAtIndex:i];
                
                for(NSDictionary* courseDict in termDict)
                {
                    ProgramCourse* course = [[ProgramCourse alloc] initWithDictionary:courseDict];
                    course.enrollmentTerm = termName;
                    [courseSet addObject:course];
                }
            }
            self.courses = courseSet;
            
        }
    }
    
    
    if([dict objectForKey:@"requirements"] != [NSNull null])
    {
        NSDictionary* reqDict = [dict objectForKey:@"requirements"];
        
        if([reqDict objectForKey:@"individual_courses"] != [NSNull null])
        {
            NSArray* coursesArray = [reqDict objectForKey:@"individual_courses"];
            
            NSMutableSet* courseSet = [[NSMutableSet alloc] init];
            for(NSDictionary* courseDict in coursesArray)
            {
                HighschoolCourse* requiredCourse = [[HighschoolCourse alloc] initWithRequirementDictionary:courseDict];
                [courseSet addObject:requiredCourse];
            }
            self.requiredCourses = courseSet;
        }
    }
    
    
    return self;
}


@end




@implementation Contact (JPConvenience)

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [delegate managedObjectContext];
    
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Contact" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    if([dict objectForKey:@"website"] != [NSNull null])
        self.website = [dict objectForKey:@"website"];
    if([dict objectForKey:@"name"] != [NSNull null])
        self.name = [dict objectForKey:@"name"];
    if([dict objectForKey:@"twitter"] != [NSNull null])
        self.twitter = [dict objectForKey:@"twitter"];
    if([dict objectForKey:@"linkedin"] != [NSNull null])
        self.linkedin = [dict objectForKey:@"linkedin"];
    if([dict objectForKey:@"facebook"] != [NSNull null])
        self.facebook = [dict objectForKey:@"facebook"];
    if([dict objectForKey:@"email"] != [NSNull null])
        self.email = [dict objectForKey:@"email"];
    if([dict objectForKey:@"ext"] != [NSNull null])
        self.phoneExt = [NSNumber numberWithLongLong:[[dict objectForKey:@"ext"] longLongValue]];
    
    if([dict objectForKey:@"phoneNum"] != [NSNull null])
    {
        NSString* phoneStr = [dict objectForKey:@"phoneNum"];
        self.phone = [self numberFromPhoneString:phoneStr];
    }
    
    return self;
}

@end


@implementation ImageLink (JPConvenience)

- (instancetype)initWithDictionary: (NSDictionary*)dict
{
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [delegate managedObjectContext];
    
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"ImageLink" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    if([dict objectForKey:@"descriptor"] != [NSNull null])
        self.descriptor = [dict objectForKey:@"descriptor"];
    if([dict objectForKey:@"link"] != [NSNull null])
        self.imageLink = [dict objectForKey:@"link"];
    
    return self;
}


@end


@implementation SchoolLocation (JPConvenience)

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [delegate managedObjectContext];
    
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"SchoolLocation" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    if([dict objectForKey:@"city"] != [NSNull null])
        self.city = [dict objectForKey:@"city"];
    if([dict objectForKey:@"country"] != [NSNull null])
        self.country = [dict objectForKey:@"country"];
    if([dict objectForKey:@"region"] != [NSNull null])
        self.region = [dict objectForKey:@"region"];
    if([dict objectForKey:@"apt"] != [NSNull null])
        self.apt = [dict objectForKey:@"apt"];
    if([dict objectForKey:@"latitude"] != [NSNull null])
        self.latitude = [NSNumber numberWithDouble:[[dict objectForKey:@"latitude"] doubleValue]];
    if([dict objectForKey:@"longitude"] != [NSNull null])
        self.longitude = [NSNumber numberWithDouble:[[dict objectForKey:@"longitude"] doubleValue]];
    if([dict objectForKey:@"address"] != [NSNull null])
        self.streetName = [dict objectForKey:@"address"];
    if([dict objectForKey:@"postalCode"] != [NSNull null])
        self.postalCode = [dict objectForKey:@"postalCode"];
    if([dict objectForKey:@"unit"] != [NSNull null])
        self.unit = [dict objectForKey:@"unit"];
    
    return self;
    
}


@end

@implementation ImportantDate (JPConvenience)

- (instancetype)initWithDictionary: (NSDictionary*)dict
{
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [delegate managedObjectContext];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"ImportantDate" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    if([dict objectForKey:@"date"] != [NSNull null])
        self.date = [dict objectForKey:@"date"];
    if([dict objectForKey:@"type"] != [NSNull null])
        self.type = [dict objectForKey:@"type"];
    if([dict objectForKey:@"description"] != [NSNull null])
        self.descriptor = [dict objectForKey:@"description"];
    
    return self;
}




@end



@implementation ProgramCourse (JPConvenience)

- (instancetype)initWithDictionary: (NSDictionary*)dict
{
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [delegate managedObjectContext];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"ProgramCourse" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    if([dict objectForKey:@"catalog_number"] != [NSNull null])
        self.catalogNum = [dict objectForKey:@"catalog_number"];
    if([dict objectForKey:@"title"] != [NSNull null])
        self.courseName = [dict objectForKey:@"title"];
    if([dict objectForKey:@"description"] != [NSNull null])
        self.courseDescription = [dict objectForKey:@"description"];
    if([dict objectForKey:@"subject"] != [NSNull null])
        self.courseCode = [dict objectForKey:@"subject"];
    
    return self;
}

@end


@implementation HighschoolCourse (JPConvenience)

- (instancetype)initWithRequirementDictionary:(NSDictionary *)dict
{
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [delegate managedObjectContext];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"HighschoolCourse" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    if([dict objectForKey:@"min_grade"] != [NSNull null])
        self.courseMark = [NSNumber numberWithDouble:[[dict objectForKey:@"min_grade"] doubleValue]];
    if([dict objectForKey:@"course_code"] != [NSNull null])
        self.courseLevel = [dict objectForKey:@"course_code"];
    //Todo: delete name param in HighschoolCourse.h
    if([dict objectForKey:@"course_title"] != [NSNull null])
        self.courseCode = [dict objectForKey:@"course_title"];
    
    
    return self;
}

@end






