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
#import "ASMTrack.h"
#import "ASMEchoNestTempoProvider.h"

@interface ASMMusicInfoImporter () <NSURLSessionDelegate>
@end

@implementation ASMMusicInfoImporter

-(ASMTrack*)createTrackFCFromItem:(MPMediaItem*)mediaItem
{
	ASMTrack* newTrack = [ASMTrack instanceWithPrimaryKey:[mediaItem digest]];
	newTrack.title = [mediaItem valueForProperty:MPMediaItemPropertyTitle];
	newTrack.duration = [[mediaItem valueForProperty:MPMediaItemPropertyPlaybackDuration] doubleValue];
	[newTrack save];

	return newTrack;
}

-(void)blehUsingFCModel
{
	MPMediaQuery* query = [MPMediaQuery songsQuery];
	ASMTempoProvider* tempoProvider = [[ASMEchoNestTempoProvider alloc] init];

	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	[query.items asm_enumerateObjectsAsynchronouslyWithOptions:0
													   onQueue:queue
												  stepsPerLoop:10
													usingBlock:^(MPMediaItem* mediaItem, NSUInteger idx, BOOL *stop)
	 {
		 NSNumber* digest = [mediaItem digest];
		 NSNumber* duration = [mediaItem valueForProperty:MPMediaItemPropertyPlaybackDuration];

		 ASMTrack* track = [ASMTrack firstInstanceWhere:@"id = ? AND duration = ? LIMIT 1", digest, duration];

		 if (!track)
		 {
			 track = [self createTrackFCFromItem:mediaItem];
		 }

		 track.mediaItem = mediaItem;

		 if (!track.tempo)
		 {
			 if (([NSDate timeIntervalSinceReferenceDate] - [track.lastTempoSearch timeIntervalSinceReferenceDate]) <= (60*60*24*7))
			 {
				 NSLog(@"Skipping %@, tried to recently", track.title);
			 }
			 else
			 {
				 [tempoProvider getTempoForArtist:track.artist
											title:track.title
									   completion:^(NSNumber *tempo, NSError *error) {
										   NSLog(@"Got tempo %@ for track %@", tempo, track.title);
										   if (tempo)
										   {
											   track.tempo = tempo;
										   }
										   else
										   {
											   track.lastTempoSearch = [NSDate date];
										   }
										   [track save];
									   }];
			 }
		 }
	 }
													completion:^(NSUInteger stoppedIndex, NSError *error)
	 {
		 NSLog(@"done");
	 }];
}

@end
