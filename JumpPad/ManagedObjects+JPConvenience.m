//
//  ManagedObjects+JPConvenience.m
//  Uniq
//
//  Created by Si Te Feng on 9/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "ManagedObjects+JPConvenience.h"
#import "NSObject+JPConvenience.h"
#import "JPRatings.h"



@implementation School (JPConvenience)

- (instancetype)initWithDictionary: (NSDictionary*)dict
{
    if([dict objectForKey:@"itemObject"])
    {
        return [dict objectForKey:@"itemObject"];
    }
    
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [delegate managedObjectContext];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"School" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.toDelete = @YES;
    if([dict objectForKey:@"id"] != [NSNull null]) {
        self.schoolId = [dict objectForKey:@"id"];
    }
    else {
        if([dict objectForKey:@"slug"] != [NSNull null]) {
            self.schoolId = [dict objectForKey:@"slug"];
        }
    }
    if([dict objectForKey:@"slug"] != [NSNull null])
        self.slug = [dict objectForKey:@"slug"];
    
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
        self.numFaculties = [NSNumber numberWithInteger:[[dict objectForKey:@"numFaculties"] integerValue]];
    if([dict objectForKey:@"numPrograms"] != [NSNull null])
        self.numPrograms = [NSNumber numberWithInteger:[[dict objectForKey:@"numPrograms"] integerValue]];
    if([dict objectForKey:@"totalFunding"] != [NSNull null])
        self.totalFunding = [dict objectForKey:@"totalFunding"];
    if([dict objectForKey:@"undergradPopulation"] != [NSNull null])
        self.undergradPopulation = [self numberFromNumberString:[dict objectForKey:@"undergradPopulation"]];
    if([dict objectForKey:@"yearEstablished"] != [NSNull null])
        self.yearEstablished = [NSNumber numberWithInteger:[[dict objectForKey:@"yearEstablished"] integerValue]];

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
    
    [dict setValue:self forKey:@"itemObject"];
    
    return dict;
}



@end


@implementation Faculty (JPConvenience)


- (instancetype)initWithDictionary: (NSDictionary*)dict
{
    if([dict objectForKey:@"itemObject"])
    {
        return [dict objectForKey:@"itemObject"];
    }
    
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [delegate managedObjectContext];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Faculty" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    self.toDelete = @YES;
    
    if([dict objectForKey:@"id"] != [NSNull null]) {
        self.facultyId = [dict objectForKey:@"id"];
    }
    else {
        if([dict objectForKey:@"slug"] != [NSNull null])
            self.facultyId = [dict objectForKey:@"slug"];
    }
    if([dict objectForKey:@"slug"] != [NSNull null])
        self.slug = [dict objectForKey:@"slug"];
    if([dict objectForKey:@"schoolSlug"] != [NSNull null])
        self.schoolSlug = [dict objectForKey:@"schoolSlug"];
    
    if([dict objectForKey:@"about"] != [NSNull null])
        self.about = [dict objectForKey:@"about"];
    if([dict objectForKey:@"alumniNumber"] != [NSNull null])
        self.alumniNumber = [self numberFromNumberString: [dict objectForKey:@"alumniNumber"]];
    if([dict objectForKey:@"avgAdm"] != [NSNull null])
        self.avgAdm = [self numberFromNumberString: [dict objectForKey:@"avgAdm"]];
    if([dict objectForKey:@"numPrograms"] != [NSNull null])
        self.numPrograms = [self numberFromNumberString: [dict objectForKey:@"numPrograms"]];
    if([dict objectForKey:@"gradPopulation"] != [NSNull null])
        self.gradPopulation = [self numberFromNumberString:[dict objectForKey:@"gradPopulation"]];
    if([dict objectForKey:@"logoUrl"] != [NSNull null])
        self.logoUrl = [dict objectForKey:@"logoUrl"];
    if([dict objectForKey:@"name"] != [NSNull null])
        self.name = [dict objectForKey:@"name"];
    if([dict objectForKey:@"schoolId"] != [NSNull null])
        self.schoolId = [dict objectForKey:@"schoolId"];
    if([dict objectForKey:@"totalFunding"] != [NSNull null])
        self.totalFunding = [dict objectForKey:@"totalFunding"];
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


- (NSDictionary*)dictionaryRepresentation
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    
    [dict setValue:self forKey:@"itemObject"];
    
    return dict;
    
}




