//
//  ASMMusicInfoImporter.m
//  Pace
//
//  Created by Andrew Molloy on 5/21/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import "ASMMusicInfoImporter.h"
#import <MediaPlayer/MediaPlayer.h>
#import "NSArray+ASMAsyncEnumeration.h"
#import "NSString+ASMCityHash.h"

@implementation ASMMusicInfoImporter

-(void)bleh
{
	MPMediaQuery* query = [MPMediaQuery songsQuery];

	NSMutableDictionary* hashTest = [NSMutableDictionary dictionary];

	[query.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		NSString* artist = [obj valueForProperty:MPMediaItemPropertyArtist];
		NSString* album = [obj valueForProperty:MPMediaItemPropertyAlbumTitle];
		NSString* title = [obj valueForProperty:MPMediaItemPropertyTitle];
		NSNumber* duration = [obj valueForProperty:MPMediaItemPropertyPlaybackDuration];

		NSString* strToHash = [NSString stringWithFormat:@"%@ - %@: %@ (%@)", artist, album, title, duration];
		NSNumber* hash = @([strToHash cityHash64]);

		if (hashTest[hash])
		{
			NSLog(@"Collision:");
			NSLog(@"%@", hashTest[hash]);
			NSLog(@"%@", strToHash);
			NSLog(@"==========");
		}

		hashTest[hash] = strToHash;
	}];

	NSLog(@"Done");
}

@end
