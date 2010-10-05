//
//  MRNXTDataResponse.m
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTDataResponse.h"

@implementation MRNXTDataResponse

@synthesize data = _data;

- (void)parseBodyData:(NSData *)data {
	[super parseBodyData:data];
	
	_data = [[data subdataWithRange:NSMakeRange(3, [data length] - 3)] retain];
}

- (void)dealloc {
	[_data release];
	
	[super dealloc];
}

@end
