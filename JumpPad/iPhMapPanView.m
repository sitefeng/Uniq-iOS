//
//  iPhMapPanView.m
//  Uniq
//
//  Created by Si Te Feng on 7/13/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhMapPanView.h"
#import "JPFont.h"
#import "JPStyle.h"
#import "School.h"
#import "SchoolLocation.h"
#import "JPLocation.h"
#import <MapKit/MapKit.h>

@implementation iPhMapPanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [JPStyle colorWithName:@"tWhite"];
        UIView* bottomVisibleView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 30, frame.size.width, 30)];
        [self addSubview:bottomVisibleView];
        
        _dragBar = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2.0 - 15, 5, 30, 20)];
        _dragBar.image = [UIImage imageNamed:@"dragBarIcon"];
        [bottomVisibleView addSubview:_dragBar];
        
        UILabel* dragBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
        dragBarLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
        dragBarLabel.textColor = [UIColor blackColor];
        dragBarLabel.text = @"Map";
        [bottomVisibleView addSubview:dragBarLabel];
        
        //Map View
        CGPoint coord = _location.coordinates;
        self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 30)];
        self.mapView.mapType = MKMapTypeStandard;
        _mapCenterCoord = CLLocationCoordinate2DMake(coord.x, coord.y);
        self.mapView.region = MKCoordinateRegionMakeWithDistance(_mapCenterCoord, 1500, 1500);
        self.mapView.clipsToBounds = YES;
        [self addSubview:self.mapView];
        
        
        // Other view
        UIView* distanceView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 100, 32)];
        distanceView.backgroundColor = [JPStyle colorWithName:@"tWhite"];
        distanceView.layer.cornerRadius = 14;
        distanceView.clipsToBounds = YES;
        
        UIImageView* distanceImg = [[UIImageView alloc] initWithFrame:CGRectMake(3, 1, 30, 30)];
        distanceImg.image = [UIImage imageNamed: @"distance-50"];
        
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 6, 68, 22)];
        _distanceLabel.textColor = [UIColor blackColor];
        _distanceLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:15];
        _distanceLabel.text = @"--kms away";
        [_distanceLabel sizeToFit];
        
        [distanceView addSubview:distanceImg];
        [distanceView addSubview:_distanceLabel];
        
        [distanceView setFrame:CGRectMake(distanceView.frame.origin.x, distanceView.frame.origin.y, _distanceLabel.frame.size.width + 32 + 10, distanceView.frame.size.height)];

        [self.mapView addSubview:distanceView];

        
        
        
    }
    return self;
}


- (void)setSchool:(School *)school
{
    _school = school;
    
    SchoolLocation* schoolLocation = school.location;
    
    JPLocation* location = [[JPLocation alloc] initWithSchoolLocation:schoolLocation];
    _location = location;
    
    _distanceLabel.text = [_location distanceToUserString];
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
