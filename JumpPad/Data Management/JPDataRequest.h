//
//  JPDataRequest.h
//  Uniq
//
//  Created by Si Te Feng on 8/30/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPProgramRatingHelper.h"
#import "JPCloudFavoritesHelper.h"

// Temporarily deprecated

@class JPCoreDataHelper;
@protocol JPDataRequestDelegate, JPProgramRatingHelper, JPConnectivityManager;
@interface JPDataRequest : NSObject <JPProgramRatingHelperDelegate, JPCloudFavoritesHelperDelegate>
{
    NSMutableDictionary*  _itemDetailsDictWithoutRatings;
    JPDashletType  _itemDetailType;
    NSInteger      _itemDetailExpectedReturnNumber;
    
    JPConnectivityManager*  _connectivity;
       
    JPProgramRatingHelper* _ratingHelper;
    JPCloudFavoritesHelper* _cloudFavHelper;
    
}

@property (nonatomic, weak) id<JPDataRequestDelegate> delegate;

@property (nonatomic, strong) NSString* basePath;



- (instancetype)init;
+ (instancetype)request;


- (void)requestAllSchoolsAllFields: (BOOL)allFields;
- (void)requestAllFacultiesFromSchool: (NSString*)schoolId allFields: (BOOL)allFields;
- (void)requestAllProgramsFromFaculty: (NSString*)facultyId allFields: (BOOL)allFields;

- (void)requestItemBriefDetailsWithId: (NSString*)itemId ofType: (JPDashletType)type;
- (void)requestItemDetailsWithId: (NSString*)itemId ofType: (JPDashletType)type;

//Featured
- (void)requestAllFeaturedItems;


@end

@protocol JPDataRequestDelegate <NSObject>

@optional

- (void)dataRequest: (JPDataRequest*)request didLoadAllItemsOfType: (JPDashletType)type allFields:(BOOL)fullFields withDataArray:(NSArray*)array isSuccessful: (BOOL)success;

- (void)dataRequest: (JPDataRequest*)request didLoadItemDetailsWithId: (NSString*)itemId ofType: (JPDashletType)type dataDict: (NSDictionary*)dict isSuccessful: (BOOL)success;


- (void)dataRequest: (JPDataRequest*)request didLoadItemBriefDetailsWithId: (NSString*)itemId ofType: (JPDashletType)type dataDict: (NSDictionary*)dict isSuccessful: (BOOL)success;

//Featured
- (void)dataRequest: (JPDataRequest*)request didLoadAllFeaturedItems: (NSArray*)featuredDicts isSuccessful: (BOOL)success;


@end

