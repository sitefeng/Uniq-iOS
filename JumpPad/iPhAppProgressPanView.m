//
//  iPhAppProgressPanView.m
//  Uniq
//
//  Created by Si Te Feng on 7/13/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhAppProgressPanView.h"
#import "JPStyle.h"
#import "JPFont.h"
#import "UserFavItem.h"

@implementation iPhAppProgressPanView

- (instancetype)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectCalendarButtonsFromCoreData) name:kProgramFavoriteStatusDidChangeNotification object:nil];
        
        self.backgroundColor = [JPStyle colorWithName:@"tWhite"];
        UIView* bottomVisibleView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 30, frame.size.width, 30)];
        [self addSubview:bottomVisibleView];
        
        _dragBar = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2.0 - 15, 5, 30, 20)];
        _dragBar.image = [UIImage imageNamed:@"dragBarIcon"];
        [bottomVisibleView addSubview:_dragBar];
        
        UILabel* dragBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
        dragBarLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
        dragBarLabel.textColor = [UIColor blackColor];
        dragBarLabel.text = @"Progress";
        [bottomVisibleView addSubview:dragBarLabel];
        
        
        context = [(UniqAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
        
        UIView* whiteBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-30)];
        whiteBackground.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteBackground];
        
        //Processes
        NSArray* processNames = [NSArray arrayWithObjects: @"Favorited",@"Researched",@"Applied",@"Response",@"Got Offer", nil];
        
        self.applicationButtons = [NSMutableArray array];
        for(int i= 0; i<5; i++)
        {
            UIButton* processButton = [[UIButton alloc] initWithFrame:CGRectMake(35 + i*103, 70, 44, 44)];
            
            if(i==3)
            {
                processButton.frame = CGRectMake(86, 155, 44, 44);
            } else if(i==4) {
                processButton.frame = CGRectMake(190, 155, 44, 44);
            }
            
            [processButton setImage:[UIImage imageNamed:@"itemIncomplete"] forState:UIControlStateNormal];
            [processButton setImage:[UIImage imageNamed:@"itemComplete"] forState:UIControlStateSelected];
            [processButton setImage:[UIImage imageNamed:@"itemOverdue"] forState:UIControlStateHighlighted];
            processButton.tag = i;
            [processButton addTarget:self action:@selector(calendarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.applicationButtons addObject:processButton];
            [self addSubview:processButton];
            
            UILabel* processLabel = [[UILabel alloc] initWithFrame:CGRectMake(processButton.frame.origin.x - 20, processButton.frame.origin.y + processButton.frame.size.height + 4, processButton.frame.size.width + 40, 20)];
            processLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:15];
            processLabel.textAlignment = NSTextAlignmentCenter;
            processLabel.text = [processNames objectAtIndex:i];
            [self addSubview:processLabel];
        }

        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, 30)];
        titleLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:22];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"Application Progress";
        [self addSubview:titleLabel];
        
    }
    return self;
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
            UIButton* button = (UIButton*)self.applicationButtons[i];
            
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


- (void)calendarButtonPressed:(UIButton*)button
{
    [UIView animateWithDuration:0.9 animations:^{
        
        if(button.selected == false)
        {
            //Delete duplicates from before
            [self deletePastDuplicateFavItems];
            //Add one new fav item
            [self createNewFavItem];
            [self.delegate appProgressDidPressFavoriteButton];
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
                    [self.delegate appProgressDidPressFavoriteButton];
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



- (void)setDashletUid:(NSInteger)dashletUid
{
    _dashletUid=  dashletUid;
    [self selectCalendarButtonsFromCoreData];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
