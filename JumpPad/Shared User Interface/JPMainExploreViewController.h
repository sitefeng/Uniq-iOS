//
//  JPMainExploreViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPDataRequest.h"

#import "Uniq-Swift.h"


@class JPBannerView;
@interface JPMainExploreViewController : UIViewController <JPDataRequestDelegate, JPOfflineDataRequestDelegate>
{
    NSManagedObjectContext* context;
}


//Array of JPDashlets of type JPDashletTypeCollege
//to be Displayed on Screen
@property (nonatomic, strong) NSMutableArray* dashlets;

@property (nonatomic, strong) JPBannerView* bannerView;
@property (nonatomic, strong) NSMutableArray* bannerURLs;



- (void)updateDashletsInfo;

- (void)updateBannerInfo;



@end
