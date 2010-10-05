//
//  MRNXTOpenWriteCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTOpenWriteCommand.h"

#import "MRNXTHandleResponse.h"

@implementation MRNXTOpenWriteCommand

@synthesize filename = _filename;
@synthesize size = _size;

- (Class)responseClass {
	return [MRNXTHandleResponse class];
}

- (NXTCommandType)type {
	return NXTCommandTypeSystem;
}

- (uint8_t)identifier {
	return 0x81;
}

- (NSData *)data {
	NSMutableData *data = [[NSMutableData alloc] init];
	[data appendBytes:[_filename UTF8String] length:20];
	
	uint32_t size = OSSwapHostToLittleInt32(_size);
	[data appendBytes:&size length:sizeof(size)];
	
	return [data autorelease];
}

- (void)dealloc {
	[_filename release];
	
	[super dealloc];
}

@end
