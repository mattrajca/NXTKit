//
//  MRBluetoothDeviceTransport.h
//  DeviceKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRDeviceTransport.h"

@class IOBluetoothDevice, IOBluetoothRFCOMMChannel;
typedef struct BluetoothDeviceAddress BluetoothDeviceAddress;

/* supports RFCOMM communication */

@interface MRBluetoothDeviceTransport : MRDeviceTransport {
  @private
	IOBluetoothDevice *_bluetoothDevice;
	IOBluetoothRFCOMMChannel *_channel;
}

@property (readonly) IOBluetoothDevice *bluetoothDevice; /* use with care */

+ (id)deviceWithAddress:(const BluetoothDeviceAddress *)address;
+ (id)deviceWithBluetoothDevice:(IOBluetoothDevice *)device;

- (id)initWithAddress:(const BluetoothDeviceAddress *)address;
- (id)initWithBluetoothDevice:(IOBluetoothDevice *)device;

@end
