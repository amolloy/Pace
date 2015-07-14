//
//  Track.swift
//  Pace
//
//  Created by Andrew Molloy on 6/3/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

import UIKit
import MediaPlayer

@objc(Track) class Track: FCModel {
	var id: NSNumber
	var title: String
	var duration: NSNumber
	var mediaItem: MPMediaItem
	var persistentID: NSNumber

	var tempo: NSNumber
	var lastTempoSearch: NSDate

	init(mediaItem : MPMediaItem)
	{
		self.id = mediaItem.digest()
		self.title = mediaItem.title ?? ""
		self.duration = mediaItem.playbackDuration
		self.mediaItem = mediaItem
		self.tempo = mediaItem.beatsPerMinute ?? -1
		self.lastTempoSearch = NSDate(timeIntervalSinceReferenceDate: 0)
		self.persistentID = NSNumber(unsignedLongLong: mediaItem.persistentID)
	}

	var artist: String {
		return mediaItem.artist ?? ""
	}

	var albumTitle: String {
		return mediaItem.albumTitle ?? ""
	}
}
