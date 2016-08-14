//
//  iPadProgramViewController.h
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPDataRequest.h"
#import "iPadProgramAcademicsViewController.h"
#import "iPadProgramCompareViewController.h"
#import "iPadProgramContactViewController.h"
#import "iPadProgramRatingsViewController.h"
#import "iPadProgramHomeViewController.h"


@class Program;

@interface iPadProgramViewController : UITabBarController <JPDataRequestDelegate>
{
    NSManagedObjectContext* context;
    JPDataRequest* _dataRequest;
}



@property (nonatomic, strong) NSString* programId;
@property (nonatomic, strong) NSString *slug;

@property (nonatomic, strong) Program* program;


@property (nonatomic, strong)iPadProgramHomeViewController *vc1 ;
@property (nonatomic, strong)iPadProgramAcademicsViewController *vc2 ;
@property (nonatomic, strong)iPadProgramContactViewController *vc3;
@property (nonatomic, strong)iPadProgramCompareViewController *vc4 ;
@property (nonatomic, strong)iPadProgramRatingsViewController *vc5 ;


- (id)initWithItemId: (NSString*)itemId slug: (NSString *)slug;







@end
