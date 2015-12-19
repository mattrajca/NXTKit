//
//  MRNXTWriteCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTWriteCommand.h"

#import "MRNXTHandleSizeResponse.h"

@implementation MRNXTWriteCommand

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
	[cData appendBytes:&_handle length:sizeof(_handle)];
	[cData appendData:_contents];
	
	return cData;
}

@end
