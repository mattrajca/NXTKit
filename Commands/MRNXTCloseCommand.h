//
//  MRNXTCloseCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTCommand.h"

@interface MRNXTCloseCommand : MRNXTCommand {
  @private
	uint8_t _handle;
}

@property (assign) uint8_t handle;

@end
