//
//  MRNXTIOMapResponse.m
//  NXTKit
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

#import "MRNXTIOMapResponse.h"

@implementation MRNXTIOMapResponse

- (void)parseBodyData:(NSData *)data {
	[data getBytes:&_moduleID range:NSMakeRange(0, 4)];
	_moduleID = OSSwapLittleToHostInt32(_moduleID);
	
	[data getBytes:&_bytesRead range:NSMakeRange(4, 2)];
	_bytesRead = OSSwapLittleToHostInt16(_bytesRead);
	
	_contents = [data subdataWithRange:NSMakeRange(6, _bytesRead)];
}

@end
