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
	
	
}
