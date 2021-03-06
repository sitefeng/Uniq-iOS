//
//  JBParallaxCell.m
//  JBParallaxTable
//
// The MIT License (MIT)
//
// Copyright (c) 2014 Javier Berlana @jberlana
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "JBParallaxCell.h"
#import "JPFont.h"
#import "JPStyle.h"

@interface JBParallaxCell()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;

@end

@implementation JBParallaxCell //768: 483

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.clipsToBounds = YES;
        
        self.parallaxImage = [[UIImageView alloc] init];
        self.parallaxImage.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.parallaxImage.image = [UIImage imageNamed:@"defaultProgram"];
        
        _asyncImageView = [[AsyncImageView alloc] initWithFrame:CGRectZero];
        _asyncImageView.autoresizesSubviews = UIViewAutoresizingFlexibleWidth;
        [self.parallaxImage addSubview:_asyncImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:30];
        self.titleLabel.textColor = [UIColor whiteColor];
        
        self.subtitleLabel = [[UILabel alloc] init];
        self.subtitleLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:20];
        self.subtitleLabel.textColor = [UIColor whiteColor];
        
        self.titleLabel.frame =CGRectMake(20, 10, 700, 40);
        self.subtitleLabel.frame = CGRectMake(20, 45, 700, 30);
        
        
        self.favoriteButton = [[UIButton alloc] initWithFrame:CGRectMake(kiPadWidthPortrait - 65, 23, 40, 40)];
        [self.favoriteButton setImage:[UIImage imageNamed:@"favoriteIcon"] forState:UIControlStateNormal];
        [self.favoriteButton setImage:[UIImage imageNamed:@"favoriteIconHighlighted"] forState:UIControlStateHighlighted];
        [self.favoriteButton setImage:[UIImage imageNamed:@"favoriteIconSelected"] forState:UIControlStateSelected];
        [self.favoriteButton addTarget:self action:@selector(favoriteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        //Bottom Bar
        _bottomBarView = [[UIView alloc] init];
        _bottomBarView.backgroundColor = [JPStyle colorWithName: @"tBlack"];
        
        [_bottomBarView addSubview:self.titleLabel];
        [_bottomBarView addSubview:self.subtitleLabel];
        [_bottomBarView addSubview:self.favoriteButton];
        
        
        //Top Bar
        _topBarView = [[UIView alloc] init];
        _topBarView.backgroundColor = [UIColor whiteColor];
        
        _favNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kiPadWidthPortrait - 220, 2, 200, 16)];
        _favNumLabel.font = [UIFont fontWithName:[JPFont defaultLightFont] size:16];
        _favNumLabel.text = @"0 Favorited";
        _favNumLabel.textAlignment = NSTextAlignmentRight;
        [_topBarView addSubview:_favNumLabel];
        
        
        [self addSubview:self.parallaxImage];
        [self addSubview:_topBarView];
        [self addSubview:_bottomBarView];
        
    }
    return self;
}



- (void)layoutSubviews {
    [super layoutSubviews];
 
    self.parallaxImage.frame = CGRectMake(0, -116, kiPadWidthPortrait, 483);
    _asyncImageView.frame = CGRectMake(0, 0, self.parallaxImage.frame.size.width, self.parallaxImage.frame.size.height);
    
    _bottomBarView.frame= CGRectMake(0, 270 - 80, kiPadWidthPortrait, 80);
    
    _topBarView.frame = CGRectMake(0, 0, kiPadWidthPortrait, 20);
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


- (void)setNumFavorited:(NSUInteger)numFavorited
{
    _numFavorited = numFavorited;
    
    _favNumLabel.text = [NSString stringWithFormat:@"%lu Favorited", (unsigned long)numFavorited];
}



- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view
{
    CGRect rectInSuperview = [tableView convertRect:self.frame toView:view];
    
    float distanceFromCenter = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rectInSuperview);
    float difference = CGRectGetHeight(self.parallaxImage.frame) - CGRectGetHeight(self.frame);
    float move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;
    
    CGRect imageRect = self.parallaxImage.frame;
    imageRect.origin.y = -(difference/2)+move;
    self.parallaxImage.frame = imageRect;
}




- (void)favoriteButtonPressed: (UIButton*)button
{
    
    if(!button.selected) //Selecting the button
    {
        button.selected = YES;
        [self.delegate favoriteButtonSelected:YES forCell:self];
    }
    else //Deselecting
    {
        button.selected = NO;
        [self.delegate favoriteButtonSelected:NO forCell:self];
    }
    
}








- (void)setAsyncImageUrl:(NSURL *)asyncImageUrl
{
    _asyncImageUrl = asyncImageUrl;
    
    if(asyncImageUrl)
        _asyncImageView.imageURL = asyncImageUrl;
}



- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = [title uppercaseString];
}

- (void)setSubtitle:(NSString *)subtitle
{
    _subtitle = subtitle;
    
    self.subtitleLabel.text = [subtitle uppercaseString];
}










@end
