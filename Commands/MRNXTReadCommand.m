//
//  MRNXTReadCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTReadCommand.h"

#import "MRNXTDataResponse.h"

@implementation MRNXTReadCommand

@synthesize handle, bytesToRead;

- (Class)responseClass {
	return [MRNXTDataResponse class];
}

- (NXTCommandType)type {
	return NXTCommandTypeSystem;
}

- (uint8_t)identifier {
	return 0x82;
}

- (NSData *)data {
	NSMutableData *data = [[NSMutableData alloc] init];
	[data appendBytes:&handle length:sizeof(handle)];
	
	uint16_t size = OSSwapHostToLittleInt16(bytesToRead);
	[data appendBytes:&size length:sizeof(size)];
	
	return data;
}

@end
