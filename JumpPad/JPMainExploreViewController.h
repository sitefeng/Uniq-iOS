//
//  JPMainExploreViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JPBannerView;
@interface JPMainExploreViewController : UIViewController
{
    NSManagedObjectContext* context;
    
    NSMutableArray* _bannerURLs;
    
}


@property (nonatomic, strong) JPBannerView* banner;



@end
