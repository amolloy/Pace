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
#import "ASMTrackFC.h"

@implementation ASMMusicInfoImporter

-(ASMTrackFC*)createTrackFCFromItem:(MPMediaItem*)mediaItem
{
	ASMTrackFC* newTrack = [ASMTrackFC instanceWithPrimaryKey:[mediaItem digest]];
	newTrack.title = [mediaItem valueForProperty:MPMediaItemPropertyTitle];
	newTrack.duration = [[mediaItem valueForProperty:MPMediaItemPropertyPlaybackDuration] doubleValue];
	[newTrack save];

	return newTrack;
}

-(void)blehUsingFCModel
{
	MPMediaQuery* query = [MPMediaQuery songsQuery];

	NSMutableArray* itemsToLookup = [NSMutableArray array];

	NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];

	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	[query.items asm_enumerateObjectsAsynchronouslyWithOptions:0
													   onQueue:queue
												  stepsPerLoop:10
													usingBlock:^(MPMediaItem* mediaItem, NSUInteger idx, BOOL *stop)
	 {
		 NSNumber* digest = [mediaItem digest];
		 NSNumber* duration = [mediaItem valueForProperty:MPMediaItemPropertyPlaybackDuration];

		 ASMTrackFC* track = [ASMTrackFC firstInstanceWhere:@"id = ? AND duration = ? LIMIT 1", digest, duration];

		 if (!track)
		 {
			 track = [self createTrackFCFromItem:mediaItem];
		 }

		 track.mediaItemPersistentID = [mediaItem valueForProperty:MPMediaItemPropertyPersistentID];

		 if (!track.tempo)
		 {
			 [itemsToLookup addObject:track];
			 NSLog(@"Need to look up %@", track.title);
		 }
	 }
															   completion:^(NSUInteger stoppedIndex, NSError *error)
	 {

		 NSTimeInterval end = [NSDate timeIntervalSinceReferenceDate];

		 NSTimeInterval duration = end - start;
		 NSInteger minutes = duration / 60;
		 NSInteger seconds = (NSInteger)duration % 60;

		 NSLog(@"Done in %@:%@", @(minutes), @(seconds));
	 }];
}

@end
