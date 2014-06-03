//
//  ASMEchoNestTempoQueue.m
//  Pace
//
//  Created by Andrew Molloy on 5/31/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import "ASMEchoNestTempoQueue.h"
#import "ASMEchoNestManager.h"

@interface ASMEchoNestTempoQueue ()
@property (nonatomic, assign) NSInteger errorCount;
@property (nonatomic, copy) NSString* echoNestCatalogID;
@end

@implementation ASMEchoNestTempoQueue

-(id)init
{
	self = [super init];
	if (self)
	{
		self.errorCount = 0;
		[self createEchoNestCatalog];
	}
	return self;
}

-(void)retryCreateEchoNestCatalog
{
	if (self.errorCount >= 5)
	{
		NSLog(@"Made 5 attempts with no success, giving up.");
	}
	else
	{
		NSInteger retryTime = 0;
		if (self.errorCount < 2)
		{
			retryTime = 5;
		}
		else if (self.errorCount < 4)
		{
			retryTime = 10;
		}
		else
		{
			retryTime = 30;
		}

		NSLog(@"Going to try again in %@ seconds", @(retryTime));

		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(retryTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self createEchoNestCatalog];
		});
	}
}

-(void)createEchoNestCatalog
{
	NSURL* requestURL = [[NSURL URLWithString:ASMEchoNestURL] URLByAppendingPathComponent:@"catalog/create"];
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:requestURL];

	[request setHTTPMethod:@"POST"];

	NSMutableArray* bodyArray = [NSMutableArray array];
	[bodyArray addObject:[NSString stringWithFormat:@"api_key=%@", ASMEchoNestAPIKey]];
	[bodyArray addObject:@"format=json"];
	[bodyArray addObject:@"type=song"];
	[bodyArray addObject:[NSString stringWithFormat:@"name=%@", [NSUUID UUID]]];

	[request setHTTPBody:[[bodyArray componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding]];

	[[NSURLSession sharedSession] dataTaskWithRequest:request
									completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
	 {
		 if (error)
		 {
			 NSLog(@"Error in EchoNest request to create catalog %@", error);
			 [self retryCreateEchoNestCatalog];
		 }
		 else
		 {
			 NSError* jsonError = nil;
			 NSDictionary* info = [NSJSONSerialization JSONObjectWithData:data
																  options:0
																	error:&jsonError];
			 if (jsonError)
			 {
				 NSLog(@"Invalid JSON response, trying again in 10s %@", jsonError);
				 [self retryCreateEchoNestCatalog];
			 }
			 else
			 {
				 NSDictionary* enResponse = info[@"response"];
				 self.echoNestCatalogID = enResponse[@"id"];
				 if (!self.echoNestCatalogID)
				 {
					 NSLog(@"Did not receive a catalog id.\nRequest:\n%@\n\nResponse:\n%@\n\n", request, info);
				 }
			 }
		 }

	 }];
}

@end
