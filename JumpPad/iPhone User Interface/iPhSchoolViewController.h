//
//  iPhSchoolViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/20/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPDataRequest.h"
#import "ManagedObjects+JPConvenience.h"


@class Faculty, School, JPCoreDataHelper;
@interface iPhSchoolViewController : UITabBarController
{
    NSManagedObjectContext* context;
    JPCoreDataHelper*  _coreDataHelper;
}



@property (nonatomic, assign) JPDashletType type;
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *schoolSlug;
@property (nonatomic, strong) NSString *facultySlug;


@property (nonatomic, strong) id schoolOrFaculty;



- (instancetype)initWithItemId:(NSString*)itemId itemType: (JPDashletType)type schoolSlug: (NSString *)schoolSlug facultySlug: (NSString *)facultySlug;


@end
