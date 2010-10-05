//
//  MRNXTStartProgramCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTStartProgramCommand.h"

@implementation MRNXTStartProgramCommand

@synthesize filename = _filename;

- (uint8_t)identifier {
	return 0x0;
}

- (NSData *)data {
	return [NSData dataWithBytes:[_filename UTF8String] length:20];
}

- (void)dealloc {
	[_filename release];
	
	[super dealloc];
}

@end
