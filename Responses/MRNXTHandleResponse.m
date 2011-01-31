//
//  MRNXTHandleResponse.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTHandleResponse.h"

@implementation MRNXTHandleResponse

@synthesize handle;

- (void)parseBodyData:(NSData *)data {
	[data getBytes:&handle range:NSMakeRange(0, 1)];
}

@end
