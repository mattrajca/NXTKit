//
//  MRNXTWriteCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTWriteCommand.h"

#import "MRNXTHandleSizeResponse.h"

@implementation MRNXTWriteCommand

@synthesize handle, data;

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
	NSMutableData *cData = [[NSMutableData alloc] init];
	[cData appendBytes:&handle length:sizeof(handle)];
	[cData appendData:data];
	
	return [cData autorelease];
}

- (void)dealloc {
	[data release];
	
	[super dealloc];
}

@end
