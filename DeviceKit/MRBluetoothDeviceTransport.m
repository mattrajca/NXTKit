//
//  MRBluetoothDeviceTransport.m
//  DeviceKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRBluetoothDeviceTransport.h"

#import <IOBluetooth/IOBluetooth.h>
#import "NSError+IOKit.h"

@implementation MRBluetoothDeviceTransport

@synthesize bluetoothDevice = _bluetoothDevice;

+ (id)deviceWithAddress:(const BluetoothDeviceAddress *)address {
	return [[[[self class] alloc] initWithAddress:address] autorelease];
}

+ (id)deviceWithBluetoothDevice:(IOBluetoothDevice *)device {
	return [[[[self class] alloc] initWithBluetoothDevice:device] autorelease];
}

- (id)initWithAddress:(const BluetoothDeviceAddress *)address {
	NSParameterAssert(address != nil);
	
	self = [super init];
	if (self) {
		_bluetoothDevice = [[IOBluetoothDevice withAddress:address] retain];
	}
	return self;
}

- (id)initWithBluetoothDevice:(IOBluetoothDevice *)device {
	NSParameterAssert(device != nil);
	
	self = [super init];
	if (self) {
		_bluetoothDevice = [device retain];
	}
	return self;
}

- (BOOL)open:(NSError **)outError {
	IOReturn status = [_bluetoothDevice openConnection:self];
	
	if (status != kIOReturnSuccess) {
		if (outError)
			*outError = [NSError IOKitErrorWithReturnCode:status];
		
		return NO;
	}
	
	return YES;
}

- (void)close {
	if (self.open) {
		[_channel closeChannel];
		[_bluetoothDevice closeConnection];
		
		[self closed];
	}
}

- (BOOL)writeData:(NSData *)data error:(NSError **)outError {
	NSParameterAssert(data != nil);
	
	IOReturn status = [_channel writeAsync: (void *) [data bytes]
									length:[data length]
									refcon:self];
	
	if (status == kIOReturnSuccess)
		return YES;
	
	if (outError)
		*outError = [NSError IOKitErrorWithReturnCode:status];
	
	return NO;
}

- (void)connectionComplete:(IOBluetoothDevice *)device status:(IOReturn)status {
	if (status != kIOReturnSuccess) {
		[self failedToOpen:[NSError IOKitErrorWithReturnCode:status]];
		return;
	}
	
	BluetoothRFCOMMChannelID channelID = 0;
	
	IOBluetoothSDPUUID *uuid = [IOBluetoothSDPUUID uuid16:kBluetoothSDPUUID16ServiceClassSerialPort];
	IOBluetoothSDPServiceRecord *record = [_bluetoothDevice getServiceRecordForUUID:uuid];
	
	status = [record getRFCOMMChannelID:&channelID];
	
	if (status != kIOReturnSuccess) {
		[self failedToOpen:[NSError IOKitErrorWithReturnCode:status]];
		return;
	}
	
	status = [_bluetoothDevice openRFCOMMChannelAsync:&_channel
										withChannelID:channelID
											 delegate:self];
	
	if (status != kIOReturnSuccess) {
		_channel = nil;
		
		[self failedToOpen:[NSError IOKitErrorWithReturnCode:status]];
		return;
	}
	
	[_channel retain];
}

- (void)rfcommChannelOpenComplete:(IOBluetoothRFCOMMChannel *)rfcommChannel
						   status:(IOReturn)status {
	
	if (status == kIOReturnSuccess) {
		[self opened];
		return;
	}
	
	[self failedToOpen:[NSError IOKitErrorWithReturnCode:status]];
}

- (void)rfcommChannelData:(IOBluetoothRFCOMMChannel *)rfcommChannel
					 data:(void *)dataPointer
				   length:(size_t)dataLength {
	
	NSData *data = [NSData dataWithBytes:dataPointer
								  length:dataLength];
	
	[self receivedData:data];
}

- (void)rfcommChannelClosed:(IOBluetoothRFCOMMChannel *)rfcommChannel {
	[self close];
}

- (void)dealloc {
	[_bluetoothDevice release];
	[_channel release];
	
	[super dealloc];
}

@end
