//
//  MasterViewController.swift
//  SwiftBeh
//
//  Created by Andrew Molloy on 6/2/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
	var tracks : NSArray = []

	override func awakeFromNib() {
		super.awakeFromNib()
		if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
		    self.clearsSelectionOnViewWillAppear = false
		    self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
		}
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)

		NSNotificationCenter.defaultCenter().addObserver(self, selector: "modelDidUpdate:", name: FCModelInsertNotification, object:nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "modelDidUpdate:", name: FCModelUpdateNotification, object:nil)
	}

	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)

		NSNotificationCenter.defaultCenter().removeObserver(self)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		Track.inDatabaseSync() { (db) in
			let rs = db.executeQuery("SELECT * FROM Track ORDER BY title", withArgumentsInArray:[])
			self.tracks = Track.instancesFromResultSet(rs)
		}
	}

	var updateCount = 0
	var reloadOnInsertTimer : NSTimer?

	func modelDidUpdate(notification : NSNotification) {
		updateCount++

		reloadOnInsertTimer?.invalidate()
		reloadOnInsertTimer = nil

		if updateCount % 50 == 0
		{
			reloadAllData();
		}
		else
		{
			reloadOnInsertTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "reloadAllData", userInfo: nil, repeats: false)
		}
	}

	func reloadAllData() {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
			var newTracks : NSArray?
			Track.inDatabaseSync() { (db) in
				let rs = db.executeQuery("SELECT * FROM Track ORDER BY title", withArgumentsInArray:[])
				newTracks = Track.instancesFromResultSet(rs)
			}

			dispatch_async(dispatch_get_main_queue()) {
				self.tracks = newTracks!;
				self.tableView.reloadData()
			}
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// #pragma mark - Segues

	// #pragma mark - Table View

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tracks.count
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
		self.configureCell(cell, atIndexPath: indexPath)
		return cell
	}

	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return false
	}

	func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
		let track = tracks[indexPath.row] as! Track

		cell.textLabel?.text = track.title
		cell.detailTextLabel?.text = track.tempo.description
	}
}

