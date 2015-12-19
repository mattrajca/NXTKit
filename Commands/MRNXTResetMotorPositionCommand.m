//
//  MRNXTResetMotorPositionCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTResetMotorPositionCommand.h"

@implementation MRNXTResetMotorPositionCommand

@synthesize port, relative;

- (uint8_t)identifier {
	return 0x0A;
}

- (NSData *)data {
	NSMutableData *data = [[NSMutableData alloc] init];
	[data appendBytes:&port length:sizeof(port)];
	[data appendBytes:&relative length:1];
	
	return data;
}

@end
