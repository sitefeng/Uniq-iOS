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

// For offline only
@property (nonatomic, strong) NSArray *bannerImageNames;

@property (nonatomic, strong) JPDataRequest *dataRequest;
@property (nonatomic, strong) JPOfflineDataRequest *offlineDataRequest;

@end

@implementation JPMainExploreViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSAssert(false, @"Not Imp");
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _bannerImageNames = @[@"banner1", @"banner2", @"banner3", @"banner4", @"banner5"];
        
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
    if (JPUtility.isOfflineMode) {
        _offlineDataRequest = [[JPOfflineDataRequest alloc] init];
        _offlineDataRequest.delegate = self;
        [_offlineDataRequest requestAllSchools];
        
    } else {
        _dataRequest = [JPDataRequest request];
        _dataRequest.delegate = self;
        
        [_dataRequest requestAllSchoolsAllFields:NO];
    }
}


- (void)offlineDataRequest:(JPOfflineDataRequest *)request didLoadAllItemsOfType:(JPDashletType)type dataArray:(NSArray *)dataArray isSuccessful:(BOOL)isSuccessful {
    
    [self finishedLoadItemsWithType:type dataArray:dataArray isSuccessful:isSuccessful];
}


- (void)dataRequest:(JPDataRequest *)request didLoadAllItemsOfType:(JPDashletType)type allFields:(BOOL)fullFields withDataArray:(NSArray *)array isSuccessful:(BOOL)success {
    [self finishedLoadItemsWithType:type dataArray:array isSuccessful:success];
}

- (void)finishedLoadItemsWithType: (JPDashletType)type dataArray:(NSArray *)dataArray isSuccessful: (BOOL)success {
    if(!success)
        return;
    
    NSMutableArray* dashletArray = [NSMutableArray array];
    
    for(NSDictionary* schoolDict in dataArray) {
        
        JPDashlet* dashlet = [[JPDashlet alloc] initWithDictionary:schoolDict ofDashletType:type];
        [dashletArray addObject:dashlet];
    }
    
    self.dashlets = dashletArray;
}


// Deprecated
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

#pragma mark Update Banners

- (void)updateBannerInfo
{
    if(JPUtility.isOfflineMode) {
        [self.bannerView setImgFileNames:self.bannerImageNames];
        
    } else {
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
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.bannerView pauseAutoscroll];
}

@end
