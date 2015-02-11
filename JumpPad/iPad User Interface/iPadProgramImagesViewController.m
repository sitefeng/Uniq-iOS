//
//  iPadProgramImagesViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramImagesViewController.h"
#import "JPFont.h"
#import "UniqAppDelegate.h"
#import "AsyncImageView.h"
#import "Program.h"
#import "School.h"
#import "Faculty.h"

@interface iPadProgramImagesViewController ()

@end


//ImageSize (364,273) within  ProgImgVCSize (384x308)


@implementation iPadProgramImagesViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _currentType = -1;
        
        self.view.backgroundColor = [UIColor clearColor];
        self.view.clipsToBounds = YES;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 10, 364, 273)];
        self.scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blackBackground"]];
        self.scrollView.layer.cornerRadius = 15;
        self.scrollView.clipsToBounds = YES;
        
        [self.scrollView setPagingEnabled:YES];
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        self.scrollView.delegate = self;
        
        //////**************************
        self.urls = [NSMutableArray array];
        self.asyncImageViews = [NSMutableArray array];
        
        /////*****************************
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 290, 364 + 10, 10)];
        self.pageControl.currentPage = 0;
        self.pageControl.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin);
        
        [self.view addSubview:self.scrollView];
        [self.view addSubview:self.pageControl];
        
        //No Photo Label
        _noPhotoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 150)];
        _noPhotoLabel.center = self.scrollView.center;
        _noPhotoLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:25];
        _noPhotoLabel.textColor = [UIColor whiteColor];
        _noPhotoLabel.numberOfLines = 2;
        _noPhotoLabel.textAlignment = NSTextAlignmentCenter;
        _noPhotoLabel.text = @"No Photos\nAvailable";
        _noPhotoLabel.hidden = NO;
        [self.view addSubview:_noPhotoLabel];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Never called because of adding the view controller manually
    
}


- (void)setProgram:(Program *)program
{
    _program = program;
    
    _currentType = JPDashletTypeProgram;
    [self reloadImages];
}


- (void)setSchool:(School *)school
{
    _school = school;
    _currentType = JPDashletTypeSchool;
    [self reloadImages];
}

- (void)setFaculty:(Faculty *)faculty
{
    _faculty = faculty;
    _currentType = JPDashletTypeFaculty;
    [self reloadImages];
}



- (void)reloadImages
{
    [self.urls removeAllObjects];
    [self.asyncImageViews removeAllObjects];
    
    NSArray* imageDictArray = [NSArray array];
    
    //Setting the images(imgLink, descriptor) from the Core Data managed object
    if(_currentType == JPDashletTypeProgram)
    {
        imageDictArray = [self.program.images allObjects];
    }
    else if(_currentType == JPDashletTypeSchool)
    {
        imageDictArray = [self.school.images allObjects];
    }
    else if(_currentType == JPDashletTypeFaculty)
    {
        imageDictArray = [self.faculty.images allObjects];
    }
    else
        NSLog(@"Detail Image wrong item type");
    
    int i = 0;
    
    for(NSDictionary* dict in imageDictArray)
    {
        NSString* path = [dict valueForKey:@"imageLink"];
        
        NSURL* url = [NSURL URLWithString: path];
        
        if(url)
        {
            [self.urls addObject:url];
        }
        else
        {
            JPLog(@"Invalid URL[%@]", path);
        }
        
        
        AsyncImageView* asyncImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(i*364, -64, 364, 273)];
        
        asyncImageView.imageURL = url;
        asyncImageView.activityIndicatorStyle = UIActivityIndicatorViewStyleWhiteLarge;
        asyncImageView.showActivityIndicator = YES;
        asyncImageView.clipsToBounds = YES;
        [self.asyncImageViews addObject:asyncImageView];
        
        [self.scrollView addSubview:self.asyncImageViews[i]];
        
        //Placeholder image
        UIImageView* placeholderView = [[UIImageView alloc] initWithFrame:asyncImageView.frame];
        placeholderView.image = [UIImage imageNamed:@"placeholderWhite"];
        [self.scrollView addSubview:placeholderView];
        
        [self.scrollView exchangeSubviewAtIndex:0+ i*2 withSubviewAtIndex:1 + i*2];
        
        i++;
    }
    
    [self.scrollView setContentSize:CGSizeMake(i*364, 10)];//273
    [self.scrollView setNeedsDisplay];
    
    self.pageControl.numberOfPages = i;
    
    //Hide No Photos Label;
    if(i>0)
        _noPhotoLabel.hidden = YES;
    else
        _noPhotoLabel.hidden = NO;
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float position = self.scrollView.contentOffset.x;
    
    int pageNumber = (int)position/364; //starts from 0
    
    self.pageControl.currentPage = pageNumber;
    
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
