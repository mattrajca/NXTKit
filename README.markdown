NXTKit
======

NXTKit is a native (Snow Leopard-only) Cocoa framework for talking with Lego NXT devices. Bluetooth is currently the only supported transport protocol. Garbage Collected and non-GC environments are supported.

Basic Usage
-----------

1. Display the built-in `IOBluetoothDeviceSelectorController`.
2. Initialize a new `MRBluetoothDeviceTransport` object with an instance of `IOBluetoothDevice`, or a Bluetooth device address.
3. Initialize an instance of `MRNXTDevice` with the device transport created in the previous step.
4. Register yourself as a delegate of `MRNXTDevice`, and call `- connect:` .
5. Once a Bluetooth connection is established, you can send instances of `MRNXTCommand` to the device. If the specified response callback is not `NULL`, an instance of `MRNXTResponse` will be returned asynchronously. Commands execute serially in FIFO order.

Example
-------

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
        comm.filename = @"Whoops.rso";
        
        [nxtDevice enqueueCommand:comm responseBlock:NULL];
        [comm release];
    }

See the NXT-Browser project for a full, working sample that uses NXTKit.

About Filenames
---------------

All file names on the NXT can have a maximum length of 19 characters (15.3), and will be truncated when necessary. The following wildcards are also accepted:

    - Filename.Extension
    - *.(Extension)
    - Filename.*
    - *.*
