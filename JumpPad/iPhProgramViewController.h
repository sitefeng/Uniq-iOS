//
//  iPhProgramViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPDataRequest.h"

@class Program, JPCoreDataHelper, UserFavItem, iPhProgramAcademicsViewController;
@interface iPhProgramViewController : UITabBarController <JPDataRequestDelegate>
{
    NSManagedObjectContext* context;
    JPCoreDataHelper*  _helper;
    
    UIButton*  _favButton;
    UserFavItem*  _userFav;
    
    iPhProgramAcademicsViewController* academicsController;
}




@property (nonatomic, strong) NSString* itemId;

@property (nonatomic, strong) Program* program;







- (instancetype)initWithItemId: (NSString*)itemId;

- (void)reloadFavoriteButtonState;

@end
