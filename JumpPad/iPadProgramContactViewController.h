//
//  iPadProgramContactViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class MKMapView, Program, School, SchoolLocation, iPadProgramLabelView;
@interface iPadProgramContactViewController : UIViewController
{
    School*          _school;
    SchoolLocation*  _schoolLocation;
    
    UIView*          _mapBarView;
    CGFloat          _mapBarPosition; //for pull up
    
    CLLocationCoordinate2D _mapCenterCoord;
    
    
    CGFloat          _prevMapDragBarPosition;
}





@property (nonatomic, assign) NSUInteger dashletUid;

@property (nonatomic, strong) Program* program;


@property (nonatomic, strong) iPadProgramLabelView* labelView;



@property (nonatomic, strong) MKMapView* mapView;




- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program;


@end
