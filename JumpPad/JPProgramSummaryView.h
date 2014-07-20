//
//  iPadProgramSummaryView.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-08.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@class Program, JPLocation;

@protocol JPProgramSummaryDelegate;

@interface JPProgramSummaryView : UIView <MFMailComposeViewControllerDelegate, UINavigationControllerDelegate>
{
    BOOL    _readyToCalculateDistance;
    UIButton* _favoriteButton;
    
}



@property (nonatomic, assign) BOOL isIphoneInterface;
@property (nonatomic, assign) BOOL isFavorited;

@property (nonatomic, strong) Program* program;
@property (nonatomic, strong) JPLocation* location;
@property (nonatomic, assign) float distanceToHome;

@property (nonatomic, strong) UILabel* summary;


@property (nonatomic, strong) id<JPProgramSummaryDelegate> delegate;



- (id)initWithFrame:(CGRect)frame program: (Program*)program location:(JPLocation*)location;
- (id)initWithFrame:(CGRect)frame program: (Program*)program  location:(JPLocation*)location isPhoneInterface: (BOOL)isPhone;

@end



@protocol JPProgramSummaryDelegate <NSObject>

@required
- (void)websiteButtonTapped;
- (void)facebookButtonTapped;
- (void)emailButtonTapped;

@optional
- (void)favoriteButtonSelected: (BOOL)isSelected;
- (void)phoneButtonTapped;

@end

