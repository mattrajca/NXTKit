//
//  MRUSBDeviceEntry.m
//  DeviceKit
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

#import "MRUSBDeviceEntry.h"

#import <IOKit/usb/IOUSBLib.h>

@implementation MRUSBDeviceEntry {
	io_service_t _service;
}

static void MatchedService (void *refcon, io_iterator_t iterator);

+ (CFMutableDictionaryRef)newMatchingDictionaryForProductID:(int)pid vendorID:(int)vid {
	CFMutableDictionaryRef matchingDict = IOServiceMatching(kIOUSBDeviceClassName);
	
	CFNumberRef number = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &vid);
	CFDictionarySetValue(matchingDict, CFSTR(kUSBVendorID), number);
	CFRelease(number);
	
	number = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &pid);
	CFDictionarySetValue(matchingDict, CFSTR(kUSBProductID), number);
	CFRelease(number);
	
	return matchingDict;
}

+ (NSArray *)matchingDevicesForProductID:(int)pid vendorID:(int)vid {
	CFMutableDictionaryRef matchingDict = [self newMatchingDictionaryForProductID:pid vendorID:vid];
	
	io_iterator_t iterator;
	io_service_t device;
	
	if (IOServiceGetMatchingServices(kIOMasterPortDefault, matchingDict, &iterator) != kIOReturnSuccess)
		return nil;
	
	NSMutableArray *devices = [NSMutableArray array];
	
	while ((device = IOIteratorNext(iterator))) {
		MRUSBDeviceEntry *entry = [[MRUSBDeviceEntry alloc] initWithService:device];
		
		[devices addObject:entry];
	}
	
	IOObjectRelease(iterator);
	
	return devices;
}

+ (void)findMatchingDevicesForProductID:(int)pid vendorID:(int)vid
						  addedCallback:(MRUSBDeviceEntryAdded)added
						removedCallback:(MRUSBDeviceEntryRemoved)removed {
	
	// TODO: implement
	
	/*
	CFMutableDictionaryRef matchingDict = [self newMatchingDictionaryForProductID:pid vendorID:vid];
	
	IONotificationPortRef notificationPort = IONotificationPortCreate(kIOMasterPortDefault);
	CFRunLoopSourceRef source = IONotificationPortGetRunLoopSource(notificationPort);
	CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
	
	io_iterator_t iterator;
	
	IOServiceAddMatchingNotification(notificationPort, kIOFirstMatchNotification, matchingDict,
									 &MatchedService, (void *) self, &iterator);
	
	CFRunLoopRun();
	 */
}

/*
static void MatchedService (void *refcon, io_iterator_t iterator) {
	
}
 */

- (id)initWithService:(io_service_t)service {
	self = [super init];
	if (self) {
		_service = service;
	}
	return self;
}

- (void)dealloc {
	IOObjectRelease(_service);
}

@end
