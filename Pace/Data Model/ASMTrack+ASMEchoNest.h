//
//  ASMTrack+ASMEchoNest.h
//  Pace
//
//  Created by Andrew Molloy on 5/23/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import "ASMTrack.h"

@interface ASMTrack (ASMEchoNest)
-(void)retrieveTempFromEchoNestWithURLSession:(NSURLSession*)session;
@end
