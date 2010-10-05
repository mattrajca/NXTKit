//
//  MRNXTWriteCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTCommand.h"

@interface MRNXTWriteCommand : MRNXTCommand {
  @private
	uint8_t _handle;
	NSData *_data;
}

@property (assign) uint8_t handle;
@property (retain) NSData *data;

@end
