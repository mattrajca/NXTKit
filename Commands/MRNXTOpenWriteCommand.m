//
//  MRNXTOpenWriteCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTOpenWriteCommand.h"

#import "MRNXTHandleResponse.h"

@implementation MRNXTOpenWriteCommand

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
	[data mr_appendNXTFilename:_filename];
	
	uint32_t n_size = OSSwapHostToLittleInt32(_size);
	[data appendBytes:&n_size length:sizeof(n_size)];
	
	return data;
}

@end
