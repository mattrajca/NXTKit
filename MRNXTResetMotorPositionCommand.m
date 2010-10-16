//
//  MRNXTResetMotorPositionCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTResetMotorPositionCommand.h"

@implementation MRNXTResetMotorPositionCommand

@synthesize port = _port;
@synthesize relative = _relative;

- (uint8_t)identifier {
	return 0x0A;
}

- (NSData *)data {
	NSMutableData *data = [[NSMutableData alloc] init];
	[data appendBytes:&_port length:sizeof(_port)];
	[data appendBytes:&_relative length:1];
	
	return [data autorelease];
}

@end
