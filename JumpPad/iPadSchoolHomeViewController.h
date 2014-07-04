//
//  iPadSchoolHomeViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPadSchoolSummaryView.h"


@class iPadProgramImagesViewController, iPadProgramLabelView, iPadSchoolSummaryView, School, iPadProgramContactViewController;

@interface iPadSchoolHomeViewController  : UIViewController <JPSchoolSummaryDelegate>
{
    NSManagedObjectContext* context;
    JPLocation*     _schoolLocation;
    
    JPDashletType   _itemType;
}



@property (nonatomic, assign) NSUInteger dashletUid;
@property (nonatomic, strong) School* school;
@property (nonatomic, strong) Faculty* faculty;


@property (nonatomic, strong) iPadProgramImagesViewController* imageController;
@property (nonatomic, strong) iPadSchoolSummaryView* summaryView;

@property (nonatomic, strong) iPadProgramContactViewController* contactVC;




- (id)initWithDashletUid: (NSUInteger)dashletUid;


@end


