//
//  MRDevice.h
//  DeviceKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRDeviceTransport.h"

@protocol MRDeviceDelegate;

/* treat this class as abstract */

@interface MRDevice : NSObject < MRDeviceTransportDelegate > {
  @private
	MRDeviceTransport *_transport;
	__weak id < MRDeviceDelegate > _delegate;
}

@property (readonly, getter=isOpen) BOOL open;
@property (readonly) MRDeviceTransport *transport;

@property (weak) id < MRDeviceDelegate > delegate;

- (instancetype)initWithTransport:(MRDeviceTransport *)aTransport;

- (BOOL)open:(NSError **)error;
- (void)close;

/* this is only for use by subclasses */
- (void)wroteData;
- (void)receivedData:(NSData *)data;

@end


@protocol MRDeviceDelegate < NSObject >

@optional

- (void)deviceDidOpen:(MRDevice *)aDevice;
- (void)device:(MRDevice *)aDevice didFailToOpen:(NSError *)error;

- (void)deviceDidClose:(MRDevice *)aDevice;

@end
