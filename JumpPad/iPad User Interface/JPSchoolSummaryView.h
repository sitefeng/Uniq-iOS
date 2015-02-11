//
//  iPadSchoolSummaryView.h
//  Uniq
//
//  Created by Si Te Feng on 7/3/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class School, Faculty, JPLocation;
@protocol JPSchoolSummaryDelegate;
@interface JPSchoolSummaryView : UIView
{
    BOOL    _readyToCalculateDistance;
    
    UIButton* _favoriteButton;
    
    JPDashletType _itemType;
    
}


@property (nonatomic, assign) BOOL isIphoneInterface;

@property (nonatomic, assign) BOOL isFavorited;
@property (nonatomic, strong) School* school;
@property (nonatomic, strong) Faculty* faculty;


@property (nonatomic, strong, readonly) JPLocation* location;
@property (nonatomic, readonly) float distanceToHome;


@property (nonatomic, strong) UILabel* summary;

@property (nonatomic, strong) id<JPSchoolSummaryDelegate> delegate;



- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame isPhoneInterface: (BOOL)isPhone;

@end



@protocol JPSchoolSummaryDelegate <NSObject>

@required
- (void)websiteButtonTapped;
- (void)facebookButtonTapped;
- (void)twitterButtonTapped;
- (void)favoriteButtonSelected: (BOOL)isSelected;

@end


