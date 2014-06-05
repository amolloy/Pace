//
//  MPMediaItem+ASMHash.swift
//  Pace
//
//  Created by Andrew Molloy on 6/5/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

import Foundation

extension MPMediaItem
{
	func digestString() -> String {
		let artist = self.valueForProperty(MPMediaItemPropertyArtist) as NSString
		let album = self.valueForProperty(MPMediaItemPropertyAlbumTitle) as NSString
		let title = self.valueForProperty(MPMediaItemPropertyTitle) as NSString
		let duration = self.valueForProperty(MPMediaItemPropertyPlaybackDuration) as NSNumber

		return "\(artist) - \(album): \(title) (\(duration))"
	}

	func digest() -> NSNumber {
		let digestString : NSString = self.digestString()
		return NSNumber(unsignedLongLong: digestString.cityHash64())
	}
}
