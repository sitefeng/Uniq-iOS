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
#import "JPCoreDataHelper.h"


@interface JPProgramAcademicsViewController ()

@end

@implementation JPProgramAcademicsViewController

- (id)initWithProgram: (Program*)program
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        
        context = [(UniqAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
        
        _coreDataHelper = [[JPCoreDataHelper alloc] init];
        
        self.program = program;
        [self selectCalendarButtonsFromCoreData];
        
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
    favReq.predicate = [NSPredicate predicateWithFormat: @"favItemId = %@", self.program.programId];
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
            [_coreDataHelper removeFavoriteWithItemId:self.program.programId withType:JPDashletTypeProgram];
            _userFav = nil;
            
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
                    [_coreDataHelper removeFavoriteWithItemId:self.program.programId withType:JPDashletTypeProgram];
                    _userFav = nil;
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



- (void)createNewFavItem
{
    [_coreDataHelper addFavoriteWithItemId:self.program.programId andType:JPDashletTypeProgram];
    
    NSFetchRequest* favReq = [[NSFetchRequest alloc] initWithEntityName:@"UserFavItem"];
    favReq.predicate = [NSPredicate predicateWithFormat: @"favItemId = %@", self.program.programId];
    NSArray* favArray = [context executeFetchRequest:favReq error:nil];
    _userFav = [favArray firstObject];
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
