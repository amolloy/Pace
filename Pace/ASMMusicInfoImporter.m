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

@implementation ASMMusicInfoImporter

-(ASMTrack*)createTrackInManagedObjectContext:(NSManagedObjectContext*)moc fromItem:(MPMediaItem*)mediaItem
{
	static NSUInteger insertCount = 0;

	ASMTrack* newTrack = [ASMTrack insertInManagedObjectContext:moc];
	newTrack.title = [mediaItem valueForProperty:MPMediaItemPropertyTitle];
	newTrack.duration = [mediaItem valueForProperty:MPMediaItemPropertyPlaybackDuration];
	newTrack.trackHash = [mediaItem digest];
	newTrack.mediaItemPersistentID = [mediaItem valueForProperty:MPMediaItemPropertyPersistentID];

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

	[query.items enumerateObjectsUsingBlock:^(MPMediaItem* mediaItem, NSUInteger idx, BOOL *stop) {
		NSNumber* digest = [mediaItem digest];
		NSNumber* duration = [mediaItem valueForProperty:MPMediaItemPropertyPlaybackDuration];

		request.predicate = [NSPredicate predicateWithFormat:@"trackHash=%@ AND duration=%@", digest, duration];

		NSError* error = nil;
		NSArray* tracks = [moc executeFetchRequest:request error:&error];

		if (tracks.count)
		{
			NSLog(@"Found it already");
		}
		else
		{
			[itemsToLookup addObject:[self createTrackInManagedObjectContext:moc
																	fromItem:mediaItem]];
		}
	}];

	NSError* error = nil;
	[moc save:&error];

	NSLog(@"Done");
}

@end
