//
//  MRNXTFileResponse.m
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTFileResponse.h"

@implementation MRNXTFileResponse

@synthesize handle = _handle;
@synthesize filename = _filename;
@synthesize size = _size;

- (void)parseBodyData:(NSData *)data {
	[data getBytes:&_handle range:NSMakeRange(0, 1)];
	
	char name[20];
	[data getBytes:&name range:NSMakeRange(1, 20)];
	
	_filename = [[NSString alloc] initWithUTF8String:name];
	
	[data getBytes:&_size range:NSMakeRange(21, 4)];
	_size = OSSwapLittleToHostInt32(_size);
}

- (void)dealloc {
	[_filename release];
	
	[super dealloc];
}

@end
