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
#import "MPMediaItem+ASMHash.h"

@implementation ASMMusicInfoImporter

-(void)bleh
{
	MPMediaQuery* query = [MPMediaQuery songsQuery];

	NSMutableDictionary* hashTest = [NSMutableDictionary dictionary];

	[query.items enumerateObjectsUsingBlock:^(MPMediaItem* mediaItem, NSUInteger idx, BOOL *stop) {
		NSNumber* digest = [mediaItem digest];

		if (hashTest[digest])
		{
			NSLog(@"Collision:");
			NSLog(@"%@", hashTest[digest]);
			NSLog(@"%@", [mediaItem digestString]);
			NSLog(@"==========");
		}

		hashTest[digest] = [mediaItem digestString];
	}];

	NSLog(@"Done");
}

@end
