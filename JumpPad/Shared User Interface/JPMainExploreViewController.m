//
//  JPMainExploreViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPMainExploreViewController.h"
#import "School.h"
#import "Banner.h"
#import "JPDashlet.h"
#import "JPBannerView.h"
#import "iPadSchoolHomeViewController.h"
#import "JPConnectivityManager.h"


@interface JPMainExploreViewController ()

@end

@implementation JPMainExploreViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Core Data NS Managed Object Context
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    context = [delegate managedObjectContext];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAllInfo) name:kNeedUpdateDataNotification object:nil];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateDashletsInfo];
    
    [self.bannerView activateAutoscroll];
    [self updateBannerInfo];
    
}


- (void)updateAllInfo
{
    [self updateDashletsInfo];
    [self updateBannerInfo];
    
}


#pragma mark - Update Dashlet Info

- (void)updateDashletsInfo
{
    _dataRequest = [JPDataRequest request];
    _dataRequest.delegate = self;
    
    [_dataRequest requestAllSchoolsAllFields:NO];
    
}


- (void)dataRequest:(JPDataRequest *)request didLoadAllItemsOfType:(JPDashletType)type allFields:(BOOL)fullFields withDataArray:(NSArray *)array isSuccessful:(BOOL)success
{
    if(!success)
        return;
    
    NSMutableArray* dashletArray = [NSMutableArray array];
    
    for(NSDictionary* schoolDict in array)
    {
        JPDashlet* dashlet = [[JPDashlet alloc] initWithDictionary:schoolDict ofDashletType:type];
        [dashletArray addObject:dashlet];
    }
    
    self.dashlets = dashletArray;

}



//Retrieving College info from Core Data and put into self.dashlets
- (void)updateDashletsInfoFromCoreData
{
    NSFetchRequest* dashletRequest = [NSFetchRequest fetchRequestWithEntityName:@"School"];
    dashletRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    NSError* err = nil;
    NSArray* schoolArray = [context executeFetchRequest:dashletRequest error:&err];
    if(err)
        JPLog(@"ERR: %@", err);
    
    NSMutableArray* dashletArray = [NSMutableArray array];
    
    for(School* school in schoolArray)
    {
        JPDashlet* dashlet = [[JPDashlet alloc] initWithSchool:school];
        [dashletArray addObject:dashlet];
    }
    
    self.dashlets = dashletArray;
}



- (void)updateBannerInfo
{
    NSFetchRequest* bannerRequest = [NSFetchRequest fetchRequestWithEntityName:@"Banner"];
    bannerRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"bannerId" ascending:YES]];
    
    NSError* err = nil;
    NSArray* bannerArray = [context executeFetchRequest:bannerRequest error:&err];
    if(err)
        JPLog(@"ERR: %@", err);
    
    self.bannerURLs = [NSMutableArray array];
    
    for(Banner* banner in bannerArray)
    {
        NSURL* bannerURL = [NSURL URLWithString:banner.bannerLink];
        [self.bannerURLs addObject: bannerURL];
    }
    
    [self.bannerView setImgArrayURL:self.bannerURLs];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.bannerView pauseAutoscroll];
}

@end
