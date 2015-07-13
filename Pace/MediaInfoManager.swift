//
//  ASMMediaInfoManager.swift
//  Pace
//
//  Created by Andrew Molloy on 6/2/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

import UIKit
import MediaPlayer

class MediaInfoManager: NSObject {
	func createTrackFCFromItem(mediaItem: MPMediaItem) -> Track?
	{
		let digest = mediaItem.digest()
		guard let title = mediaItem.valueForProperty(MPMediaItemPropertyTitle)?.stringValue else
		{
			return nil;
		}
		guard let duration = mediaItem.valueForProperty(MPMediaItemPropertyPlaybackDuration)?.doubleValue else
		{
			return nil;
		}

		return Track(primaryKey: digest, title: title, duration: duration, mediaItem: mediaItem)
	}

	func updateMediaDatabase(completion: () -> Void)
	{
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
			{
				let query = MPMediaQuery.songsQuery()
				guard let queryItems = query.items else { return }

				/* TODO
				ASMEchoNestManager* enManager = [ASMEchoNestManager sharedInstance];
				id tempoRequestToken = [enManager startBatch];
				*/

				for mediaItemObjC in queryItems
				{
					let mediaItem = mediaItemObjC as MPMediaItem
					let digest = mediaItem.digest()
					guard let duration = mediaItem.valueForProperty(MPMediaItemPropertyPlaybackDuration) as? NSNumber else
					{
						continue
					}

					guard let tracks = Track.instancesWhere("id = ? AND duration = ? LIMIT 1", arguments: [digest, duration]) as? Array<Track> else
					{
						continue
					}
					var track : Track
					if tracks.count != 0
					{
						track = tracks[0]
						if let newPersistentID = mediaItem.valueForProperty(MPMediaItemPropertyPersistentID) as? NSNumber
						{
							if newPersistentID !== track.persistentID
							{
								track.persistentID = newPersistentID
								track.save()
							}
						}
					}
					else
					{
						guard let newTrack = self.createTrackFCFromItem(mediaItem) else
						{
							continue
						}
						track = newTrack;
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
