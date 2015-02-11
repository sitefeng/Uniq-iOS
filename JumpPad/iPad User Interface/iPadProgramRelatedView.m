//
//  iPadProgramRelatedView.m
//  Uniq
//
//  Created by Si Te Feng on 2014-05-31.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramRelatedView.h"

#import "JPFont.h"
#import "JPStyle.h"

#import "iPadProgramRelatedViewCell.h"

@implementation iPadProgramRelatedView

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
        self.titleLabel.text = @"Related";
        
        [self addSubview:self.titleLabel];
        
        
        UIView* white = [[UIView alloc] initWithFrame:CGRectMake(15 + kHexLineWidth + 2, frame.size.height/4 + 10, frame.size.width - 40, 2)];
        white.layer.cornerRadius = 5;
        white.clipsToBounds = YES;
        white.backgroundColor = [UIColor whiteColor];
        [self addSubview:white];
        
        
        /////////////////////////////////////////////////
        
        _noContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2 - 200, frame.size.height/2 - 20, 400, 40)];
        _noContentLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        _noContentLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:25];
        _noContentLabel.textAlignment = NSTextAlignmentCenter;
        _noContentLabel.text = @"NO RELATED PROGRAMS";
        [self addSubview:_noContentLabel];
        
        
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, frame.size.height/4 + 20, kiPadWidthPortrait, frame.size.height/2 - 40)];
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        [self addSubview:_scrollView];
        
        
        
        
        
    }
    return self;
}



- (void)reloadData
{
    NSUInteger cellNumber = [self.dataSource numberOfCellsForRelatedView:self];
    
    if(cellNumber != 0 || ![self.dataSource respondsToSelector:@selector(relatedView:cellTitleForCellAtPosition:)])
    {
        _noContentLabel.text = @"";
    }
    
    
    CGFloat xPosition = 6;
    
    for(int i=0; i<cellNumber; i++)
    {
        NSString* programName = [self.dataSource relatedView:self cellTitleForCellAtPosition:i];
        if(!programName || [programName isEqualToString:@""])
        {
            programName = @"Unknown Program";
        }
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"iPadProgramRelatedViewCell" owner:self options:nil];
        
        iPadProgramRelatedViewCell* cell = (iPadProgramRelatedViewCell*)[views firstObject];
                                            
        cell.frame = CGRectMake(xPosition, 0, 250, _scrollView.frame.size.height - 10);
        
        xPosition += 250 + 6;
        
        cell.titleLabel.text = programName;
        
        if([self.dataSource respondsToSelector:@selector(relatedView:cellSubtitleForCellAtPosition:)])
        {
            NSString* subtitle = [self.dataSource relatedView:self cellSubtitleForCellAtPosition:i];
            cell.subtitleLabel.text = subtitle;
        }
        if([self.dataSource respondsToSelector:@selector(relatedView:cellBackgroundImageURLStringForCellAtPosition:)])
        {
            NSString* urlString = [self.dataSource relatedView:self cellBackgroundImageURLStringForCellAtPosition:i];
            cell.imageURLString = urlString;
            
        }
        
        
        cell.layer.cornerRadius = 10;
        
        
        [_scrollView addSubview:cell];
        
    }
    
    _scrollView.contentSize = CGSizeMake(xPosition, _scrollView.frame.size.height);
    
}


- (void)setDataSource:(id<JPProgramRelatedViewDataSource>)dataSource
{
    
    _dataSource = dataSource;
    
    [self reloadData];
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect hexRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.height/1.154700538, rect.size.height);
    CGFloat hexHorizOffset = (rect.size.width-hexRect.size.width) / 2;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef strokeColor = [UIColor whiteColor].CGColor;
    CGContextSetStrokeColorWithColor(context, strokeColor);
    
    CGContextSetLineWidth(context, 4);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGColorRef fillColor = [[JPStyle backgroundRainbowColorWithIndex:(arc4random()%6)] colorWithAlphaComponent:0.7].CGColor;
    CGContextSetFillColorWithColor(context, fillColor);
    
    CGContextMoveToPoint(context, hexRect.size.width/2.0, 2);
    
    CGPoint pointsToAdd[10] = {
        CGPointMake(kHexLineWidth + hexHorizOffset, hexRect.size.height/4),
        
        //Left Arm
        CGPointMake(-kHexLineWidth, hexRect.size.height/4),
        CGPointMake(-kHexLineWidth, hexRect.size.height/4*3),
        
        CGPointMake(kHexLineWidth + hexHorizOffset, hexRect.size.height/4*3),
        CGPointMake(hexRect.size.width/2 + hexHorizOffset, hexRect.size.height - 2),
        CGPointMake(hexRect.size.width - kHexLineWidth + hexHorizOffset, hexRect.size.height/4*3),
        
        CGPointMake(rect.size.width + kHexLineWidth, hexRect.size.height/4*3),
        CGPointMake(rect.size.width + kHexLineWidth, hexRect.size.height/4),
        
        CGPointMake(hexRect.size.width -kHexLineWidth + hexHorizOffset, hexRect.size.height/4),
        CGPointMake(hexRect.size.width/2 + hexHorizOffset, kHexLineWidth)
    };
    
    CGContextAddLines(context, pointsToAdd, 10);
    
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    

}









@end
