//
//  MRNXTDataResponse.m
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTDataResponse.h"

@implementation MRNXTDataResponse

@synthesize handle = _handle;
@synthesize bytesRead = _bytesRead;
@synthesize data = _data;

- (void)parseBodyData:(NSData *)data {
	[data getBytes:&_handle range:NSMakeRange(0, 1)];
	
	[data getBytes:&_bytesRead range:NSMakeRange(1, 2)];
	_bytesRead = OSSwapLittleToHostInt16(_bytesRead);
	
	_data = [[data subdataWithRange:NSMakeRange(3, [data length] - 3)] retain];
}

- (void)dealloc {
	[_data release];
	
	[super dealloc];
}

@end
