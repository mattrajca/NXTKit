//
//  MRNXTWriteCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTCommand.h"

@interface MRNXTWriteCommand : MRNXTCommand {
  @private
	uint8_t _handle;
	NSData *_data;
}

@property (assign) uint8_t handle;
@property (retain) NSData *data; // max size: 64 bytes

@end
