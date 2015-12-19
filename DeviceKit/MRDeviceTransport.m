//
//  MRDeviceTransport.m
//  DeviceKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRDeviceTransport.h"

@implementation MRDeviceTransport

- (BOOL)open:(NSError **)outError {
	@throw [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:@"'open' must be overriden"
								 userInfo:nil];
	
	return NO;
}

- (void)close {
	@throw [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:@"'close' must be overriden"
								 userInfo:nil];
}

- (BOOL)writeData:(NSData *)data error:(NSError **)outError {
	@throw [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:@"'writeData:error:' must be overriden"
								 userInfo:nil];
	
	return NO;
}

- (void)wroteData {
	if ([_delegate respondsToSelector:@selector(deviceTransportDidWriteData:)]) {
		[_delegate deviceTransportDidWriteData:self];
	}
}

- (void)receivedData:(NSData *)data {
	if ([_delegate respondsToSelector:@selector(deviceTransport:didReceiveData:)]) {
		[_delegate deviceTransport:self didReceiveData:data];
	}
}

- (void)opened {
	_open = YES;
	
	if ([_delegate respondsToSelector:@selector(deviceTransportDidOpen:)]) {
		[_delegate deviceTransportDidOpen:self];
	}
}

- (void)failedToOpen:(NSError *)error {
	_open = NO;
	
	if ([_delegate respondsToSelector:@selector(deviceTransport:didFailToOpen:)]) {
		[_delegate deviceTransport:self didFailToOpen:error];
	}
}

- (void)closed {
	_open = NO;
	
	if ([_delegate respondsToSelector:@selector(deviceTransportDidClose:)]) {
		[_delegate deviceTransportDidClose:self];
	}
}

@end
