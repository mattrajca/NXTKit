//
//  MRNXTPlaySoundFileCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTPlaySoundFileCommand.h"

@implementation MRNXTPlaySoundFileCommand

- (uint8_t)identifier {
	return 0x02;
}

- (NSData *)data {
	NSMutableData *data = [NSMutableData data];
	[data appendBytes:&_loop length:1];
	[data mr_appendNXTFilename:_filename];
	
	return data;
}

@end
