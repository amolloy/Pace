//
//  AppDelegate.swift
//  SwiftBeh
//
//  Created by Andrew Molloy on 6/2/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool
	{
		self.setupFCModel()

		let mediaInfoManager = MediaInfoManager()
		mediaInfoManager.updateMediaDatabase() {
			print("Done")
		}

		// TESTING
		//		let queue = EchoNestTempoWorkQueue()
		//		queue.createEchoNestCatalog()
		// !TESTING


		return true
	}

	func applicationWillResignActive(application: UIApplication)
	{
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(application: UIApplication)
	{
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(application: UIApplication)
	{
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(application: UIApplication)
	{
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(application: UIApplication)
	{
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
		// Saves changes in the application's managed object context before the application terminates.
	}

	// #pragma mark - FC Model

	func setupFCModel()
	{
		let dbURL = self.applicationDocumentsDirectory.URLByAppendingPathComponent("paceFC.sqlite3")
		let dbPath = dbURL.path;

		/*
		let seedURL = NSBundle.mainBundle().URLForResource("paceFC", withExtension: "sqlite3")
		var anError : NSError?
		NSFileManager.defaultManager().copyItemAtURL(seedURL, toURL: dbURL, error: &anError)
		*/

		FCModel.openDatabaseAtPath(dbPath,
			withDatabaseInitializer: { (db) -> Void in },
			schemaBuilder: { (db, schemaVersionPtr) -> Void in
				if db.beginTransaction()
				{
					// My custom failure handling. Yours may vary.
					func failedAt(statement: Int) {
						//#if DEBUG
						let lastErrorCode = db.lastErrorCode
						let oLastErrorMessage = db.lastErrorMessage()
						var lastErrorMessage = "no message"
						if let msg = oLastErrorMessage
						{
							lastErrorMessage = msg
						}
						//#endif
						db.rollback()

						assert(false, "Migration statement \(statement) failed, code \(lastErrorCode): \(lastErrorMessage)")
						assert(false, "Migration statement failed")
					}

					let schemaVersion = schemaVersionPtr[0]

					if schemaVersion < 1
					{
						let sql = "CREATE TABLE ASMTrack (" +
							"    id           INTEGER PRIMARY KEY," +
							"    duration     REAL NOT NULL," +
							"    tempo        REAL," +
							"    title        TEXT NOT NULL," +
							"    lastTempoSearch REAL" +
						");"

						var success = db.executeUpdate(sql, withArgumentsInArray: [])
						if !success
						{
							failedAt(1)
						}

						success = db.executeUpdate("CREATE INDEX IF NOT EXISTS duration ON ASMTrack (duration);", withArgumentsInArray:[])
						if !success
						{
							failedAt(2)
						}
					}

					if schemaVersion < 2
					{
						let success = db.executeUpdate("ALTER TABLE ASMTrack ADD COLUMN persistentID INTEGER", withArgumentsInArray:[])
						if !success
						{
							failedAt(3)
						}
						schemaVersionPtr[0] = 2
					}

					if schemaVersion < 3
					{
						let success = db.executeUpdate("ALTER TABLE ASMTrack RENAME TO Track", withArgumentsInArray:[])
						if !success
						{
							failedAt(4)
						}
						schemaVersionPtr[0] = 3
					}

					db.commit()
				}
		})
	}

	// #pragma mark - Application's Documents directory

	// Returns the URL to the application's Documents directory.
	var applicationDocumentsDirectory: NSURL {
		let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
		return urls[urls.endIndex-1] as NSURL
	}
}

