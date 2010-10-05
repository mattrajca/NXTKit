//
//  MRNXTHandleSizeResponse.m
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTHandleSizeResponse.h"

@implementation MRNXTHandleSizeResponse

@synthesize handle = _handle;
@synthesize size = _size;

- (void)parseBodyData:(NSData *)data {
	[data getBytes:&_handle range:NSMakeRange(0, 1)];
	
	NSUInteger sz = [data length] - 1;
	
	if (sz == 4) { /* 32-bit size */
		[data getBytes:&_size range:NSMakeRange(1, 4)];
		_size = OSSwapLittleToHostInt32(_size);
	}
	else if (sz == 2) { /* 16-bit size */
		uint16_t ret;
		
		[data getBytes:&ret range:NSMakeRange(1, 2)];
		_size = (uint32_t) OSSwapLittleToHostInt16(ret);
	}
}

@end
