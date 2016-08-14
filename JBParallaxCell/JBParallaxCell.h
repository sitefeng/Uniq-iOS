//
//  JBParallaxCell.h
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

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

// NOT USING, DEPRECATED CELL INTENDED FOR THE IPAD

@protocol JPFavoriteButtonDelegate, AsyncImageView;
@interface JBParallaxCell : UITableViewCell
{
    UIView*   _topBarView;
    UILabel*  _favNumLabel;
    
    UIView*   _bottomBarView;
    
    AsyncImageView* _asyncImageView;
    
}

@property (strong, nonatomic) NSURL* asyncImageUrl;
@property (strong, nonatomic)  UIImageView *parallaxImage;

@property (nonatomic, strong) NSString* title;
@property (strong, nonatomic, readonly) UILabel *titleLabel;
@property (strong, nonatomic) NSString* subtitle;
@property (strong, nonatomic, readonly) UILabel *subtitleLabel;

@property (nonatomic) NSUInteger numFavorited;


@property (nonatomic, weak) id<JPFavoriteButtonDelegate> delegate;

@property (strong, nonatomic) NSString* itemId;
@property (strong, nonatomic) NSString *schoolSlug;
@property (strong, nonatomic) NSString *facultySlug;
@property (strong, nonatomic) NSString *programSlug;

@property (assign, nonatomic) JPDashletType type;

@property (strong, nonatomic) UIButton* favoriteButton;

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

@end


@protocol JPFavoriteButtonDelegate <NSObject>

- (void)favoriteButtonSelected: (BOOL)selected forCell: (id)sender;

@end