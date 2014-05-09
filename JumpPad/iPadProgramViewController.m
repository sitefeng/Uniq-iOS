//
//  iPadProgramViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramViewController.h"


@interface iPadProgramViewController ()

@end

@implementation iPadProgramViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        

         self.vc1 = [[iPadProgramHomeViewController alloc] init];
         self.vc2 = [[iPadProgramAcademicsViewController alloc] init];
         self.vc3 = [[iPadProgramContactViewController alloc] init];
         self.vc4 = [[iPadProgramCompareViewController alloc] init];
         self.vc5 = [[iPadProgramRatingsViewController alloc] init];
     
        UINavigationController* nc1 = [[UINavigationController alloc]initWithRootViewController:self.vc1];
        UINavigationController* nc2 = [[UINavigationController alloc]initWithRootViewController:self.vc2];
        UINavigationController* nc3 = [[UINavigationController alloc]initWithRootViewController:self.vc3];
        UINavigationController* nc4 = [[UINavigationController alloc]initWithRootViewController:self.vc4];
        UINavigationController* nc5 = [[UINavigationController alloc]initWithRootViewController:self.vc5];
        
        self.viewControllers = @[nc1,nc2,nc3,nc4,nc5];
        
        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStyleDone target:self action:@selector(dismissViewController)];
        
        [self.vc1.navigationItem setLeftBarButtonItem:item];
        [self.vc2.navigationItem setLeftBarButtonItem:item];
        [self.vc3.navigationItem setLeftBarButtonItem:item];
        [self.vc4.navigationItem setLeftBarButtonItem:item];
        [self.vc5.navigationItem setLeftBarButtonItem:item];
        
        self.vc1.title = @"Home";
        self.vc1.tabBarItem.title = @"Home";

        self.vc2.title = @"Academics";
        self.vc2.tabBarItem.title = @"Academics";

        self.vc3.title = @"Contact";
        self.vc3.tabBarItem.title = @"Contact";

        self.vc4.title = @"Compare";
        self.vc4.tabBarItem.title = @"Compare";

        self.vc5.title = @"Ratings";
        self.vc5.tabBarItem.title = @"Ratings";
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    
    
}

- (void)dismissViewController
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
