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

@interface MRBluetoothDeviceTransport : MRDeviceTransport

@property (readonly) IOBluetoothDevice *bluetoothDevice; /* use with care */

+ (instancetype)deviceWithAddress:(const BluetoothDeviceAddress *)address;
+ (instancetype)deviceWithBluetoothDevice:(IOBluetoothDevice *)device;

- (instancetype)initWithAddress:(const BluetoothDeviceAddress *)address;
- (instancetype)initWithBluetoothDevice:(IOBluetoothDevice *)device;

@end
