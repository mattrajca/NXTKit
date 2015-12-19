//
//  MRNXTHandleResponse.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTHandleResponse.h"

@implementation MRNXTHandleResponse

- (void)parseBodyData:(NSData *)data {
	[data getBytes:&_handle range:NSMakeRange(0, 1)];
}

@end
