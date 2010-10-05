//
//  MRDevice.h
//  DeviceKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
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

@property (assign) __weak id < MRDeviceDelegate > delegate;

- (id)initWithTransport:(MRDeviceTransport *)aTransport;

- (BOOL)open:(NSError **)error;
- (void)close;

/* this is only for use by subclasses */
- (void)receivedData:(NSData *)data;

@end


@protocol MRDeviceDelegate < NSObject >

@optional

- (void)deviceDidOpen:(MRDevice *)aDevice;
- (void)device:(MRDevice *)aDevice didFailToOpen:(NSError *)error;

- (void)deviceDidClose:(MRDevice *)aDevice;

@end
