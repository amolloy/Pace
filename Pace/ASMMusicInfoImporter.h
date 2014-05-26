//
//  ASMMusicInfoImporter.h
//  Pace
//
//  Created by Andrew Molloy on 5/21/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^blehCompletion)();

@interface ASMMusicInfoImporter : NSObject

-(void)blehUsingFCModelCompletion:(blehCompletion)completion;

@end
