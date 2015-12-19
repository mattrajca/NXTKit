//
//  MRUSBDevicePipeDescriptor.h
//  DeviceKit
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

#import <IOKit/usb/IOUSBLib.h>

typedef enum {
	MRUSBTransferTypeControl = kUSBControl,
	MRUSBTransferTypeIsoc = kUSBIsoc,
	MRUSBTransferTypeBulk = kUSBBulk,
	MRUSBTransferTypeInterrupt = kUSBInterrupt,
	MRUSBTransferTypeAny = kUSBAnyType
} MRUSBTransferType;

typedef enum {
	MRUSBTransferDirectionOut = kUSBOut,
	MRUSBTransferDirectionIn = kUSBIn,
	MRUSBTransferDirectionNone = kUSBNone,
	MRUSBTransferDirectionAny = kUSBAnyDirn
} MRUSBTransferDirection;

@interface MRUSBDevicePipeDescriptor : NSObject

@property (readonly) MRUSBTransferType type;
@property (readonly) MRUSBTransferDirection direction;

+ (id)pipeDescriptorWithTransferType:(MRUSBTransferType)type direction:(MRUSBTransferDirection)dir;

- (id)initWithTransferType:(MRUSBTransferType)type direction:(MRUSBTransferDirection)dir;

@end
