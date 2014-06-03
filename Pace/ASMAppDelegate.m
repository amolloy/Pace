//
//  ASMAppDelegate.m
//  Pace
//
//  Created by Andrew Molloy on 5/21/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import "ASMAppDelegate.h"

#import "ASMMasterViewController.h"
#import "ASMMusicInfoImporter.h"
#import "FCModel.h"

@implementation ASMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	ASMMusicInfoImporter* meh = [[ASMMusicInfoImporter alloc] init];

	[self setupFCModel];
	[meh blehUsingFCModel];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Saves changes in the application's managed object context before the application terminates.
}

- (void)setupFCModel
{
	NSURL* dbURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"paceFC.sqlite3"];
	NSString *dbPath = [dbURL path];

#if 0
	NSURL* seedURL = [[NSBundle mainBundle] URLForResource:@"paceFC" withExtension:@"sqlite3"];
	[[NSFileManager defaultManager] copyItemAtURL:seedURL
											toURL:dbURL
											error:nil];
#endif

	[FCModel openDatabaseAtPath:dbPath withSchemaBuilder:^(FMDatabase *db, int *schemaVersion) {
		[db beginTransaction];

		// My custom failure handling. Yours may vary.
		void (^failedAt)(int statement) = ^(int statement){
#if DEBUG
			int lastErrorCode = db.lastErrorCode;
			NSString *lastErrorMessage = db.lastErrorMessage;
#endif
			[db rollback];
			NSAssert3(0, @"Migration statement %d failed, code %d: %@", statement, lastErrorCode, lastErrorMessage);
		};

		if (*schemaVersion < 1) {
			if (! [db executeUpdate:
				   @"CREATE TABLE ASMTrack ("
				   @"    id           INTEGER PRIMARY KEY,"
				   @"    duration     REAL NOT NULL,"
				   @"    tempo        REAL,"
				   @"    title        TEXT NOT NULL,"
				   @"    lastTempoSearch REAL"
				   @");"
				   ]) failedAt(1);

			if (! [db executeUpdate:@"CREATE INDEX IF NOT EXISTS duration ON ASMTrack (duration);"]) failedAt(2);

			*schemaVersion = 1;
		}

		// If you wanted to change the schema in a later app version, you'd add something like this here:
		/*
		 if (*schemaVersion < 2) {
		 if (! [db executeUpdate:@"ALTER TABLE Person ADD COLUMN title TEXT NOT NULL DEFAULT ''"]) failedAt(3);
		 *schemaVersion = 2;
		 }

		 // And so on...
		 if (*schemaVersion < 3) {
		 if (! [db executeUpdate:@"CREATE TABLE..."]) failedAt(4);
		 *schemaVersion = 3;
		 }

		 */

		[db commit];
	}];
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
