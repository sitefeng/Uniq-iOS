//
//  iPadSchoolHomeViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPSchoolSummaryView.h"
#import "JPCoreDataHelper.h"

@class iPadProgramImagesViewController, iPadProgramLabelView, JPSchoolSummaryView, School, iPadProgramContactViewController;

@interface iPadSchoolHomeViewController  : UIViewController <JPSchoolSummaryDelegate>
{
    NSManagedObjectContext* context;
    JPCoreDataHelper* _coreDataHelper;
    
    JPLocation*     _schoolLocation;
    
    JPDashletType   _itemType;
    
}



@property (nonatomic, assign) NSUInteger dashletUid;
@property (nonatomic, strong) School* school;
@property (nonatomic, strong) Faculty* faculty;


@property (nonatomic, strong) iPadProgramImagesViewController* imageController;
@property (nonatomic, strong) JPSchoolSummaryView* summaryView;

@property (nonatomic, strong) iPadProgramContactViewController* contactVC;




- (id)initWithDashletUid: (NSUInteger)dashletUid;


@end


