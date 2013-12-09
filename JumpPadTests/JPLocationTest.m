//
//  JPLocationTest.m
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JPLocation.h"

@interface JPLocationTest : XCTestCase

@end

@implementation JPLocationTest

- (void)setUp
{
    [super setUp];
    
    
    
    
    
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDistanceToLocation
{
    
    JPLocation* location = [[JPLocation alloc] initWithCooridinates:jpp(43.661223,-79.384694) city:@"Toronto" country:@"Canada"];
    
    JPLocation* loc2 = [[JPLocation alloc] initWithCooridinates:jpp(43.479273, -80.533557) city:@"waterloo" country:@"canada"];
   
    double distance = [location distanceToLocation:loc2];
    
    int distToTest = (int)distance;
    
    XCTAssertEqual(94, distToTest, @"Distance is not calculated correctly");
    
}








@end
