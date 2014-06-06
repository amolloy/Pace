//
//  EchoNestManager.swift
//  Pace
//
//  Created by Andrew Molloy on 6/5/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

import Foundation

let SharedEchoNestManager = EchoNestManager()

class EchoNestManager {
	// TODO Make these class variables once Swift supports that.
	let echoNestAPIKey = "BYBMYPBQEOCNICHDI"
	let echoNestBaseURL = "http://developer.echonest.com/api/v4/"

	var workTickets : Array<EchoNestTempoWorkQueue> = []

	func startBatch() {
		
	}

/*
- (id)startBatch
{
ASMEchoNestTempoQueue* newQueue = [[ASMEchoNestTempoQueue alloc] init];
[self.echoNestWorkTickets addObject:newQueue];
return @([self.echoNestWorkTickets count] - 1);
}

- (void)addTrack:(ASMTrack*)track toBatch:(id)batch
{

}

- (void)finishBatch
{

}
*/


}
