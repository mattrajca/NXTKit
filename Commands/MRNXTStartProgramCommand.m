//
//  MRNXTStartProgramCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTStartProgramCommand.h"

@implementation MRNXTStartProgramCommand

@synthesize filename;

- (uint8_t)identifier {
	return 0x0;
}

- (NSData *)data {
	return [NSMutableData dataWithNXTFilename:filename];
}

- (void)dealloc {
	[filename release];
	
	[super dealloc];
}

@end
