//
//  iPhSchoolViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/20/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Faculty, School, JPCoreDataHelper;
@interface iPhSchoolViewController : UITabBarController
{
    NSManagedObjectContext* context;
    
    JPCoreDataHelper*  _coreDataHelper;
}



@property (nonatomic, assign) JPDashletType type;
@property (nonatomic, assign) NSUInteger dashletUid;


@property (nonatomic, strong) id schoolOrFaculty;



- (instancetype)initWithDashletUid: (NSUInteger)dashletUid itemType: (NSUInteger)type;






@end
