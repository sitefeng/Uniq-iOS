//
//  iPhAppProgressPanView.h
//  Uniq
//
//  Created by Si Te Feng on 7/13/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Program, UserFavItem;
@protocol JPAppProgressPanDelegate;
@interface iPhAppProgressPanView : UIView
{
    NSManagedObjectContext* context;
    UIImageView*  _dragBar;
    UILabel*      _dragBarLabel2;
    
    UserFavItem*  _userFav;
}


@property (nonatomic, strong) NSString* itemId;

@property (nonatomic, strong) NSMutableArray* applicationButtons;

@property (nonatomic, weak) id<JPAppProgressPanDelegate> delegate;

- (void)selectCalendarButtonsFromCoreData;

@end

@protocol JPAppProgressPanDelegate <NSObject>

- (void)appProgressDidPressFavoriteButton;

@end