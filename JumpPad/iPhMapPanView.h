//
//  iPhMapPanView.h
//  Uniq
//
//  Created by Si Te Feng on 7/13/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@class School, Faculty, Program, JPLocation;
@interface iPhMapPanView : UIView
{
    UIImageView*  _dragBar;
 
    UIView*       _distanceView;
    UILabel*      _distanceLabel;
}


@property(nonatomic, strong) MKMapView* mapView;


@property(nonatomic, strong) JPLocation* location;





@end
