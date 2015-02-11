//
//  Contact.h
//  Uniq
//
//  Created by Si Te Feng on 2/10/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Faculty, Program, School;

@interface Contact : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * extraInfo;
@property (nonatomic, retain) NSString * facebook;
@property (nonatomic, retain) NSString * linkedin;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * phoneExt;
@property (nonatomic, retain) NSString * twitter;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) Faculty *faculty;
@property (nonatomic, retain) Program *program;
@property (nonatomic, retain) School *school;

@end
