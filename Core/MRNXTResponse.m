//
//  MRNXTResponse.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTResponse.h"

@interface MRNXTResponse ()

- (void)parseHeaderData:(NSData *)data;

@end


@implementation MRNXTResponse

- (instancetype)initWithData:(NSData *)data {
	if (!(self = [super init]))
		return nil;

	[self parseHeaderData:[data subdataWithRange:NSMakeRange(2, 3)]];
	
	if (data.length > 3) {
		[self parseBodyData:[data subdataWithRange:NSMakeRange(5, data.length - 5)]];
	}

	return self;
}

- (void)parseHeaderData:(NSData *)data {
	[data getBytes:&_status range:NSMakeRange(2, 1)];
}

- (void)parseBodyData:(NSData *)data { }

- (NSString *)description {
	return [NSString stringWithFormat:@"MRNXTResponse [status=%d]", _status];
}

@end
