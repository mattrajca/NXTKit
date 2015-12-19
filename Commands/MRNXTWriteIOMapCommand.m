//
//  MRNXTWriteIOMapCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

#import "MRNXTWriteIOMapCommand.h"

@implementation MRNXTWriteIOMapCommand

@synthesize moduleID, offset, contents;

- (NXTCommandType)type {
	return NXTCommandTypeSystem;
}

- (uint8_t)identifier {
	return 0x95;
}

- (NSData *)data {
	NSParameterAssert (contents != nil);
	
	NSMutableData *data = [[NSMutableData alloc] init];
	
	uint32_t n_moduleID = OSSwapHostToLittleInt32(moduleID);
	[data appendBytes:&n_moduleID length:sizeof(n_moduleID)];
	
	uint16_t n_offset = OSSwapHostToLittleInt16(offset);
	[data appendBytes:&n_offset length:sizeof(n_offset)];
	
	uint16_t n_bytesToWrite = OSSwapHostToLittleInt16([data length]);
	[data appendBytes:&n_bytesToWrite length:sizeof(n_bytesToWrite)];
	
	[data appendData:contents];
	
	return data;
}

@end
