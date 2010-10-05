//
//  MRNXTReadCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTCommand.h"

@interface MRNXTReadCommand : MRNXTCommand {
  @private
	uint8_t _handle;
	uint16_t _bytesToRead;
}

@property (assign) uint8_t handle;
@property (assign) uint16_t bytesToRead;

@end
