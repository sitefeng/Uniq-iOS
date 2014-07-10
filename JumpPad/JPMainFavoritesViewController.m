//
//  JPMainFavoritesViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPMainFavoritesViewController.h"
#import "UserFavItem.h"
#import "Banner.h"
#import "JPDashlet.h"
#import "JPBannerView.h"

@interface JPMainFavoritesViewController ()

@end

@implementation JPMainFavoritesViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //Core Data NS Managed Object Context

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    context = [delegate managedObjectContext];
    
    _isEditing = NO;
    
    //Initialize banner
    self.bannerURLs = [NSMutableArray array];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateDashletsInfo];
    
    [self.bannerView activateAutoscroll];
    [self updateBannerInfo];
    
    
    
    
}

#pragma mark - Update From Core Data
//Retrieving College info from Core Data and put into featuredDashelts
- (void)updateDashletsInfo
{
    NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
    
    favReq.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"itemId" ascending:YES]];
    
    NSError* err = nil;
    NSArray* favResults = [context executeFetchRequest:favReq error:&err];
    if(err)
        JPLog(@"ERR: %@", err);
    
    NSMutableArray* dashletArray = [NSMutableArray arrayWithObjects:[@[] mutableCopy],[@[] mutableCopy],[@[] mutableCopy], nil];
    
    _dashletTypeCounts = [NSMutableArray arrayWithObjects:@0,@0,@0, nil];
    for(UserFavItem* favItem in favResults)
    {
        JPDashlet* dashlet = [[JPDashlet alloc] initWithDashletUid:[favItem.itemId integerValue]];
        
        //Knowing which type exists for displaying dashelts
        NSInteger typeCount = [[_dashletTypeCounts objectAtIndex:dashlet.type] integerValue];
        [_dashletTypeCounts replaceObjectAtIndex:dashlet.type withObject: [NSNumber numberWithInteger:1+typeCount]];
        [dashletArray[dashlet.type] addObject:dashlet];
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
    
    for(Banner* banner in bannerArray)
    {
        NSURL* bannerURL = [NSURL URLWithString:banner.bannerLink];
        [self.bannerURLs addObject: bannerURL];
    }
    
    [self.bannerView setImgArrayURL:self.bannerURLs];
    
}



- (void)removeUnselectedFavoritesFromCoreData
{
    
    for (NSNumber* dashletUid in _favDashletsToDelete)
    {
        NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
        favReq.predicate = [NSPredicate predicateWithFormat:@"itemId = %@", dashletUid];
        NSArray* results = [context executeFetchRequest:favReq error:nil];
        
        for(UserFavItem* item in results)
        {
            [context deleteObject:item];
        }
    }
    
    [self updateDashletsInfo];
    [_favDashletsToDelete removeAllObjects];
}




- (void)editBarButtonPressed: (id)sender
{
    UIBarButtonItem* button = (UIBarButtonItem*)sender;
    
    if(_isEditing)
    {
        _isEditing = NO;
        button.title = @"Edit";
        
        [self removeUnselectedFavoritesFromCoreData];
    }
    else //start Editing
    {
        _isEditing = YES;
        button.title = @"Save";
        
        _favDashletsToDelete = [NSMutableArray array];
    }
    
    
}


- (void)favButtonPressedIsFavorited: (BOOL)fav dashletUid: (NSUInteger)dashletUid
{
    
    if(fav)
    {
        if([_favDashletsToDelete containsObject:[NSNumber numberWithInteger:dashletUid]])
        {
            [_favDashletsToDelete removeObject:[NSNumber numberWithInteger:dashletUid]];
        }
        
    }
    else //unfavorited the cell, add to delete list
    {
        [_favDashletsToDelete addObject:[NSNumber numberWithInteger:dashletUid]];
    }
}



- (void)setDashlets:(NSMutableArray *)dashlets
{
    if(!self.backupDashlets)
    {
        self.backupDashlets = [dashlets mutableCopy];
    }
    
    _dashlets = dashlets;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.bannerView pauseAutoscroll];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
