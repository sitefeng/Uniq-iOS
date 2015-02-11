//
//  iPadProgramHexView.m
//  Uniq
//
//  Created by Si Te Feng on 2014-05-31.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramHexView.h"

#import "JPStyle.h"
#import "JPFont.h"

@implementation iPadProgramHexView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + kHexLineWidth, frame.size.height/4 - 42, frame.size.width - 20, 40)];
        self.titleLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:30];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:self.titleLabel];
        
        
        UIView* blueBar = [[UIView alloc] initWithFrame:CGRectMake(15 + kHexLineWidth + 2, frame.size.height/4 + 10, frame.size.width - 40, 5)];
        blueBar.layer.cornerRadius = 5;
        blueBar.clipsToBounds = YES;
        blueBar.backgroundColor = [UIColor whiteColor];
        [self addSubview:blueBar];
        
        
        
        
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef strokeColor = [UIColor whiteColor].CGColor;
    CGContextSetStrokeColorWithColor(context, strokeColor);
    
    CGContextSetLineWidth(context, 4);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGColorRef fillColor = [[JPStyle backgroundRainbowColorWithIndex:(arc4random()%6)] colorWithAlphaComponent:0.7].CGColor;
    CGContextSetFillColorWithColor(context, fillColor);
    
    CGContextMoveToPoint(context, rect.size.width/2.0, 2);
    
    CGPoint pointsToAdd[6] = {CGPointMake(kHexLineWidth, rect.size.height/4), CGPointMake(kHexLineWidth, rect.size.height/4*3), CGPointMake(rect.size.width/2, rect.size.height - 2), CGPointMake(rect.size.width - kHexLineWidth, rect.size.height/4*3), CGPointMake(rect.size.width -kHexLineWidth, rect.size.height/4), CGPointMake(rect.size.width/2, kHexLineWidth)};
    
    CGContextAddLines(context, pointsToAdd, 6);
    
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    
    
 
}


@end
