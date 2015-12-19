//
//  MRNXTReadIOMapCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

#import "MRNXTReadIOMapCommand.h"

#import "MRNXTIOMapResponse.h"

@implementation MRNXTReadIOMapCommand

@synthesize moduleID, offset, bytesToRead;

- (Class)responseClass {
	return [MRNXTIOMapResponse class];
}

- (NXTCommandType)type {
	return NXTCommandTypeSystem;
}

- (uint8_t)identifier {
	return 0x94;
}

- (NSData *)data {
	NSMutableData *data = [[NSMutableData alloc] init];
	
	uint32_t n_moduleID = OSSwapHostToLittleInt32(moduleID);
	[data appendBytes:&n_moduleID length:sizeof(n_moduleID)];
	
	uint16_t n_offset = OSSwapHostToLittleInt16(offset);
	[data appendBytes:&n_offset length:sizeof(n_offset)];
	
	uint16_t n_bytesToRead = OSSwapHostToLittleInt16(bytesToRead);
	[data appendBytes:&n_bytesToRead length:sizeof(n_bytesToRead)];
	
	return data;
}

@end
