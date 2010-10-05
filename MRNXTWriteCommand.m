//
//  MRNXTWriteCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTWriteCommand.h"

#import "MRNXTHandleSizeResponse.h"

@implementation MRNXTWriteCommand

@synthesize handle = _handle;
@synthesize data = _data;

- (Class)responseClass {
	return [MRNXTHandleSizeResponse class];
}

- (NXTCommandType)type {
	return NXTCommandTypeSystem;
}

- (uint8_t)identifier {
	return 0x83;
}

- (NSData *)data {
	NSMutableData *data = [[NSMutableData alloc] init];
	[data appendBytes:&_handle length:sizeof(_handle)];
	[data appendData:_data];
	
	return [data autorelease];
}

- (void)dealloc {
	[_data release];
	
	[super dealloc];
}

@end
