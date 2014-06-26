//
//  iPadProgramDetailInfoView.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-11.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "iPadProgramDetailInfoView.h"
#import "JPFont.h"
#import "JPStyle.h"

@implementation iPadProgramDetailInfoView

- (id)initWithFrame:(CGRect)frame  title:(NSString*)title  paragraph:(NSString*) paragraph
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        self.clipsToBounds = YES;
        
        if([title isEqualToString:@"About"])
        {
            
            UITextView* aboutView = [[UITextView alloc] initWithFrame:CGRectMake(250, 20, 500, 1000)];
            
            aboutView.font = [JPFont fontWithName:[JPFont defaultFont] size:15];
            aboutView.textColor = [UIColor blackColor];
            aboutView.userInteractionEnabled = NO;
            aboutView.editable = NO;
            
//            aboutView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
            
            aboutView.backgroundColor = [JPStyle colorWith8BitRed:255 green:255 blue:255 alpha:0.45];
            aboutView.layer.cornerRadius = 10;
            aboutView.clipsToBounds = YES;
            
            aboutView.text = paragraph;
            
            if(aboutView.text == nil || [aboutView.text isEqualToString:@""])
            {
                aboutView.text = @"Description not available.";
            }
            
            
            [aboutView sizeToFit];
            

            ///////////////////////////////
            
            CGSize aboutViewSize = aboutView.frame.size;
            
            
            float aboutLabelY = 20 + aboutViewSize.height/2.0 - 55/2.0 ;
            
            UILabel* aboutLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, aboutLabelY - 10, 136, 55)];
            aboutLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:55];

            aboutLabel.textColor = [UIColor blackColor];
            aboutLabel.text = @"About";
            
            [aboutLabel sizeToFit];
            
            
            if(aboutViewSize.height >= aboutLabel.frame.size.height)
            {
                self.viewHeight = 40 + aboutViewSize.height;
            }
            else
            {
                self.viewHeight = 40 + aboutLabel.frame.size.height;
            }
            

            [self addSubview:aboutLabel];
            [self addSubview:aboutView];
   
        }
        
        
        
        
        
        
        
    
        
    }
    return self;
}



- (void)sizeToFit
{
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.viewHeight)];
}











@end
