//
//  iPhImageScrollView.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Program, Faculty, School;
@interface iPhImagePanView : UIView
{
    UIImageView*   _dragBar;
   
    UIScrollView*  _imageScrollView;
    UILabel*       _noPhotoLabel;
    
    JPDashletType   _imageType;
}



@property (nonatomic, strong) NSArray* imageURLs;


@property (nonatomic, strong) Program* program;
@property (nonatomic, strong) Faculty* faculty;
@property (nonatomic, strong) School* school;


@end
