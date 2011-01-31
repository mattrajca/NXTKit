//
//  MRNXTDeviceInfoResponse.m
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTDeviceInfoResponse.h"

@implementation MRNXTDeviceInfoResponse

@synthesize brickName, freeSpace;

- (void)parseBodyData:(NSData *)data {
	char name[15];
	[data getBytes:&name range:NSMakeRange(0, 15)];
	
	brickName = [[NSString alloc] initWithUTF8String:name];
	
	[data getBytes:&freeSpace range:NSMakeRange(26, 4)];
	freeSpace = OSSwapLittleToHostInt32(freeSpace);
}

- (void)dealloc {
	[brickName release];
	
	[super dealloc];
}

@end
