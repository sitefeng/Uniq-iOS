//
//  iPhImageScrollView.m
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPhImagePanView.h"
#import "JPFont.h"
#import "iPadProgramImagesViewController.h"
#import "AsyncImageView.h"

#import "School.h"
#import "Faculty.h"
#import "Program.h"
#import "ImageLink.h"
#import "AsyncImageView.h"

@implementation iPhImagePanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame offset:0];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame offset: (float)yOff
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [JPStyle colorWithName:@"tWhite"];
        
        _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, yOff, frame.size.width, frame.size.width/4*3 )];
        _imageScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blackBackground"]];
        _imageScrollView.showsHorizontalScrollIndicator = NO;
        _imageScrollView.pagingEnabled = YES;
        _imageScrollView.clipsToBounds = YES;
        _imageScrollView.contentSize = CGSizeMake(_imageScrollView.frame.size.width, 0);
        
        //No Photo Label
        _noPhotoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 150)];
        _noPhotoLabel.center = _imageScrollView.center;
        _noPhotoLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:25];
        _noPhotoLabel.textColor = [UIColor whiteColor];
        _noPhotoLabel.numberOfLines = 2;
        _noPhotoLabel.textAlignment = NSTextAlignmentCenter;
        _noPhotoLabel.text = @"No Photos\nAvailable";
        [_imageScrollView addSubview:_noPhotoLabel];
        
        [self addSubview:_imageScrollView];
        
        
        UIView* bottomVisibleView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 30, frame.size.width, 30)];
        [self addSubview:bottomVisibleView];
        
        _dragBar = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2.0 - 15, 5, 30, 20)];
        _dragBar.image = [UIImage imageNamed:@"dragBarIcon"];
        [bottomVisibleView addSubview:_dragBar];
        
        UILabel* dragBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
        dragBarLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
        dragBarLabel.textColor = [UIColor blackColor];
        dragBarLabel.text = @"Images";
        [bottomVisibleView addSubview:dragBarLabel];
        
        
        
    }
    return self;
}



- (void)reloadImageScrollView
{
    CGFloat currXPosition = 0;
    for(NSURL* url in self.imageURLs)
    {
        AsyncImageView* imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(currXPosition, 0, _imageScrollView.frame.size.width, _imageScrollView.frame.size.height) withPlaceholder:YES];
        imageView.imageURL = url;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [_imageScrollView addSubview:imageView];
        
        currXPosition += imageView.frame.size.width;
        
    }
    
    _imageScrollView.contentSize = CGSizeMake(currXPosition, _imageScrollView.frame.size.height - 64);
    
}


- (void)setSchool:(School *)school
{
    _school = school;
    
    NSArray* imageLinks = [school.images allObjects];
    NSMutableArray* urls = [NSMutableArray array];
    for(ImageLink* link in imageLinks)
    {
        NSString* linkString = link.imageLink;
        NSURL* url = [NSURL URLWithString:linkString];
        if(url)
           [urls addObject:url];
    }
    
    self.imageURLs = urls;
    
    _imageType = JPDashletTypeSchool;
    
    [self reloadImageScrollView];
}

- (void)setProgram:(Program *)program
{
    _program = program;
    NSArray* imageLinks = [program.images allObjects];
    NSMutableArray* urls = [NSMutableArray array];
    for(ImageLink* link in imageLinks)
    {
        NSString* linkString = link.imageLink;
        NSURL* url = [NSURL URLWithString:linkString];
        if(url)
            [urls addObject:url];
    }
    
    self.imageURLs = urls;

    _imageType = JPDashletTypeProgram;
    [self reloadImageScrollView];
}


- (void)setFaculty:(Faculty *)faculty
{
    _faculty = faculty;
    NSArray* imageLinks = [faculty.images allObjects];
    NSMutableArray* urls = [NSMutableArray array];
    for(ImageLink* link in imageLinks)
    {
        NSString* linkString = link.imageLink;
        NSURL* url = [NSURL URLWithString:linkString];
        if(url)
            [urls addObject:url];
    }
    
    self.imageURLs = urls;
    _imageType = JPDashletTypeFaculty;
    [self reloadImageScrollView];
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
