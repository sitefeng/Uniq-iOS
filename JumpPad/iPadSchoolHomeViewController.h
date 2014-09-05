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
#import "JPDataRequest.h"


@class iPadProgramImagesViewController, iPadProgramLabelView, JPSchoolSummaryView, School, iPadProgramContactViewController;

@interface iPadSchoolHomeViewController  : UIViewController <JPSchoolSummaryDelegate, JPDataRequestDelegate>
{
    NSManagedObjectContext* context;
    JPDataRequest*   _dataRequest;
    JPCoreDataHelper* _coreDataHelper;
    
    JPLocation*     _schoolLocation;
    
    JPDashletType   _itemType;
    
}



@property (nonatomic, strong) NSString* itemId;

@property (nonatomic, strong) School* school;
@property (nonatomic, strong) Faculty* faculty;


@property (nonatomic, strong) iPadProgramImagesViewController* imageController;
@property (nonatomic, strong) JPSchoolSummaryView* summaryView;

@property (nonatomic, strong) iPadProgramContactViewController* contactVC;




- (id)initWithItemId: (NSString*)itemId type:(JPDashletType)type;


@end


