//
//  MRNXTDeleteCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTDeleteCommand.h"

@implementation MRNXTDeleteCommand

@synthesize filename;

- (NXTCommandType)type {
	return NXTCommandTypeSystem;
}

- (uint8_t)identifier {
	return 0x85;
}

- (NSData *)data {
	return [NSMutableData dataWithNXTFilename:filename];
}

- (void)dealloc {
	[filename release];
	
	[super dealloc];
}

@end
