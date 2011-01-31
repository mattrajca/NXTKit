//
//  MRNXTHandleSizeResponse.m
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTHandleSizeResponse.h"

@implementation MRNXTHandleSizeResponse

@synthesize size;

- (void)parseBodyData:(NSData *)data {
	[super parseBodyData:data];
	
	[data getBytes:&size range:NSMakeRange(1, 2)];
	size = OSSwapLittleToHostInt16(size);
}

@end
