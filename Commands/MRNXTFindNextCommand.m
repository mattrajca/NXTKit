//
//  MRNXTFindNextCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTFindNextCommand.h"

#import "MRNXTFileResponse.h"

@implementation MRNXTFindNextCommand

@synthesize handle;

- (Class)responseClass {
	return [MRNXTFileResponse class];
}

- (NXTCommandType)type {
	return NXTCommandTypeSystem;
}

- (uint8_t)identifier {
	return 0x87;
}

- (NSData *)data {
	return [NSData dataWithBytes:&handle length:sizeof(handle)];
}

@end
