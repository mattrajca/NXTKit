NXTKit
======

NXTKit is a native (10.6+) Cocoa framework for talking with Lego NXT devices. Communication over both Bluetooth and USB is supported. To enforce a clean architecture, NXTKit is built on top of DeviceKit, thus separating transport communication details from higher-level functionality. Both Garbage Collected and non-Garbage Collected environments are supported.

Basic Usage
-----------

1. Check if a NXT brick is connected via USB. The `MRUSBDeviceEntry` class abstracts much of this. If a USB device can't be found, display an instance of `IOBluetoothDeviceSelectorController` (part of the IOBluetoothUI framework).
2. Construct a new `MRBluetoothDeviceTransport` or `MRUSBDeviceTransport`. Bluetooth should only be used when wireless connectivity is key or when USB isn't available, considering it uses more power.
3. Initialize an instance of `MRNXTDevice` with the device transport created in the previous step. Register yourself as a delegate of the device, and call `- open:` .
4. Once a Bluetooth or USB connection is established, you can enqueue subclasses of `MRNXTCommand` onto the device's work queue. If the passed response block is not `NULL`, an instance of `MRNXTResponse` will be provided in the callback block. Commands execute serially in FIFO order.

Example
-------

    NSArray *usbDevices = [MRUSBDeviceEntry matchingDevicesForProductID:0x2 vendorID:0x694];
    
    if ([usbDevices count]) {
        // setup USB transport
        return;
    }
    
    // else setup Bluetooth transport
    
    IOBluetoothDevice *device = ... ; /* returned from IOBluetoothDeviceSelectorController */
    
    MRBluetoothDeviceTransport *transport = [[MRBluetoothDeviceTransport alloc]
                                                    initWithBluetoothDevice:device];
    
    nxtDevice = [[MRNXTDevice alloc] initWithTransport:transport];
    [transport release];
    
    [nxtDevice setDelegate:self];
    
    if (![nxtDevice open:&error]) {
        // ... handle error
    }
    
    ...
    
    - (void)deviceDidOpen:(MRDevice *)aDevice {
        [self playSound];
    }
    
    - (void)playSound {
        MRNXTPlaySoundFileCommand *comm = [[MRNXTPlaySoundFileCommand alloc] init];
        comm.loop = NO;
        comm.filename = @"Woops.rso";
        
        [nxtDevice enqueueCommand:comm responseBlock:^(MRNXTResponse *response) {
            // work with response, check status, etc ...
        }];
        
        [comm release];
    }

See the [NXT-Browser](https://github.com/mattrajca/NXT-Browser) project for a full, working sample that utilizes NXTKit.

About Filenames
---------------

All filenames on the NXT can have a maximum length of 19 characters (15.3), and will be truncated when necessary. The following wildcards are also accepted:

    - Filename.Extension
    - *.(Extension)
    - Filename.*
    - *.*
