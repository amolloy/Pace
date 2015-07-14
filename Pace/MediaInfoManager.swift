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
	func updateMediaDatabase(completion: () -> Void)
	{
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
			{
				/* TODO
				ASMEchoNestManager* enManager = [ASMEchoNestManager sharedInstance];
				id tempoRequestToken = [enManager startBatch];
				*/

				for mediaItem in (MPMediaQuery.songsQuery().items ?? [])
				{
					let digest = mediaItem.digest()
					let duration = mediaItem.playbackDuration ?? 0
					
					guard let tracks = Track.instancesWhere("id = ? AND duration = ? LIMIT 1", arguments: [digest, duration]) as? Array<Track> else
					{
						continue
					}
					var track : Track
					if tracks.count != 0
					{
						track = tracks[0]
						let newPersistentID = NSNumber(unsignedLongLong: mediaItem.persistentID)
						if newPersistentID !== track.persistentID
						{
							track.persistentID = newPersistentID
							track.save()
						}
					}
					else
					{
						let newTrack = Track(mediaItem: mediaItem)
						newTrack.save()
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
