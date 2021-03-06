//
//  iPadProgramContactViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "JPProgramContactViewController.h"

@class MKMapView, Program, School, Faculty, SchoolLocation, iPadProgramLabelView;
@interface iPadProgramContactViewController : JPProgramContactViewController
{
    
    UIView*          _mapBarView;
    CGFloat          _mapBarPosition; //for pull up
    
    CLLocationCoordinate2D _mapCenterCoord;
    
    CGFloat          _prevMapDragBarPosition;
}



@property (nonatomic, strong) MKMapView* mapView;




- (id)initWithProgram: (Program*)program;
- (id)initWithSchool: (School*)school;
- (id)initWithFaculty: (Faculty *)faculty;

@end
