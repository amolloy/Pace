//
//  ASMEchoNestManager.m
//  Pace
//
//  Created by Andrew Molloy on 5/31/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import "ASMEchoNestManager.h"
#import "ASMEchoNestTempoQueue.h"

NSString* const ASMEchoNestAPIKey = @"BYBMYPBQEOCNICHDI";
NSString* const ASMEchoNestURL = @"http://developer.echonest.com/api/v4/";

// song/search

@interface ASMEchoNestManager ()
@property (nonatomic, strong) NSMutableArray* echoNestWorkTickets;
@end

@implementation ASMEchoNestManager

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

#pragma mark - Singleton Stuff

static ASMEchoNestManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[ASMEchoNestManager alloc] init];
}

- (id)mutableCopy
{
    return [[ASMEchoNestManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
	{
		self.echoNestWorkTickets = [NSMutableArray array];
	}
    return self;
}


@end
