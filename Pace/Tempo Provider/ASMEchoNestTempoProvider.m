//
//  ASMEchoNestTempoProvider.m
//  Pace
//
//  Created by Andrew Molloy on 5/23/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import "ASMEchoNestTempoProvider.h"

static NSString* const ASMEchoNestAPIKey = @"BYBMYPBQEOCNICHDI";
static NSString* const ASMEchoNestURL = @"http://developer.echonest.com/api/v4/song/search";

@interface ASMEchoNestTempoProvider ()
@end

@implementation ASMEchoNestTempoProvider

-(dispatch_queue_t)dispatchQueue
{
	static dispatch_queue_t sQueue = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sQueue = dispatch_queue_create("com.amolloy.pace.echonestTempoProvider", nil);
	});
	return sQueue;
}

-(NSURLSession*)urlSession
{
	static NSURLSession* sSession = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
		config.HTTPShouldUsePipelining = YES; // TODO Determine if this helps or not.
		config.HTTPMaximumConnectionsPerHost = 1;
		sSession = [NSURLSession sessionWithConfiguration:config];
	});

	return sSession;
}

-(void)getTempoForArtist:(NSString*)artist
				   title:(NSString*)title
			  completion:(ASMTempoProviderCompletionBlock)completion
{
	NSURLComponents* urlC = [NSURLComponents componentsWithString:ASMEchoNestURL];
	NSMutableArray* queryArray = [NSMutableArray array];
	[queryArray addObject:[NSString stringWithFormat:@"api_key=%@", ASMEchoNestAPIKey]];
	[queryArray addObject:@"format=json"];
	[queryArray addObject:@"results=1"];
	[queryArray addObject:[NSString stringWithFormat:@"artist=%@", artist]];
	[queryArray addObject:[NSString stringWithFormat:@"title=%@", title]];
	[queryArray addObject:@"bucket=audio_summary"];
	urlC.query = [queryArray componentsJoinedByString:@"&"];

	dispatch_async([self dispatchQueue], ^{
		dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

		__block NSNumber* rateLimitLimit = nil;

		[[[self urlSession] dataTaskWithURL:[urlC URL]
				completionHandler:^(NSData *data,
									NSURLResponse *response,
									NSError *error)
		  {
			  NSNumber* tempo = nil;
			  NSError* outError = error;

			  // Get the rate limit limit
			  if ([response isKindOfClass:[NSHTTPURLResponse class]])
			  {
				  NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
				  NSString* rateLimitLimitStr = httpResponse.allHeaderFields[@"X-Ratelimit-Limit"];
				  if (rateLimitLimitStr)
				  {
					  rateLimitLimit = @([rateLimitLimitStr integerValue]);
				  }
			  }

			  if (error)
			  {
				  NSLog(@"Error in EchoNest request for track %@", error);
			  }
			  else
			  {
				  NSError* jsonError = nil;
				  NSDictionary* info = [NSJSONSerialization JSONObjectWithData:data
																	   options:0
																		 error:&jsonError];
				  if (jsonError)
				  {
					  NSLog(@"Invalid JSON response: %@", jsonError);
					  outError = jsonError;
				  }
				  else
				  {
					  NSDictionary* response = info[@"response"];
					  NSArray* songs = response[@"songs"];
					  NSDictionary* song = songs.firstObject;
					  NSDictionary* audioSummary = song[@"audio_summary"];
					  NSString* tempoStr = audioSummary[@"tempo"];
					  if (tempoStr)
					  {
						  tempo = @([tempoStr doubleValue]);
					  }
				  }
			  }

			  completion(tempo, outError);

			  dispatch_semaphore_signal(semaphore);
		  }] resume];

		dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

		if (rateLimitLimit)
		{
			// EchoNest defines their rate limit as requests per minute
			NSLog(@"X-RateLimit-Limit: %@", rateLimitLimit);
			NSTimeInterval delay = (60.0 / [rateLimitLimit doubleValue]);
			NSLog(@"Going to wait %@ seconds", @(delay));
			[NSThread sleepForTimeInterval:delay];
		}
		else
		{
			NSLog(@"Didn't get a rate limit, going to delay for 0.1s");
			[NSThread sleepForTimeInterval:0.1];
		}
	});
}

@end