@end


@implementation Program (JPConvenience)


- (instancetype)initWithDictionary: (NSDictionary*)dict
{
    if([dict objectForKey:@"itemObject"])
    {
        return [dict objectForKey:@"itemObject"];
    }
    
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [delegate managedObjectContext];
    NSEntityDescription* programEntity = [NSEntityDescription entityForName:@"Program" inManagedObjectContext:context];
    self = [super initWithEntity:programEntity insertIntoManagedObjectContext:context];
    
    self.toDelete = @YES;
    
    //todo: fix
    self.applicationDeadline = @"January 13";
    
    if([dict objectForKey:@"id"] != [NSNull null])
        self.programId = [dict objectForKey:@"id"];
    else {
        if([dict objectForKey:@"slug"] != [NSNull null]) {
            self.programId = [dict objectForKey:@"slug"];
        }
    }
    if([dict objectForKey:@"slug"] != [NSNull null]) {
        self.slug = [dict objectForKey:@"slug"];
    }
    
    if([dict objectForKey:@"schoolId"] != [NSNull null])
    self.schoolId = [dict objectForKey:@"schoolId"];
    if([dict objectForKey:@"schoolSlug"] != [NSNull null])
    self.schoolSlug = [dict objectForKey:@"schoolSlug"];
    
    if([dict objectForKey:@"facultyId"] != [NSNull null])
    self.facultyId = [dict objectForKey:@"facultySlug"];
    if([dict objectForKey:@"facultyId"] != [NSNull null])
    self.facultySlug = [dict objectForKey:@"facultySlug"];
    
    ////////////////////////
    if([dict objectForKey:@"name"] != [NSNull null])
        self.name = [dict objectForKey:@"name"];
    if([dict objectForKey:@"shortName"] != [NSNull null])
        self.shortName = [dict objectForKey:@"shortName"];
    if([dict objectForKey:@"about"] != [NSNull null])
        self.about = [dict objectForKey:@"about"];
    if([dict objectForKey:@"avgAdm"] != [NSNull null])
        self.avgAdm = [dict objectForKey:@"avgAdm"];
    if([dict objectForKey:@"applicationProcess"] != [NSNull null])
        self.appProcess = [dict objectForKey:@"applicationProcess"];
    if([dict objectForKey:@"gradPopulation"] != [NSNull null])
        self.gradPopulation = [self numberFromNumberString:[dict objectForKey:@"gradPopulation"]];
    if([dict objectForKey:@"undergradPopulation"] != [NSNull null])
        self.undergradPopulation = [self numberFromNumberString:[dict objectForKey:@"undergradPopulation"]];
    if([dict objectForKey:@"yearEstablished"] != [NSNull null])
        self.yearEstablished = [NSNumber numberWithLong:[[dict objectForKey:@"yearEstablished"] longValue]];
    
    ///////////////////////////
    
    if([dict objectForKey:@"degree"] != [NSNull null])
        self.degree = [dict objectForKey:@"degree"];
    if([dict objectForKey:@"degreeAbbrev"] != [NSNull null])
        self.degreeAbbrev = [dict objectForKey:@"degreeAbbrev"];
    
    if([dict objectForKey:@"numApplicants"] != [NSNull null])
        self.numApplicants = [self numberFromNumberString:[dict objectForKey:@"numApplicants"]];
    if([dict objectForKey:@"numAccepted"] != [NSNull null])
        self.numAccepted = [self numberFromNumberString:[dict objectForKey:@"numAccepted"]];
    if([dict objectForKey:@"numFavorites"] != [NSNull null])
        self.numFavorites = [NSNumber numberWithInteger:[[dict objectForKey:@"numFavorites"] integerValue]];

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
        NSDictionary* feesDict = [dict objectForKey:@"fees"];
        
        NSEntityDescription* tuitionEntity = [NSEntityDescription entityForName:@"ProgramYearlyTuition" inManagedObjectContext:context];
        ProgramYearlyTuition* tuition = [[ProgramYearlyTuition alloc] initWithEntity:tuitionEntity insertIntoManagedObjectContext:context];

        if([feesDict objectForKey:@"domestic"] != [NSNull null])
            tuition.domesticTuition = [feesDict objectForKey:@"domestic"];
        if([feesDict objectForKey:@"international"] != [NSNull null])
            tuition.internationalTuition = [feesDict objectForKey:@"international"];
        
        self.tuition = tuition;
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
            
            NSMutableString* curriculumTermsString = [NSMutableString string];
            
            NSMutableSet* courseSet = [[NSMutableSet alloc] init];
            for(int i=0; i<[curriculumTermArray count]; i++)
            {
                NSString* termName = [modTerms objectAtIndex:i];
                [curriculumTermsString appendFormat:@"%@,", termName];
                NSArray* termDict = [curriculumTermArray objectAtIndex:i];
                
                for(NSDictionary* courseDict in termDict)
                {
                    ProgramCourse* course = [[ProgramCourse alloc] initWithDictionary:courseDict];
                    course.enrollmentTerm = termName;
                    [courseSet addObject:course];
                }
            }
            self.courses = courseSet;
            self.curriculumTerms = [curriculumTermsString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
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
    
    if([dict objectForKey:@"rating"] != [NSNull null])
    {
        NSDictionary* ratingsDict = [dict objectForKey:@"rating"];
        
        JPRatings* ratings = [[JPRatings alloc] initWithFullKeyDictionary:ratingsDict];
        ProgramRating* programRating = [[ProgramRating alloc] initWithRatings:ratings];
        
        self.rating = programRating;
    }
    
    return self;
}



- (void)appendProgramRatingsWithRatings: (JPRatings*)ratings
{
    if(!self)
        return;

    ProgramRating* programRating = [[ProgramRating alloc] initWithRatings:ratings];
    self.rating = programRating;
    
}


- (NSDictionary*)dictionaryRepresentation
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    [dict setValue:self forKey:@"itemObject"];
    return dict;
}


