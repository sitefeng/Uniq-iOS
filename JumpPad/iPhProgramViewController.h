//
//  iPhProgramViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Program, JPCoreDataHelper, UserFavItem, iPhProgramAcademicsViewController;
@interface iPhProgramViewController : UITabBarController
{
    NSManagedObjectContext* context;
    JPCoreDataHelper*  _helper;
    
    UIButton*  _favButton;
    UserFavItem*  _userFav;
    
    iPhProgramAcademicsViewController* academicsController;
}




@property (nonatomic, assign) NSUInteger dashletUid;

@property (nonatomic, strong) Program* program;







- (instancetype)initWithDashletUid: (NSUInteger)dashletUid;
- (void)reloadFavoriteButtonState;

@end
