//
//  MRNXTDevice.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRDevice.h"
#import "MRNXTCommand.h"

@class MRNXTResponse;

@interface MRNXTDevice : MRDevice {
  @private
	NSMutableArray *_queue;
	MRNXTCommand *_currentCommand;
}

- (void)enqueueCommand:(MRNXTCommand *)aCommand responseBlock:(MRNXTResponseBlock)block;

@end
