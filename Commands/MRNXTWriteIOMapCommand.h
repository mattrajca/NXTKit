//
//  MRNXTWriteIOMapCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

#import "MRNXTCommand.h"

@interface MRNXTWriteIOMapCommand : MRNXTCommand

@property (assign) uint32_t moduleID;
@property (assign) uint16_t offset;
@property NSData *contents;

@end
