//
//  MRNXTWriteIOMapCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

#import "MRNXTCommand.h"

@interface MRNXTWriteIOMapCommand : MRNXTCommand {
@private
    uint32_t moduleID;
    uint16_t offset;
    NSData *contents;
}

@property (assign) uint32_t moduleID;
@property (assign) uint16_t offset;
@property (retain) NSData *contents;

@end
