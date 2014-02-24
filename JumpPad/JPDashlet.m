//
//  JPDashlet.m
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "JPDashlet.h"

@implementation JPDashlet


- (instancetype)initWithItemUID: (NSString*)uid
{
    self = [super init];
    if(self)
    {
        self.itemUID = uid;
        
        //Retrieve Info from CoreData and fill in ALL Properties Automatically
        
        //Code!!!!!!!!!!!!!!!!
        
        
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
    return [NSString stringWithFormat:@"Dashlet for %@[%@]", self.title, self.itemUID];
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    JPDashlet* dashlet = [[JPDashlet alloc] init];
    
    dashlet.itemUID = [self.itemUID copyWithZone:zone];
    dashlet.location = [self.location copyWithZone:zone];
    
    dashlet.title = [self.title copyWithZone:zone];
    dashlet.type = self.type;
    dashlet.backgroundImages = [self.backgroundImages copyWithZone:zone];
    dashlet.details = [self.details copyWithZone:zone];
    dashlet.icon = [self.icon copy];
    
    return dashlet;
}












@end
