//
//  MRNXTFileResponse.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTFileResponse.h"

@implementation MRNXTFileResponse

@synthesize handle, filename, size;

- (void)parseBodyData:(NSData *)data {
	[data getBytes:&handle range:NSMakeRange(0, 1)];
	
	char name[20];
	[data getBytes:&name range:NSMakeRange(1, 20)];
	
	filename = [[NSString alloc] initWithUTF8String:name];
	
	[data getBytes:&size range:NSMakeRange(21, 4)];
	size = OSSwapLittleToHostInt32(size);
}

- (void)dealloc {
	[filename release];
	
	[super dealloc];
}

@end
