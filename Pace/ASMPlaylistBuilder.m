//
//  ASMPlaylistBuilder.m
//  Pace
//
//  Created by Andrew Molloy on 5/26/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import "ASMPlaylistBuilder.h"
#import "FCModel.h"
#import "Pace-Swift.h"

static const NSInteger sTEMPTargetBPM = 153;
static const NSInteger sTEMPVariance = 5;

@implementation ASMPlaylistBuilder

-(void)buildPlaylist
{
	NSArray* tracks = [Track instancesWhere:@"tempo NOT NULL and tempo BETWEEN ? AND ?", @(sTEMPTargetBPM - sTEMPVariance), @(sTEMPTargetBPM + sTEMPVariance)];

	printf("Artist\tAlbum\tName\n");

	[tracks enumerateObjectsUsingBlock:^(Track* track, NSUInteger idx, BOOL *stop) {
		printf("\"%s\"\t\"%s\"\t\"%s\"\n", [track.artist cStringUsingEncoding:NSUTF8StringEncoding],
			   [track.album cStringUsingEncoding:NSUTF8StringEncoding],
			   [track.title cStringUsingEncoding:NSUTF8StringEncoding]);
	}];
}

@end
