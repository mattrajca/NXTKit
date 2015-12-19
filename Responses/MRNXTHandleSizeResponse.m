//
//  MRNXTHandleSizeResponse.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTHandleSizeResponse.h"

@implementation MRNXTHandleSizeResponse

- (void)parseBodyData:(NSData *)data {
	[super parseBodyData:data];
	
	[data getBytes:&_size range:NSMakeRange(1, 2)];
	_size = OSSwapLittleToHostInt16(_size);
}

@end
