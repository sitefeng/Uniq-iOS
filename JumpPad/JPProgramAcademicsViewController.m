//
//  JPProgramAcademicsViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/19/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPProgramAcademicsViewController.h"
#import "Program.h"
#import "UserFavItem.h"

@interface JPProgramAcademicsViewController ()

@end

@implementation JPProgramAcademicsViewController

- (id)initWithDashletUid: (NSUInteger)dashletUid program: (Program*)program
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        
        context = [(UniqAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
        
        self.dashletUid = dashletUid;
        self.program = program;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self selectCalendarButtonsFromCoreData];
}


- (void)selectCalendarButtonsFromCoreData
{
    NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
    favReq.predicate = [NSPredicate predicateWithFormat: @"itemId = %@", [NSNumber numberWithInteger:self.dashletUid]];
    NSArray* favArray = [context executeFetchRequest:favReq error:nil];
    
    if([favArray count] > 0)
    {
        _userFav = [favArray firstObject];
        
        for(int i=0; i<5; i++)
        {
            UIButton* button = (UIButton*)_applicationButtons[i];
            
            switch (i) {
                case 0:
                    button.selected = YES;
                    break;
                case 1:
                    button.selected = [_userFav.researched boolValue];
                    break;
                case 2:
                    button.selected = [_userFav.applied boolValue];
                    break;
                case 3:
                    button.selected = [_userFav.response boolValue];
                    break;
                case 4:
                    button.selected = [_userFav.gotOffer boolValue];
                    break;
                default:
                    break;
            }
        }
        
    }
    else
    {
        for(UIButton* button in _applicationButtons)
        {
            button.selected = NO;
        }
    }
}

- (void)calendarButtonPressed: (UIButton*)button
{
    [UIView animateWithDuration:0.9 animations:^{
        
        if(button.selected == false)
        {
            //Delete duplicates from before
            [self deletePastDuplicateFavItems];
            //Add one new fav item
            [self createNewFavItem];
            
            switch (button.tag) {
                case 4:{
                    _userFav.gotOffer = [NSNumber numberWithBool:YES];
                }
                case 3:
                {
                    _userFav.response = [NSNumber numberWithBool:YES];
                }
                case 2:
                {
                    _userFav.applied = [NSNumber numberWithBool:YES];
                }
                case 1:
                {
                    _userFav.researched = [NSNumber numberWithBool:YES];
                    break;
                }
                default:
                    break;
            }
            
        }
        else //deselect button
        {
            switch (button.tag) {
                case 0:
                    [self deletePastDuplicateFavItems];
                    break;
                case 1:
                    _userFav.researched = [NSNumber numberWithBool:NO];
                case 2:
                    _userFav.applied = [NSNumber numberWithBool:NO];
                case 3:
                    _userFav.response = [NSNumber numberWithBool:NO];
                case 4:
                    _userFav.gotOffer = [NSNumber numberWithBool:NO];
                    break;
                default:
                    break;
            }
            
        }
        
        [context save:nil];
        [self selectCalendarButtonsFromCoreData];
        
    } completion:nil];

}


- (void)deletePastDuplicateFavItems
{
    _userFav = nil;
    NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
    favReq.predicate = [NSPredicate predicateWithFormat: @"itemId = %@", [NSNumber numberWithInteger:self.dashletUid]];
    NSArray* favArray = [context executeFetchRequest:favReq error:nil];
    for(UserFavItem* item in favArray)
    {
        [context deleteObject:item];
    }
}

- (void)createNewFavItem
{
    NSEntityDescription* description = [NSEntityDescription entityForName:@"UserFavItem" inManagedObjectContext:context];
    _userFav = (UserFavItem*)[[NSManagedObject alloc] initWithEntity:description insertIntoManagedObjectContext:context];
    
    _userFav.itemId = [NSNumber numberWithInteger:self.dashletUid];
    _userFav.type = [NSNumber numberWithInteger:JPDashletTypeProgram];
    _userFav.researched = @NO;
    _userFav.applied = @NO;
    _userFav.response = @NO;
    _userFav.gotOffer = @NO;
    [context insertObject:_userFav];
}



- (void)setDashletUid:(NSUInteger)dashletUid
{
    _dashletUid = dashletUid;
    [self selectCalendarButtonsFromCoreData];
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
