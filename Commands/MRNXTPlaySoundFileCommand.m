//
//  MRNXTPlaySoundFileCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTPlaySoundFileCommand.h"

@implementation MRNXTPlaySoundFileCommand

@synthesize loop, filename;

- (uint8_t)identifier {
	return 0x02;
}

- (NSData *)data {
	NSMutableData *data = [NSMutableData data];
	[data appendBytes:&loop length:1];
	[data mr_appendNXTFilename:filename];
	
	return data;
}

- (void)dealloc {
	[filename release];
	
	[super dealloc];
}

@end
