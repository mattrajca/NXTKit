//
//  MRNXTReadIOMapCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

#import "MRNXTReadIOMapCommand.h"

#import "MRNXTIOMapResponse.h"

@implementation MRNXTReadIOMapCommand

@synthesize moduleID = _moduleID;
@synthesize offset = _offset;
@synthesize bytesToRead = _bytesToRead;

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
	
	uint32_t moduleID = OSSwapHostToLittleInt32(_moduleID);
	[data appendBytes:&moduleID length:sizeof(moduleID)];
	
	uint16_t offset = OSSwapHostToLittleInt16(_offset);
	[data appendBytes:&offset length:sizeof(offset)];
	
	uint16_t bytesToRead = OSSwapHostToLittleInt16(_bytesToRead);
	[data appendBytes:&bytesToRead length:sizeof(bytesToRead)];
	
	return [data autorelease];
}

@end
