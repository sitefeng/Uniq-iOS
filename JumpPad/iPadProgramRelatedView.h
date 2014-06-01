//
//  iPadProgramRelatedView.h
//  Uniq
//
//  Created by Si Te Feng on 2014-05-31.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol JPProgramRelatedViewDataSource;

@interface iPadProgramRelatedView : UIView
{
    UILabel*         _noContentLabel;
    UIScrollView*    _scrollView;
    
}



@property (nonatomic, strong) UILabel* titleLabel;




@property (nonatomic, weak) id<JPProgramRelatedViewDataSource> dataSource;



@end



@protocol JPProgramRelatedViewDataSource <NSObject>

@required
- (NSUInteger)numberOfCellsForRelatedView: (iPadProgramRelatedView*)relatedView;

- (NSString*)relatedView: (iPadProgramRelatedView*)relatedView cellTitleForCellAtPosition: (NSUInteger)position;

@optional
- (NSString*)relatedView:(iPadProgramRelatedView *)relatedView cellSubtitleForCellAtPosition:(NSUInteger)position;

- (NSString*)relatedView:(iPadProgramRelatedView *)relatedView cellBackgroundImageURLStringForCellAtPosition: (NSUInteger)position;



@end