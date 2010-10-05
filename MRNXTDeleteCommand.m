//
//  MRNXTDeleteCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTDeleteCommand.h"

@implementation MRNXTDeleteCommand

@synthesize filename = _filename;

- (NXTCommandType)type {
	return NXTCommandTypeSystem;
}

- (uint8_t)identifier {
	return 0x85;
}

- (NSData *)data {
	return [NSData dataWithBytes:[_filename UTF8String] length:20];
}

- (void)dealloc {
	[_filename release];
	
	[super dealloc];
}

@end
