//
//  iPadSearchBarView.m
//  JumpPad
//
//  Created by Si Te Feng on 2/22/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadSearchBarView.h"
#import "JPStyle.h"

@implementation iPadSearchBarView

- (id)initWithFrame:(CGRect)f
{
    CGRect frame = CGRectMake(f.origin.x, f.origin.y, f.size.width, 44);
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [JPStyle searchBarBackgroundColor];
        
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 360, 44)];
        
        [self setupSearchBar];
        
        //Creating Sort Button
        self.sortButton = [[UIButton alloc] initWithFrame:CGRectMake(361, 0, 44, 44)];
        [self.sortButton addTarget:self
                       action:@selector(buttonPressed)
             forControlEvents:UIControlEventTouchDown];
        
        self.sortButton.tintColor = [UIColor whiteColor];

        self.sortButton.showsTouchWhenHighlighted = YES;
        [self.sortButton setTitle:@"Sort" forState:UIControlStateNormal];
        
        
        //Adding the Subviews
        [self addSubview:self.searchBar];
        [self addSubview:self.sortButton];
        
        
    }
    return self;
}


- (void)setupSearchBar
{
    
    self.searchBar.placeholder = kSearchBarPlaceholderText;
//    self.searchBar.text = @"Show All Universities";
    
    self.searchBar.showsCancelButton = NO;
    
    self.searchBar.barTintColor = [JPStyle searchBarBackgroundColor];
    self.searchBar.delegate = self;
    


}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
     [self.delegate searchBarSearchButtonClicked:searchBar];
}


- (void)buttonPressed
{
    [self.delegate sortButtonPressed];

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
