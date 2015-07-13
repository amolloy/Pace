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

	init(primaryKey: NSNumber, title : String, duration : NSTimeInterval, mediaItem : MPMediaItem)
	{
		self.id = primaryKey
		self.title = title
		self.duration = duration
		self.mediaItem = mediaItem
		self.tempo = -1
		self.lastTempoSearch = NSDate(timeIntervalSinceReferenceDate: 0)
		self.persistentID = mediaItem.valueForProperty(MPMediaItemPropertyPersistentID) as! NSNumber
	}

	var artist: String {
		return mediaItem.valueForProperty(MPMediaItemPropertyArtist) as! String
	}

	var album: String {
		return mediaItem.valueForProperty(MPMediaItemPropertyAlbumTitle) as! String
	}
}
