//
//  ASMEchoNestManager.h
//  Pace
//
//  Created by Andrew Molloy on 5/31/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

@class ASMTrack;

extern NSString* const ASMEchoNestAPIKey;
extern NSString* const ASMEchoNestURL;

@interface ASMEchoNestManager : NSObject

/**
 *	Start a new batch to request tempos from The Echo Nest.
 *
 *	@return A token representing the new batch.
 */
- (id)startBatch;

/**
 *	Add a track to the batch queue to get tempo.
 *
 *	@param track The track to add to the queue.
 *	@param batch The token representing the new batch.
 */
- (void)addTrack:(ASMTrack*)track toBatch:(id)batch;

/**
 *	Indicate that the batch is ready to be sent to The Echo Nest.
 */
- (void)finishBatch;

/**
 * gets singleton object.
 * @return singleton
 */
+ (ASMEchoNestManager*)sharedInstance;

@end
