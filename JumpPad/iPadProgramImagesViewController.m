//
//  iPadProgramImagesViewController.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-06.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramImagesViewController.h"

#import "JumpPadAppDelegate.h"
#import "AsyncImageView.h"
#import "Program.h"

@interface iPadProgramImagesViewController ()

@end


//ImageSize (364,273) within  ProgImgVCSize (384x308)


@implementation iPadProgramImagesViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        self.view.backgroundColor = [UIColor clearColor];
        self.view.clipsToBounds = YES;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 10, 364, 273)];
        self.scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blackBackground"]];
        self.scrollView.layer.cornerRadius = 60;
        self.scrollView.clipsToBounds = YES;
        
        [self.scrollView setPagingEnabled:YES];
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        self.scrollView.delegate = self;
        
        //////**************************
        self.urls = [NSMutableArray array];
        self.asyncImageViews = [NSMutableArray array];
        
//       [self reloadImages] // wait until Program is set

        /////*****************************
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 294, 364, 10)];
        self.pageControl.currentPage = 0;
        [self.pageControl setCenter:CGPointMake(384/2, 294)];
        self.pageControl.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin);
        
        
        [self.view addSubview:self.scrollView];
        [self.view addSubview:self.pageControl];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    
    
}




- (void)setProgram:(Program *)program
{
    _program = program;
    
    [self reloadImages];
    
}






- (void)reloadImages
{
    
    [self.urls removeAllObjects];
    [self.asyncImageViews removeAllObjects];
    
    
    NSArray* imageDict = [self.program.images allObjects];
    
    int i =0;
    
    for(NSDictionary* dict in imageDict)
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
