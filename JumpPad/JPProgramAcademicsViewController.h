//
//  JPProgramAcademicsViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/19/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Program, UserFavItem, JPCoreDataHelper;
@interface JPProgramAcademicsViewController : UIViewController
{
    NSManagedObjectContext* context;
    JPCoreDataHelper*  _coreDataHelper;
    
    NSMutableArray* _applicationButtons;
    UserFavItem*    _userFav;
    
}




@property (nonatomic, strong) Program* program;



- (id)initWithProgram: (Program*)program;

- (void)calendarButtonPressed: (UIButton*)button;


@end
