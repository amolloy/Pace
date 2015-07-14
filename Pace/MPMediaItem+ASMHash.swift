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
		return "\(self.artist) - \(self.albumTitle): \(self.title) (\(self.playbackDuration))"
	}

	func digest() -> NSNumber {
		let digestString : NSString = self.digestString()
		return NSNumber(unsignedLongLong: digestString.cityHash64())
	}
}
