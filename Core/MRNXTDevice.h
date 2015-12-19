//
//  MRNXTDevice.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRDevice.h"
#import "MRNXTCommand.h"

@interface MRNXTDevice : MRDevice

- (void)enqueueCommand:(MRNXTCommand *)aCommand responseBlock:(MRNXTResponseBlock)block;

@end
