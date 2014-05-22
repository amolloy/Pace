//
//  MPMediaItem+ASMHash.h
//  Pace
//
//  Created by Andrew Molloy on 5/22/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

@interface MPMediaItem (ASMHash)

-(NSString*)digestString;
-(NSNumber*)digest;

@end
