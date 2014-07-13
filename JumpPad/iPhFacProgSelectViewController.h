//
//  iPhFacProgSelectViewController.h
//  Uniq
//
//  Created by Si Te Feng on 7/12/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPhFacProgSelectViewController : UIViewController



@property(nonatomic, assign) NSUInteger dashletUid;




- (instancetype)initWithDashletUid: (NSUInteger)dashletUid forSelectionType: (JPDashletType)type;

@end
