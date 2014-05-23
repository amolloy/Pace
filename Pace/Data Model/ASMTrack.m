//
//  ASMTrackFC.m
//  Pace
//
//  Created by Andrew Molloy on 5/22/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import "ASMTrack.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation ASMTrack

-(NSString*)artist
{
	NSAssert(self.mediaItem, @"Can't get artist before we have our media item");
	return [self.mediaItem valueForProperty:MPMediaItemPropertyArtist];
}

@end
