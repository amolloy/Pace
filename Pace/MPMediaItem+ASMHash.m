//
//  MPMediaItem+ASMHash.m
//  Pace
//
//  Created by Andrew Molloy on 5/22/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import "MPMediaItem+ASMHash.h"
#import "NSString+ASMCityHash.h"

@implementation MPMediaItem (ASMHash)

-(NSString*)digestString
{
	NSString* artist = [self valueForProperty:MPMediaItemPropertyArtist];
	NSString* album = [self valueForProperty:MPMediaItemPropertyAlbumTitle];
	NSString* title = [self valueForProperty:MPMediaItemPropertyTitle];
	NSNumber* duration = [self valueForProperty:MPMediaItemPropertyPlaybackDuration];

	return [NSString stringWithFormat:@"%@ - %@: %@ (%@)", artist, album, title, duration];
}

-(NSNumber*)digest
{
	return @([self.digestString cityHash64]);
}

@end
