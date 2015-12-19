//
//  MRNXTReadIOMapCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

#import "MRNXTCommand.h"

@interface MRNXTReadIOMapCommand : MRNXTCommand

@property (assign) uint32_t moduleID;
@property (assign) uint16_t offset;
@property (assign) uint16_t bytesToRead; // max: 64 bytes

@end
