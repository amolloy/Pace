//
//  ASMTrackFC.h
//  Pace
//
//  Created by Andrew Molloy on 5/22/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import "FCModel.h"

@interface ASMTrack : FCModel

@property (nonatomic) int64_t id;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) NSNumber* tempo;
@property (nonatomic, copy) NSString* title;
@property (nonatomic) NSNumber* mediaItemPersistentID;

@end
