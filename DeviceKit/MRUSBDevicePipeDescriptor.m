//
//  MRUSBDevicePipeDescriptor.m
//  DeviceKit
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

#import "MRUSBDevicePipeDescriptor.h"

@implementation MRUSBDevicePipeDescriptor

+ (id)pipeDescriptorWithTransferType:(MRUSBTransferType)type direction:(MRUSBTransferDirection)dir {
	return [[[self class] alloc] initWithTransferType:type direction:dir];
}

- (id)initWithTransferType:(MRUSBTransferType)type direction:(MRUSBTransferDirection)dir {
	self = [super init];
	if (self) {
		_type = type;
		_direction = dir;
	}
	return self;
}

@end
