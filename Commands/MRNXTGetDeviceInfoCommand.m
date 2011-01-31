//
//  MRNXTGetDeviceInfoCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTGetDeviceInfoCommand.h"

#import "MRNXTDeviceInfoResponse.h"

@implementation MRNXTGetDeviceInfoCommand

- (Class)responseClass {
	return [MRNXTDeviceInfoResponse class];
}

- (NXTCommandType)type {
	return NXTCommandTypeSystem;
}

- (uint8_t)identifier {
	return 0x9B;
}

@end
