//
//  iPadDashletScrollView.m
//  JumpPad
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "iPadDashletScrollView.h"
#import "iPadDashletView.h"

@interface iPadDashletScrollView()
{
    
}
    
    
@end


@implementation iPadDashletScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
        [self addGestureRecognizer:tapRecognizer];
        
      
        
    }
    return self;
}


- (void)loadDashlets
{
    if([self.dataSource respondsToSelector:@selector(dashletScrollView:numberOfDashletsInSection:)])
    {
        _numberOfDashlets = 0;
        _dashletViews = [[NSMutableArray alloc] init];
        
        if([self.dataSource respondsToSelector:@selector(numberOfSectionsInDashletScrollView:)])
        {
            for(int i = 0; i < [self.dataSource numberOfSectionsInDashletScrollView:self]; i++)
            {
                [_dashletViews insertObject:[[NSMutableArray alloc] init] atIndex:i];
                
                for(int j = 0; j < [self.dataSource dashletScrollView:self numberOfDashletsInSection:i]; j++)
                {
                    ++_numberOfDashlets;
                    
                    if([self.dataSource respondsToSelector:@selector(dashletScrollView:dashletAtIndexPath:)])
                    {
                        NSIndexPath* currentIP = [NSIndexPath indexPathForItem:j inSection:i];
                        JPDashlet* dashlet = [self.dataSource dashletScrollView:self dashletAtIndexPath:currentIP];
                        
                        iPadDashletView* view = [[iPadDashletView alloc] initWithFrame:CGRectZero];
                        view.dashlet = dashlet;
                        
                        [[_dashletViews objectAtIndex:i] insertObject:view atIndex:j];
                    }
                }
            }
        }
        else
        {
            [_dashletViews insertObject:[[NSMutableArray alloc] init] atIndex:0];
            
            for(int j = 0; j < [self.dataSource dashletScrollView:self numberOfDashletsInSection:0]; j++)
            {
                ++_numberOfDashlets;
                
                if([self.dataSource respondsToSelector:@selector(dashletScrollView:dashletAtIndexPath:)])
                {
                    NSIndexPath* currentIP = [NSIndexPath indexPathForItem:j inSection:0];
                    JPDashlet* dashlet = [self.dataSource dashletScrollView:self dashletAtIndexPath:currentIP];
                    
                    iPadDashletView* view = [[iPadDashletView alloc] initWithFrame:CGRectZero];
                    view.dashlet = dashlet;
                    
                    [[_dashletViews objectAtIndex:0] insertObject:view atIndex:j];
                }
            }
        }
    }
}



- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    

    
    
    
    
    // Width of the Screen in pt
    float width= frame.size.width;
    
    if( width >= 1024)
    {
        
    }
    else if(width < 1024 && width >= 768)
    {
        
        for(NSMutableArray* array in _dashletViews)
        {
            
            for(int i = 0; i< [array count]; i++)
            {
                _currentX = (i%2 == 0) ? kiPadSizeDashletBorderPadding
                                       : 2*kiPadSizeDashletBorderPadding + kiPadSizeDashletPortrait.width;
                
                _currentY = (kiPadSizeDashletBorderPadding + i/2 * (kiPadSizeDashletBorderPadding + kiPadSizeDashletPortrait.height));
                
                iPadDashletView* dashletView = [array objectAtIndex:i];
                
                [dashletView setFrame:CGRectMakeWithOriginXYAndSize(0, 0, kiPadSizeDashletPortrait)];
                
                dashletView.center = jpp(dashletView.frame.size.width/2 + _currentX, dashletView.frame.size.height/2 + _currentY);  //CGPointMake
                
                [self addSubview:dashletView];
            }
            
            
            
        }
        
        
        
        
    }
    else
    {
        
    }
    
    
    
}



- (void)resizeDashlets
{
    
    
    
    
    
    
    
    
}



- (void)tap:(UITapGestureRecognizer*)recognizer
{
    
    
    
    
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
