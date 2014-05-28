//
//  iPadSearchResultsView.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-27.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadSearchResultsView.h"
#import "JPKnowledgeEngineInterpreter.h"

@implementation iPadSearchResultsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.interpreter = [[JPKnowledgeEngineInterpreter alloc] initWithQueryString:nil];
        
    }
    return self;
}






- (void)setQueryString:(NSString *)queryString
{
    
    self.interpreter.queryString = queryString;
    
    [self.interpreter interpret];
    
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
