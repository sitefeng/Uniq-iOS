//
//  JPMainHomeViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhMainSettingsViewController.h"
#import "JPFont.h"
#import "JPUserLocator.h"
#import "UniqAppDelegate.h"
#import "User.h"
#import "DXAlertView.h"
#import "iPhSettingsAboutViewController.h"
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import "Uniq-Swift.h"
#import "User.h"

@interface iPhMainSettingsViewController ()

@end

@implementation iPhMainSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.translucent = NO;
    self.tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight, kiPhoneWidthPortrait, kiPhoneHeightPortrait-kiPhoneTabBarHeight-kiPhoneStatusBarHeight-kiPhoneNavigationBarHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self.view addSubview:self.tableView];
    
    _cellSectionTitles = @[@"Utilities",@"General"];
    
    _cellTitleStrings = @[@[@"Locate Me", @"Download Contents", @"Notifications"],@[@"About", @"Rate Uniq on App Store", @"Send Feedback", @"Share This App", @"Authors", @"Special Thanks", @"Like on Facebook", @"Follow on Twitter"]];
    _cellImageStrings = @[@[@"distance-50",@"download-75",@"tones-75"],@[@"info-75",@"thumb_up-75",@"email-50",@"share-75",@"groups-75",@"thanks-75",@"facebook-50",@"twitter-50"]];
    
    UniqAppDelegate* del = [[UIApplication sharedApplication] delegate];
    context = [del managedObjectContext];
    
    NSFetchRequest* req = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSArray* userArray = [context executeFetchRequest:req error:nil];
    
    if([userArray count]>0)
    {
        _user = [userArray firstObject];
    }
    else
    {
        NSEntityDescription* userEntity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
        NSManagedObject* newUser = [[NSManagedObject alloc] initWithEntity:userEntity insertIntoManagedObjectContext:context];
        [context insertObject:newUser];
        _user = (User*)newUser;
    }
    
    _userLocator = [[JPUserLocator alloc] initWithUser:_user];
    _userLocator.delegate = self;
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}


#pragma mark - UI Table View Data Source and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_cellTitleStrings count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cellTitleStrings[section] count];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.imageView.contentScaleFactor = 0.9;
    cell.imageView.image = [UIImage imageNamed:_cellImageStrings[indexPath.section][indexPath.row]];
    cell.textLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:16];
    cell.textLabel.text = _cellTitleStrings[indexPath.section][indexPath.row];
    
    if(indexPath.section==1 && (indexPath.row == 0 || indexPath.row == 5 || indexPath.row == 4))
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if(indexPath.section == 0 && indexPath.row== 0 && _user.locationString!= nil && ![_user.locationString isEqual:@""])
    {
        cell.textLabel.text = [NSString stringWithFormat:@"Location: %@", _user.locationString];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark-64"]];
        imageView.frame = CGRectMake(0, 0, 30, 30);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.accessoryView = imageView;
    } else{
        cell.accessoryView = nil;
    }
    
    return cell;
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _cellSectionTitles[section];
}


- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0: {
                if(_user.locationString!= nil && ![_user.locationString isEqual:@""])
                {
                    [[[UIAlertView alloc] initWithTitle:@"User Location" message:[NSString stringWithFormat:@"Your Location is currently set to %@", _user.locationString] delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:@"Update", nil] show];
                }
                else {
                    [_userLocator startLocating];
                }
                break;
            }
            case 1: {
                
                break;
            }
            case 2: {
                
                break;
            }
            default:
                break;
        }
        
    }
    else if(indexPath.section == 1)
    {
        iPhSettingsAboutViewController* aboutController = [[iPhSettingsAboutViewController alloc] initWithName:_cellTitleStrings[1][indexPath.row]];
        switch (indexPath.row)
        {
            case 0: {
                [self.navigationController pushViewController:aboutController animated:YES];
                break;
            }
            case 1: {
                //TODO: this
                NSURL* url = [NSURL URLWithString:@"http://www.yahoo.com"];
                [[UIApplication sharedApplication] openURL:url];
                break;
            }
            case 2: {
                _mailController = [[MFMailComposeViewController alloc] init];
                if([MFMailComposeViewController canSendMail])
                {
                    _mailController.mailComposeDelegate = self;
                    NSString* recipient = @"technochimera@gmail.com";
                    [_mailController setToRecipients: @[recipient]];
                    [self presentViewController:_mailController animated:YES completion:nil];
                }
                else
                {
                    [[[UIAlertView alloc] initWithTitle:@"Cannot Send Mail" message:@"Please Add a mail account in Settings app and ensure valid Internet Connection" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
                }
         
                break;
            }
            case 3: {
                UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"Share Uniq" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share on Facebook", @"Post on Twitter", @"Tell The Person Beside", nil];
                [actionSheet showFromTabBar:self.tabBarController.tabBar];
                break;
            }
            case 4: {
                iPadSettingsAuthorsTableViewController* tableController = [[iPadSettingsAuthorsTableViewController alloc] initWithStyle:UITableViewStylePlain];
                tableController.title = @"Authors";
                [self.navigationController pushViewController:tableController animated:YES];
                break;
            }
            case 5: {
                [self.navigationController pushViewController:aboutController animated:YES];
                break;
            }
            case 6: {
                NSURL* url = [NSURL URLWithString:@"http://www.facebook.com"];
                [[UIApplication sharedApplication] openURL:url];
                break;
            }
            case 7: {
                NSURL* url = [NSURL URLWithString:@"http://www.twitter.com"];
                [[UIApplication sharedApplication] openURL:url];
                
                break;
            }
            default:
                break;
        }
        
        
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Various Delegate Methods

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* message = @"Checkout Uniq for iOS! Personal College Application Guide.";
    UIImage* image = [UIImage imageNamed:@"appIcon-152"];
    NSURL* link = [NSURL URLWithString:@"http://www.google.com"];//TODO: this
    
    if(buttonIndex==0)//facebook
    {
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            SLComposeViewController* facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [facebook setInitialText:message];
            [facebook addImage:image];
            [facebook addURL:link];
            [self presentViewController:facebook animated:YES completion:nil];
        }
        else {
            [[[UIAlertView alloc] initWithTitle:@"Cannot Share Yet" message:@"Please login to Facebook first in the Settings app" delegate:nil cancelButtonTitle: @"Okay"otherButtonTitles: nil] show];
        }
    }
    else if(buttonIndex == 1)
    {
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController* twitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [twitter setInitialText:message];
            [twitter addURL: link];
            [twitter addImage:image];
            [self presentViewController:twitter animated:YES completion:nil];
        }
        else {
            [[[UIAlertView alloc] initWithTitle:@"Cannot Share Yet" message:@"Please login to Twitter first in the Settings app" delegate:nil cancelButtonTitle: @"Okay"otherButtonTitles: nil] show];
        }
    }
    else if(buttonIndex == 2)
    {
       [[[UIAlertView alloc] initWithTitle:@"Thanks" message:@"Thank you for spreading the word!" delegate:nil cancelButtonTitle:@"No Problem" otherButtonTitles: nil] show];
    }

    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) //Canceled
    {
       
    }
    else
    {
        [_userLocator startLocating];
    }
    
}



#pragma mark - JP User Locator Delegate

- (void)userLocatedWithLocationName:(NSString *)name coordinates:(CLLocationCoordinate2D)coord
{
    
    [[[UIAlertView alloc] initWithTitle:@"Location Saved" message:[NSString stringWithFormat:@"You are currently in %@. Now you can take advantage of more features within the app!", name] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
    [self.tableView reloadData];

}


- (BOOL)shouldSaveUserLocation
{
    return YES;
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
