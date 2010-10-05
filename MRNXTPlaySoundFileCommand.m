//
//  MRNXTPlaySoundFileCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTPlaySoundFileCommand.h"

@implementation MRNXTPlaySoundFileCommand

@synthesize loop = _loop;
@synthesize filename = _filename;

- (uint8_t)identifier {
	return 0x02;
}

- (NSData *)data {
	NSMutableData *data = [NSMutableData data];
	[data appendBytes:&_loop length:1];
	[data appendBytes:[_filename UTF8String] length:20];
	
	return data;
}

- (void)dealloc {
	[_filename release];
	
	[super dealloc];
}

@end
