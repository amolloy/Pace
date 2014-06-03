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
#import "ASMEchoNestManager.h"
#import "FCModel.h"
#import "Pace-Swift.h"

@interface ASMMusicInfoImporter () <NSURLSessionDelegate>
@end

@implementation ASMMusicInfoImporter

/*
-(ASMTrack*)createTrackFCFromItem:(MPMediaItem*)mediaItem
{
	NSNumber* digest = [mediaItem digest];
	NSString* title = [mediaItem valueForProperty:MPMediaItemPropertyTitle];
	NSTimeInterval duration = [[mediaItem valueForProperty:MPMediaItemPropertyPlaybackDuration] doubleValue];
	NSNumber* persistentID = [mediaItem valueForProperty:MPMediaItemPropertyPersistentID];

	ASMTrack* newTrack = [ASMTrack instanceWithPrimaryKey:digest
													title:title
												 duration:duration
											 persistentID:persistentID];
	[newTrack save];

	return newTrack;
}

-(void)blehUsingFCModelCompletion:(blehCompletion)completion
{
	MPMediaQuery* query = [MPMediaQuery songsQuery];

	ASMEchoNestManager* enManager = [ASMEchoNestManager sharedInstance];
	id tempoRequestToken = [enManager startBatch];

	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	[query.items asm_enumerateObjectsAsynchronouslyWithOptions:0
													   onQueue:queue
												  stepsPerLoop:10
													usingBlock:^(MPMediaItem* mediaItem, NSUInteger idx, BOOL *stop)
	 {
		 NSNumber* digest = [mediaItem digest];
		 NSNumber* duration = [mediaItem valueForProperty:MPMediaItemPropertyPlaybackDuration];

		 ASMTrack* track = [ASMTrack firstInstanceWhere:@"id = ? AND duration = ? LIMIT 1", digest, duration];

		 if (track)
		 {
			 track.persistentID = [mediaItem valueForProperty:MPMediaItemPropertyPersistentID];
		 }
		 else
		 {
			 track = [self createTrackFCFromItem:mediaItem];
		 }

		 if (!track.tempo)
		 {
			 if (([NSDate timeIntervalSinceReferenceDate] - [track.lastTempoSearch timeIntervalSinceReferenceDate]) <= (60*60*24*7))
			 {
				 // Do nothing, we checked this one too recently.
			 }
			 else
			 {
				 [enManager addTrack:track
							 toBatch:tempoRequestToken];
			 }
		 }
	 }
													completion:^(NSUInteger stoppedIndex, NSError *error)
	{
		[enManager finishBatch];
		if (completion)
		{
			completion();
		}
	}];
}
 */

@end
