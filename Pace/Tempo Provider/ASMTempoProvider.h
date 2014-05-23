//
//  ASMTempoProvider.h
//  Pace
//
//  Created by Andrew Molloy on 5/23/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ASMTempoProviderCompletionBlock)(NSNumber* tempo, NSError* error);

@interface ASMTempoProvider : NSObject
-(void)getTempoForArtist:(NSString*)artist
				   title:(NSString*)title
			  completion:(ASMTempoProviderCompletionBlock)completion;
@end
