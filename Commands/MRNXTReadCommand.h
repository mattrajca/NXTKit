//
//  MRNXTReadCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTCommand.h"

@interface MRNXTReadCommand : MRNXTCommand {
@private
    uint8_t handle;
    uint16_t bytesToRead; // max size: 64 bytes
}

@property (assign) uint8_t handle;
@property (assign) uint16_t bytesToRead; // max size: 64 bytes

@end
