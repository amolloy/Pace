//
//  ASMEchoNestTempoQueue.h
//  Pace
//
//  Created by Andrew Molloy on 5/31/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASMEchoNestTempoQueue : NSObject
@property (nonatomic, strong) NSMutableSet* tracks;

-(id)init;

@end
