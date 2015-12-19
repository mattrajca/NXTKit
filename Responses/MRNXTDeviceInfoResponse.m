//
//  MRNXTDeviceInfoResponse.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTDeviceInfoResponse.h"

@implementation MRNXTDeviceInfoResponse

- (void)parseBodyData:(NSData *)data {
	char name[15];
	[data getBytes:&name range:NSMakeRange(0, 15)];
	
	_brickName = [[NSString alloc] initWithUTF8String:name];
	
	[data getBytes:&_freeSpace range:NSMakeRange(26, 4)];
	_freeSpace = OSSwapLittleToHostInt32(_freeSpace);
}

@end
