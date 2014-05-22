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
#import "ASMTrackFC.h"

@implementation ASMMusicInfoImporter

-(ASMTrack*)createTrackInManagedObjectContext:(NSManagedObjectContext*)moc fromItem:(MPMediaItem*)mediaItem
{
	static NSUInteger insertCount = 0;

	ASMTrack* newTrack = [ASMTrack insertInManagedObjectContext:moc];
	newTrack.title = [mediaItem valueForProperty:MPMediaItemPropertyTitle];
	newTrack.duration = [mediaItem valueForProperty:MPMediaItemPropertyPlaybackDuration];
	newTrack.trackHash = [mediaItem digest];

	++insertCount;
	if (insertCount % 10 == 0)
	{
		NSError* error = nil;
		[moc save:&error];
	}

	return newTrack;
}

-(void)blehManagedObjectContext:(NSManagedObjectContext*)moc
{
	MPMediaQuery* query = [MPMediaQuery songsQuery];

	NSMutableArray* itemsToLookup = [NSMutableArray array];
	NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:[ASMTrack entityName]];
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"trackHash" ascending:YES]];
	request.fetchLimit = 1;

	NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];

	[query.items enumerateObjectsUsingBlock:^(MPMediaItem* mediaItem, NSUInteger idx, BOOL *stop) {
		NSNumber* digest = [mediaItem digest];
		NSNumber* duration = [mediaItem valueForProperty:MPMediaItemPropertyPlaybackDuration];

		request.predicate = [NSPredicate predicateWithFormat:@"trackHash=%@ AND duration=%@", digest, duration];

		NSError* error = nil;
		NSArray* tracks = [moc executeFetchRequest:request error:&error];

		ASMTrack* track = tracks.firstObject;

		if (!track)
		{
			track = [self createTrackInManagedObjectContext:moc
												   fromItem:mediaItem];
		}

		track.mediaItemPersistentID = [mediaItem valueForProperty:MPMediaItemPropertyPersistentID];

		if (!track.tempo)
		{
			[itemsToLookup addObject:track];
			NSLog(@"Need to look up %@", track.title);
		}
	}];

	NSError* error = nil;
	[moc save:&error];

	NSTimeInterval end = [NSDate timeIntervalSinceReferenceDate];

	NSTimeInterval duration = end - start;
	NSInteger minutes = duration / 60;
	NSInteger seconds = (NSInteger)duration % 60;

	NSLog(@"Done in %@:%@", @(minutes), @(seconds));
}

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

	[query.items enumerateObjectsUsingBlock:^(MPMediaItem* mediaItem, NSUInteger idx, BOOL *stop) {
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
	}];

	NSTimeInterval end = [NSDate timeIntervalSinceReferenceDate];

	NSTimeInterval duration = end - start;
	NSInteger minutes = duration / 60;
	NSInteger seconds = (NSInteger)duration % 60;

	NSLog(@"Done in %@:%@", @(minutes), @(seconds));
}

@end
