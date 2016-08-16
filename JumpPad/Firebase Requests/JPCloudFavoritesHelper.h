//
//  JPCloudFavoritesHelper.h
//  Uniq
//
//  Created by Si Te Feng on 8/23/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JPCloudFavoritesHelperDelegate;
@interface JPCloudFavoritesHelper : NSObject

@property (nonatomic, weak) id<JPCloudFavoritesHelperDelegate> delegate;

- (void)uploadItemFavoritedWithUid: (NSString*)uid;

- (void)getItemFavCountAsyncWithUid:(NSString *)programUid completionHandler: (void (^)(BOOL success, NSInteger favoriteCount))completion;

// Note: Synchronous network operation, only to be used in background thread
- (NSInteger)getItemFavCountSyncWithUid:(NSString *)programUid;

@end

@protocol JPCloudFavoritesHelperDelegate <NSObject>
@optional
- (void)cloudFavHelper: (JPCloudFavoritesHelper*)helper didFinishUploadItemFavoritedWithUid: (NSString*)uid itemExistsAlready: (BOOL)exists success: (BOOL)success;

@end



/*
 {
	"favorites":
	{
         "count" :
         {
             "132" : 1542,
             "112" : 2614
         },
         "userFavs" :
         {
             "hf249hf92t24h9" :
             [
                 "99999",
                 "99998",
                 "132"
             ],
             "hf349gqhp4t3hp" :
             [
                 "195",
                 "768",
                 "132"
             ],
             "v34ty94yt394nt3" :
             [
                 "526"
             ]
         }
	}
 }
 
 When User Favorites a program, faculty, or school, App retrieves all the user's current favs according to DeviceUUID from Firebase. If DeviceUUID DNE or just faved program was not found in the list, Add the program UID under the userFav list.

 After Adding, Increment the fav "count" of the program by 1.
 
 If program was found under user's fav list, do not increment.
 
 Optional: sync Firebase's data with user's local favs everytime favorites tab is loaded.
 
*/

