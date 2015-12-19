//
//  MRNXTSetOutputStateCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTSetOutputStateCommand.h"

@implementation MRNXTSetOutputStateCommand

@synthesize port, power, outputMode, regulationMode, turnRatio, runState, tachoLimit;

- (uint8_t)identifier {
	return 0x04;
}

- (NSData *)data {
	NSMutableData *data = [[NSMutableData alloc] init];
	[data appendBytes:&port length:sizeof(port)];
	[data appendBytes:&power length:sizeof(power)];
	[data appendBytes:&outputMode length:sizeof(outputMode)];
	[data appendBytes:&regulationMode length:sizeof(regulationMode)];
	[data appendBytes:&turnRatio length:sizeof(turnRatio)];
	[data appendBytes:&runState length:sizeof(runState)];
	[data appendBytes:&tachoLimit length:sizeof(tachoLimit)];
	
	return data;
}

@end
