//
//  MRUSBDeviceEntry.h
//  DeviceKit
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

/* Represents a device service in the I/O Registry */

@class MRUSBDeviceEntry;

typedef void (^MRUSBDeviceEntryAdded) (MRUSBDeviceEntry *entry);
typedef void (^MRUSBDeviceEntryRemoved) (MRUSBDeviceEntry *entry);

@interface MRUSBDeviceEntry : NSObject

@property (readonly) io_service_t service;

+ (NSArray *)matchingDevicesForProductID:(int)pid vendorID:(int)vid;

+ (void)findMatchingDevicesForProductID:(int)pid vendorID:(int)vid
						  addedCallback:(MRUSBDeviceEntryAdded)added
						removedCallback:(MRUSBDeviceEntryRemoved)removed;

- (id)initWithService:(io_service_t)service;

@end
