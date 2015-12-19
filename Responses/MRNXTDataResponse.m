//
//  MRNXTDataResponse.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTDataResponse.h"

@implementation MRNXTDataResponse

- (void)parseBodyData:(NSData *)data {
	[super parseBodyData:data];
	
	_data = [data subdataWithRange:NSMakeRange(3, data.length - 3)];
}

@end