@end



@implementation ProgramRating (JPConvenience)

- (instancetype)initWithRatings:(JPRatings*)ratings
{
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [delegate managedObjectContext];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"ProgramRating" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.ratingOverall = [NSNumber numberWithDouble:ratings.ratingOverall];
    self.difficulty = [NSNumber numberWithDouble:ratings.difficulty];
    self.professor = [NSNumber numberWithDouble:ratings.professors];
    self.schedule = [NSNumber numberWithDouble:ratings.schedule];
    self.classmates = [NSNumber numberWithDouble:ratings.classmates];
    self.socialEnjoyments = [NSNumber numberWithDouble:ratings.social];
    self.studyEnv= [NSNumber numberWithDouble:ratings.studyEnv];
    self.guyToGirlRatio = [NSNumber numberWithDouble:ratings.guyRatio];
    self.weight = [NSNumber numberWithInteger:ratings.weight];
    
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
    else
        self.website = @"";
    if([dict objectForKey:@"name"] != [NSNull null])
        self.name = [dict objectForKey:@"name"];
    else
        self.name = @"";
    if([dict objectForKey:@"twitter"] != [NSNull null])
        self.twitter = [dict objectForKey:@"twitter"];
    else
        self.twitter = @"";
    if([dict objectForKey:@"linkedin"] != [NSNull null])
        self.linkedin = [dict objectForKey:@"linkedin"];
    else
        self.linkedin = @"";
    if([dict objectForKey:@"facebook"] != [NSNull null])
        self.facebook = [dict objectForKey:@"facebook"];
    else
        self.facebook = @"";
    if([dict objectForKey:@"email"] != [NSNull null])
        self.email = [dict objectForKey:@"email"];
    else
        self.email = @"";
    if([dict objectForKey:@"extraInfo"] != [NSNull null])
        self.extraInfo = [dict objectForKey:@"extraInfo"];
    else
        self.extraInfo = @"";
    if([dict objectForKey:@"ext"] != [NSNull null])
        self.phoneExt = [NSString stringWithFormat:@"%@",[NSNumber numberWithLongLong:[[dict objectForKey:@"ext"] longLongValue]]];
    else
        self.phoneExt = @"";
    
    if([dict objectForKey:@"phoneNum"] != [NSNull null])
    {
        NSString* phoneStr = [dict objectForKey:@"phoneNum"];
        self.phone = [NSString stringWithFormat:@"%@",[self numberFromPhoneString:phoneStr]];
    }
    else {
        self.phone = @"";
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






