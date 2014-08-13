//
//  JumpPadAppDelegate.h
//  JumpPad
//
//  Created by Si Te Feng on 11/30/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNConnectivityManager;
@interface UniqAppDelegate : UIResponder <UIApplicationDelegate>
{
    HNConnectivityManager* connectivityManager;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic, readonly) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic, readonly) NSManagedObjectModel* managedObjectModel;
@property (strong, nonatomic, readonly) NSPersistentStoreCoordinator* persistentStoreCoordinator;


@property (assign, nonatomic) BOOL _isReachable;




- (NSURL *)applicationDocumentsDirectory;

- (void)saveContext;




@end
