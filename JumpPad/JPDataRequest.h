//
//  JPDataRequest.h
//  Uniq
//
//  Created by Si Te Feng on 8/30/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JPDataRequestDelegate;
@interface JPDataRequest : UIViewController


@property (nonatomic, weak) id<JPDataRequestDelegate> delegate;

@property (nonatomic, strong) NSString* basePath;



+ (instancetype)sharedRequest;


- (void)requestAllSchoolsAllFields: (BOOL)allFields;
- (void)requestAllFacultiesFromSchool: (NSString*)schoolId allFields: (BOOL)allFields;
- (void)requestAllProgramsFromFaculty: (NSString*)facultyId allFields: (BOOL)allFields;

- (void)requestItemBriefDetailsWithId: (NSString*)itemId ofType: (JPDashletType)type;
- (void)requestItemDetailsWithId: (NSString*)itemId ofType: (JPDashletType)type;


@end

@protocol JPDataRequestDelegate <NSObject>

@optional

- (void)dataRequest: (JPDataRequest*)request didLoadAllItemsOfType: (JPDashletType)type allFields:(BOOL)fullFields withDataArray:(NSArray*)array isSuccessful: (BOOL)success;

- (void)dataRequest: (JPDataRequest*)request didLoadItemDetailsWithId: (NSString*)itemId ofType: (JPDashletType)type dataDict: (NSDictionary*)dict isSuccessful: (BOOL)success;


- (void)dataRequest: (JPDataRequest*)request didLoadItemBriefDetailsWithId: (NSString*)itemId ofType: (JPDashletType)type dataDict: (NSDictionary*)dict isSuccessful: (BOOL)success;

@end