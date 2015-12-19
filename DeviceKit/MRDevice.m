//
//  MRDevice.m
//  DeviceKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRDevice.h"

@implementation MRDevice

@dynamic open;

- (instancetype)initWithTransport:(MRDeviceTransport *)aTransport {
	NSParameterAssert(aTransport != nil);
	
	self = [super init];
	if (self) {
		_transport = aTransport;
		_transport.delegate = self;
	}
	return self;
}

- (BOOL)isOpen {
	return self.transport.open;
}

- (BOOL)open:(NSError **)error {
	return [self.transport open:error];
}

- (void)close {
	[self.transport close];
}

- (void)deviceTransportDidOpen:(MRDeviceTransport *)aTransport {
	if ([_delegate respondsToSelector:@selector(deviceDidOpen:)]) {
		[_delegate deviceDidOpen:self];
	}
}

- (void)deviceTransport:(MRDeviceTransport *)aTransport
		  didFailToOpen:(NSError *)error {
	
	if ([_delegate respondsToSelector:@selector(device:didFailToOpen:)]) {
		[_delegate device:self didFailToOpen:error];
	}
}

- (void)deviceTransportDidWriteData:(MRDeviceTransport *)aTransport {
	[self wroteData];
}

- (void)deviceTransport:(MRDeviceTransport *)aTransport
		 didReceiveData:(NSData *)data {
	
	[self receivedData:data];
}

- (void)deviceTransportDidClose:(MRDeviceTransport *)aTransport {
	if ([_delegate respondsToSelector:@selector(deviceDidClose:)]) {
		[_delegate deviceDidClose:self];
	}
}

- (void)wroteData { }

- (void)receivedData:(NSData *)data { }

- (void)finalize {
	[self close];
	[super finalize];
}

- (void)dealloc {
	[self close];
}

@end
