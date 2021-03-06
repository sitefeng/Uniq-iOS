//
//  iPhSettingsAboutViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/18/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhSettingsAboutViewController.h"
#import "JPGlobal.h"
#import "JPFont.h"

@interface iPhSettingsAboutViewController ()

@end

@implementation iPhSettingsAboutViewController

- (id)initWithName: (NSString*)name
{
    self = [super initWithNibName:nil bundle:nil];
    
    self.name = name;
    self.title = name;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.descriptionView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-kiPhoneTabBarHeight)];
    self.descriptionView.backgroundColor = [UIColor clearColor];
    self.descriptionView.showsVerticalScrollIndicator = NO;
    self.descriptionView.editable = NO;
    self.descriptionView.selectable = NO;
    self.descriptionView.font = [UIFont fontWithName:[JPFont defaultThinFont] size:15];
    self.descriptionView.text = [JPGlobal paragraphStringWithName:self.name];
    
    [self.view addSubview:self.descriptionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
