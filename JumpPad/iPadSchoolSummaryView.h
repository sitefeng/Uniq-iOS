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
@interface iPadSchoolSummaryView : UIView
{
    BOOL    _readyToCalculateDistance;
    
    UIButton* _favoriteButton;
    
    JPDashletType _itemType;
    
}




@property (nonatomic, assign) BOOL isFavorited;
@property (nonatomic, strong) School* school;
@property (nonatomic, strong) Faculty* faculty;


@property (nonatomic, strong) JPLocation* location;



@property (nonatomic, strong) UILabel* summary;
@property (nonatomic, strong) NSMutableArray* iconImages; //UIImageViews
@property (nonatomic, strong) NSMutableArray* iconLabels; //UILabels
@property (nonatomic, strong) id<JPSchoolSummaryDelegate> delegate;



- (instancetype)initWithFrame:(CGRect)frame;

@end



@protocol JPSchoolSummaryDelegate <NSObject>

@required
- (void)websiteButtonTapped;
- (void)facebookButtonTapped;
- (void)favoriteButtonSelected: (BOOL)isSelected;
- (void)twitterButtonTapped;


@end


