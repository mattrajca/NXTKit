//
//  MRNXTWriteCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTCommand.h"

@interface MRNXTWriteCommand : MRNXTCommand

@property (assign) uint8_t handle;
@property NSData *contents; // max size: 64 bytes

@end
