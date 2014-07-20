//
//  JPProgramAcademicsViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/19/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Program, UserFavItem;
@interface JPProgramAcademicsViewController : UIViewController
{
    NSManagedObjectContext* context;
    
    NSMutableArray* _applicationButtons;
    UserFavItem*    _userFav;
    
}




@property (nonatomic, assign) NSUInteger dashletUid;
@property (nonatomic, strong) Program* program;



- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program;
- (void)calendarButtonPressed: (UIButton*)button;


@end
