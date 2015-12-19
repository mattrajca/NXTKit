//
//  MRUSBDeviceTransport.h
//  DeviceKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRDeviceTransport.h"
#import "MRUSBDevicePipeDescriptor.h"
#import <IOKit/usb/IOUSBLib.h>

@class MRUSBDeviceEntry;

/* only tested while talking to devices configured by the AppleUSBComposite driver */

@interface MRUSBDeviceTransport : MRDeviceTransport {
  @private
	MRUSBDeviceEntry *_entry;
	NSArray *_pipeDescs;
	IOUSBDeviceInterface **_device;
	IOUSBInterfaceInterface **_interface;
	IONotificationPortRef _notificationPort;
	io_object_t _registeredNotification;
	NSDictionary *_pipes;
}

- (instancetype)initWithDeviceEntry:(MRUSBDeviceEntry *)entry desiredPipes:(NSArray *)descs;

- (NSArray *)pipesForDirection:(MRUSBTransferDirection)direction;

- (BOOL)scheduleRead:(NSError **)outError;

@end
