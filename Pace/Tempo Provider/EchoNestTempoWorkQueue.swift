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
		let requestURL = NSURL.URLWithString(SharedEchoNestManager.echoNestBaseURL).URLByAppendingPathComponent("catalog/create")
		let request = NSMutableURLRequest(URL:requestURL)

		request.HTTPMethod = "POST"

		var body = "api_key=\(SharedEchoNestManager.echoNestAPIKey)"
		body += "&format=json"
		body += "&type=song"
		body += "&name=\(NSUUID.UUID())"

		request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)

		NSURLSession.sharedSession().dataTaskWithRequest(request) {	(data, response, error) in
			if error?
			{
				println("Error in EchoNest request to create catalog: \(error)")
				self.retryCreateEchoNestCatalog()
			}
			else
			{
				// TODO This is the documented way to get an NSError out of this and other APIs, but the compiler currently rejects it
				var jsonError : NSError?
				let info : AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:&jsonError)
			}
		}
	}

	/*


		 else
		 {
			 NSError* jsonError = nil;
			 NSDictionary* info = [NSJSONSerialization JSONObjectWithData:data
																  options:0
																	error:&jsonError];
			 if (jsonError)
			 {
				 NSLog(@"Invalid JSON response, trying again in 10s %@", jsonError);
				 [self retryCreateEchoNestCatalog];
			 }
			 else
			 {
				 NSDictionary* enResponse = info[@"response"];
				 self.echoNestCatalogID = enResponse[@"id"];
				 if (!self.echoNestCatalogID)
				 {
					 NSLog(@"Did not receive a catalog id.\nRequest:\n%@\n\nResponse:\n%@\n\n", request, info);
				 }
			 }
		 }

	 }];
}
*/
	
}
