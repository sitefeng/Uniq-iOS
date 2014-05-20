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


@interface iPadProgramSummaryView : UIView <MFMailComposeViewControllerDelegate, UINavigationControllerDelegate>
{
    BOOL    _readyToCalculateDistance;
    
}






@property (nonatomic, strong) Program* program;
@property (nonatomic, strong) JPLocation* location;

@property (nonatomic, strong) UILabel* summary;


@property (nonatomic, strong) NSMutableArray* iconImages; //UIImageViews

@property (nonatomic, strong) NSMutableArray* iconLabels; //UILabels


@property (nonatomic, strong) id<JPProgramSummaryDelegate> delegate;



- (id)initWithFrame:(CGRect)frame program: (Program*)program location:(JPLocation*)location;


@end



@protocol JPProgramSummaryDelegate <NSObject>

- (void)emailButtonTapped;
- (void)websiteButtonTapped;
- (void)facebookButtonTapped;
- (void)favoriteButtonTapped;

@end