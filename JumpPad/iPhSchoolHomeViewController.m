//
//  iPhSchoolHomeViewController.m
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhSchoolHomeViewController.h"

@interface iPhSchoolHomeViewController ()

@end

@implementation iPhSchoolHomeViewController

- (instancetype)initWithDashletUid: (NSUInteger)dashletUid itemType: (NSUInteger)type
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.dashletUid=  dashletUid;
        self.type = type;
        
        UniqAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        context = [delegate managedObjectContext];
        
        //Navbar dismiss button
        UIBarButtonItem* dismissButton = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStyleDone target:self action:@selector(dismissButtonPressed:)];
        self.navigationItem.leftBarButtonItem = dismissButton;

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
}


#pragma mark - Navigation Bar Item Callbacks
- (void)dismissButtonPressed: (UIBarButtonItem*)button
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
