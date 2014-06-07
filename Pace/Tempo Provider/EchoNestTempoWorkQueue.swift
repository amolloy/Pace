//
//  EchoNestTempoWorkQueue.swift
//  Pace
//
//  Created by Andrew Molloy on 6/5/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

import Foundation

class EchoNestTempoWorkQueue {
	var tracksToUpdate : Array<Track> = []
	var catalogCreationErrorCount = 0
	var catalogId : String? = nil

	func retryCreateEchoNestCatalog() {
		if catalogCreationErrorCount >= 5
		{
			println("Made \(catalogCreationErrorCount) attempts with no success, giving up.")
		}
		else
		{
			var retryTime : CUnsignedLongLong = 0
			switch catalogCreationErrorCount {
			case 0..2:
				retryTime = 5
			case 2..4:
				retryTime = 10
			default:
				retryTime = 30
			}

			println("Going to try again in \(retryTime) seconds")

			let delay = retryTime * NSEC_PER_SEC
			let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
			dispatch_after(dispatchTime, dispatch_get_main_queue()) {
				self.createEchoNestCatalog()
			};
		}
	}

	func createEchoNestCatalog() {
		println("Creating catalog")

		let requestURL = NSURL.URLWithString(SharedEchoNestManager.echoNestBaseURL).URLByAppendingPathComponent("catalog/create")
		let request = NSMutableURLRequest(URL:requestURL)

		request.HTTPMethod = "POST"

		var body = "api_key=\(SharedEchoNestManager.echoNestAPIKey)"
		body += "&format=json"
		body += "&type=song"
		body += "&name=\(NSUUID.UUID())"

		request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)

		println("Request: \(body)")

		NSURLSession.sharedSession().dataTaskWithRequest(request, {	(data, response, error) in
			if error?
			{
				println("Error in EchoNest request to create catalog: \(error)")
				self.retryCreateEchoNestCatalog()
			}
			else
			{
				var jsonError : NSError?
				let info = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:&jsonError) as Dictionary<String, AnyObject!>

				if jsonError
				{
					println("Invalid JSON response, error: \(jsonError!.localizedDescription)")
					self.retryCreateEchoNestCatalog();
				}
				else
				{
					let reponseObj = info["response"]
					if let response = reponseObj as? Dictionary<String, AnyObject!>
					{
						let idObj = response["id"]
						if let id = idObj as? String
						{
							self.catalogId = id
						}
					}

					if !self.catalogId
					{
						println("Did not get a catalog ID")
						self.retryCreateEchoNestCatalog()
					}
					else
					{
						println("Got catalog id \(self.catalogId!)")
					}
				}
			}
		}).resume()
	}
}
