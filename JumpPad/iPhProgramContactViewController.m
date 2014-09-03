//
//  iPhProgramContactViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//


#import "iPhProgramContactViewController.h"
#import "Program.h"
#import "Faculty.h"
#import "School.h"
#import "JPFont.h"
#import "iPhMapPanView.h"
#import "JPStyle.h"

@interface iPhProgramContactViewController ()

@end

@implementation iPhProgramContactViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edgeBackground"]];
    
    _mapPanView = [[iPhMapPanView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight - 240, kiPhoneWidthPortrait, 270)];
    _mapPanView.school = self.program.faculty.school;
    UIPanGestureRecognizer* panRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewPanned:)];
    [_mapPanView addGestureRecognizer:panRec];
    [self.view addSubview:_mapPanView];
    _imageViewYBeforePan = _mapPanView.frame.origin.y;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+30, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait-30) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self.view addSubview:self.tableView];
    
    
    [self.view bringSubviewToFront:_mapPanView];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(!self.school)
        return 0;
    else
        return 2;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0)
        return @"School Info";
    else
        return @"Contact Info";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
        return 2;
    else
    {
        NSArray* infoArray = [self getInformationArrayOfType:@"imageNames"];
        return [infoArray count] -2;
    }
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseIdentifier"];

    if(indexPath.section == 0)
    {
        cell.textLabel.text = [[self getInformationArrayOfType:@"labelNames"] objectAtIndex:indexPath.row];
        NSString* value = [[self getInformationArrayOfType:@"values"] objectAtIndex:indexPath.row];
        NSCharacterSet* chars = [NSCharacterSet newlineCharacterSet];
        NSArray* components = [value componentsSeparatedByCharactersInSet:chars];
        NSMutableString* detailLabelString = [@"" mutableCopy];
        for(NSString* comp in components)
        {
            [detailLabelString appendString:comp];
        }
        cell.detailTextLabel.text = detailLabelString;
        cell.imageView.image = [UIImage imageNamed:[[self getInformationArrayOfType:@"imageNames"] objectAtIndex:indexPath.row]];
    }
    else
    {
        cell.textLabel.text = [[self getInformationArrayOfType:@"labelNames"] objectAtIndex:indexPath.row+2];
        cell.detailTextLabel.text = [[self getInformationArrayOfType:@"values"] objectAtIndex:indexPath.row+2];
        UIImage* whiteCellImage = [UIImage imageNamed:[[self getInformationArrayOfType:@"imageNames"] objectAtIndex:indexPath.row+2]];
        cell.imageView.image = [whiteCellImage imageWithColor: [UIColor blackColor]];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSURL* url = [NSURL URLWithString:[[self getInformationArrayOfType:@"values"] objectAtIndex:indexPath.row+2 ]];
    
    if(url)
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Cannot Open Webpage" message:@"Sorry, the URL cannot be opened at the moment. Information might be incorrect." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil] show];
    }
    
    
}



- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.section == 0)
        return NO;
    
    if(_itemType == JPDashletTypeFaculty || _itemType == JPDashletTypeSchool)
        return YES;
    
    else
    {
        switch (indexPath.row) {
            case 0:
                return NO;
                break;
            case 1:
                return NO;
                break;
            case 2:
                return NO;
                break;
            case 3:
                return YES;
                break;
            case 4:
                return YES;
                break;
            case 5:
                return YES;
                break;
            default:
                return NO;
                break;
        }
    }
}







- (void)imageViewPanned: (UIPanGestureRecognizer*)recognizer
{
    const float minPosition = -176;
    const float maxPosition = 64;
    
    UIView* pannedView = recognizer.view;
    CGRect  pastFrame = pannedView.frame;
    CGFloat yPosition = pastFrame.origin.y;
    
    if(recognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:pannedView];
        
        if((translation.y >= 0 && yPosition < 64) || (translation.y <= 0 && yPosition > -176)) //going down||going up
        {
            [pannedView setFrame:CGRectMake(pastFrame.origin.x, _imageViewYBeforePan + translation.y, pastFrame.size.width, pastFrame.size.height)];
        }
        
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        _imageViewYBeforePan = pannedView.frame.origin.y;
        
        if(fabs(_imageViewYBeforePan - 64) > 2 ||fabs(_imageViewYBeforePan - (-176)) > 2)
        {
            [UIView animateWithDuration:0.2 delay:0 options: UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 
                                 if (yPosition > minPosition + (maxPosition - minPosition)/2.0 + 30)
                                 {
                                     [pannedView setFrame:CGRectMake(pastFrame.origin.x, 64, pastFrame.size.width, pastFrame.size.height)];
                                 }
                                 else
                                 {
                                     [pannedView setFrame:CGRectMake(pastFrame.origin.x, -176, pastFrame.size.width, pastFrame.size.height)];
                                 }
                                 
                             } completion:nil];
        }
        
        _imageViewYBeforePan = pannedView.frame.origin.y;
        
    }
    
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
