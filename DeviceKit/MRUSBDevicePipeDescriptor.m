//
//  MRUSBDevicePipeDescriptor.m
//  DeviceKit
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

#import "MRUSBDevicePipeDescriptor.h"

@implementation MRUSBDevicePipeDescriptor

@synthesize type = _type;
@synthesize direction = _direction;

+ (id)pipeDescriptorWithTransferType:(MRUSBTransferType)type direction:(MRUSBTransferDirection)dir {
	return [[[[self class] alloc] initWithTransferType:type direction:dir] autorelease];
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
