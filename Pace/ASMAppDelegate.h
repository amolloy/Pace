//
//  ASMAppDelegate.h
//  Pace
//
//  Created by Andrew Molloy on 5/21/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;

@end
