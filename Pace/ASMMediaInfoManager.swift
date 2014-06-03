//
//  ASMMediaInfoManager.swift
//  Pace
//
//  Created by Andrew Molloy on 6/2/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

import UIKit
import MediaPlayer

class ASMMediaInfoManager: NSObject {
	func createTrackFCFromItem(mediaItem: MPMediaItem) -> ASMTrack
	{
		let digest = mediaItem.digest()
		let title = mediaItem.valueForProperty(MPMediaItemPropertyTitle) as String
		let duration = mediaItem.valueForProperty(MPMediaItemPropertyPlaybackDuration).doubleValue as NSTimeInterval
		let persistentID = mediaItem.valueForProperty(MPMediaItemPropertyPersistentID) as NSNumber

		return ASMTrack(primaryKey: digest, title: title, duration: duration, mediaItem: mediaItem)
	}

	func updateMediaDatabase(completion: ()->())
	{
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
			{
				let query = MPMediaQuery.songsQuery()

				/* TODO
				ASMEchoNestManager* enManager = [ASMEchoNestManager sharedInstance];
				id tempoRequestToken = [enManager startBatch];
				*/

				for mediaItemObjC : AnyObject in query.items
				{
					let mediaItem = mediaItemObjC as MPMediaItem
					let digest = mediaItem.digest()
					let duration = mediaItem.valueForProperty(MPMediaItemPropertyPlaybackDuration) as NSNumber

					let tracks = ASMTrack.instancesWhere("id = ? AND duration = ? LIMIT 1", arguments: [digest, duration]);
					var track : ASMTrack
					if tracks.count != 0
					{
						track = tracks[0] as ASMTrack
						let newPersistentID = mediaItem.valueForProperty(MPMediaItemPropertyPersistentID) as NSNumber
						if newPersistentID !== track.persistentID
						{
							track.persistentID = newPersistentID
							track.save()
						}
					}
					else
					{
						track = self.createTrackFCFromItem(mediaItem);
					}

					if track.tempo == -1
					{
						if ((NSDate.timeIntervalSinceReferenceDate() - track.lastTempoSearch.timeIntervalSinceReferenceDate) <= (60*60*24*7))
						{
							// Do nothing, we checked this one too recently.
						}
						else
						{
							/* TODO
							[enManager addTrack:track
							toBatch:tempoRequestToken];
							*/
						}
					}
				}

				/* TODO
				[enManager finishBatch];
				*/

				completion()
			});
	}
}
