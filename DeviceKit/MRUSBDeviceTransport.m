//
//  MRUSBDeviceTransport.m
//  DeviceKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRUSBDeviceTransport.h"

#import <IOKit/IOCFPlugIn.h>
#import <IOKit/IOMessage.h>

#import "MRUSBDeviceEntry.h"
#import "NSError+IOKit.h"

@implementation MRUSBDeviceTransport

#define READ_BUFFER_LEN 64

static void ReadCompletion (void *refCon, IOReturn result, void *arg0);
static void WriteCompletion (void *refCon, IOReturn result, void *arg0);

static void DeviceNotification (void *refCon, io_service_t service, natural_t messageType, void *messageArgument);

static char readBuffer[READ_BUFFER_LEN];

- (instancetype)init {
	return [self initWithDeviceEntry:nil desiredPipes:nil];
}

- (instancetype)initWithDeviceEntry:(MRUSBDeviceEntry *)entry desiredPipes:(NSArray *)descs {
	NSParameterAssert (entry != nil);
	NSParameterAssert (descs != nil);
	
	self = [super init];
	if (self) {
		_entry = entry;
		_pipeDescs = descs;

		_pipes = [NSDictionary dictionaryWithObjectsAndKeys:
				  [NSMutableArray array], [NSNumber numberWithInt:MRUSBTransferDirectionIn],
				  [NSMutableArray array], [NSNumber numberWithInt:MRUSBTransferDirectionOut],
				  [NSMutableArray array], [NSNumber numberWithInt:MRUSBTransferDirectionNone],
				  [NSMutableArray array], [NSNumber numberWithInt:MRUSBTransferDirectionAny], nil];
	}
	return self;
}

#pragma mark - Device Setup

- (BOOL)setupDevice:(NSError **)outError {
	IOCFPlugInInterface **plugInInterface = NULL;
	SInt32 score;
	IOReturn result;
	
	result = IOCreatePlugInInterfaceForService(_entry.service, kIOUSBDeviceUserClientTypeID, 
											   kIOCFPlugInInterfaceID, &plugInInterface, &score);
	
	if (result != kIOReturnSuccess) {
		if (outError)
			*outError = [NSError IOKitErrorWithReturnCode:result];
		
		return NO;
	}
	
	HRESULT herr = (*plugInInterface)->QueryInterface(plugInInterface,
													  CFUUIDGetUUIDBytes(kIOUSBDeviceInterfaceID),
													  (LPVOID *) &_device);
	
	(*plugInInterface)->Release(plugInInterface);
	
	if (herr != S_OK) {
		if (outError)
			*outError = [NSError IOKitErrorWithReturnCode:kIOReturnNotReady];
		
		return NO;
	}
	
	result = (*_device)->USBDeviceOpen(_device);
	
	if (result != kIOReturnSuccess) {
		[self close];
		
		if (outError)
			*outError = [NSError IOKitErrorWithReturnCode:result];
		
		return NO;
	}
	
	return YES;
}

- (IOReturn)setupInterfaceWithService:(io_service_t)service {
	IOCFPlugInInterface **plugInInterface = NULL;
	SInt32 score;
	IOReturn result;
	
	result = IOCreatePlugInInterfaceForService(service, kIOUSBInterfaceUserClientTypeID, 
											   kIOCFPlugInInterfaceID, &plugInInterface, &score);
	
	IOObjectRelease(service);
	
	if (result != kIOReturnSuccess)
		return result;
	
	HRESULT herr = (*plugInInterface)->QueryInterface(plugInInterface,
													  CFUUIDGetUUIDBytes(kIOUSBInterfaceInterfaceID),
													  (LPVOID *) &_interface);
	
	(*plugInInterface)->Release(plugInInterface);
	
	if (herr != S_OK)
		return kIOReturnNotReady;
	
	return kIOReturnSuccess;
}

- (BOOL)setupInterfaces:(NSError **)outError {
	IOUSBFindInterfaceRequest req;
	req.bAlternateSetting = kIOUSBFindInterfaceDontCare;
	req.bInterfaceClass = kIOUSBFindInterfaceDontCare;
	req.bInterfaceProtocol = kIOUSBFindInterfaceDontCare;
	req.bInterfaceSubClass = kIOUSBFindInterfaceDontCare;
	
	io_iterator_t iterator;
	IOReturn result;
	
	result = (*_device)->CreateInterfaceIterator(_device, &req, &iterator);
	
	if (result != kIOReturnSuccess) {
		[self close];
		
		if (outError)
			*outError = [NSError IOKitErrorWithReturnCode:result];
		
		return NO;
	}
	
	io_service_t interface;
	
	while ((interface = IOIteratorNext(iterator))) {
		IOReturn result = [self setupInterfaceWithService:interface];
		
		if (result != kIOReturnSuccess) {
			[self close];
			
			IOObjectRelease(iterator);
			
			if (outError)
				*outError = [NSError IOKitErrorWithReturnCode:result];
			
			return NO;
		}
		
		break; // only setup first interface for now
	}
	
	IOObjectRelease(iterator);
	
	return YES;
}

- (BOOL)openInterface:(NSError **)outError {
	IOReturn result = (*_interface)->USBInterfaceOpen(_interface);
	
	if (result != kIOReturnSuccess) {
		[self close];
		
		if (outError)
			*outError = [NSError IOKitErrorWithReturnCode:result];
		
		return NO;
	}
	
	return YES;
}

- (BOOL)openPipes:(NSError **)outError {
	UInt8 endpoints;
	IOReturn result;
	
	result = (*_interface)->GetNumEndpoints(_interface, &endpoints);
	
	if (result != kIOReturnSuccess) {
		[self close];
		
		if (outError)
			*outError = [NSError IOKitErrorWithReturnCode:result];
		
		return NO;
	}
	
	// ignore pipe 0 (control pipe)
	for (int n = 1; n <= endpoints; n++) {
		UInt8 direction, number, transferType, interval;
		UInt16 maxPacketSize;
		
		result = (*_interface)->GetPipeProperties(_interface, n, &direction, &number, &transferType, &maxPacketSize, &interval);
		
		if (result != kIOReturnSuccess) {
			[self close];
			
			if (outError)
				*outError = [NSError IOKitErrorWithReturnCode:result];
			
			return NO;
		}
		
		for (MRUSBDevicePipeDescriptor *desc in _pipeDescs) {
			if (desc.direction == direction && desc.type == transferType) {
				NSMutableArray *pipes = (NSMutableArray *) [self pipesForDirection:direction];
				[pipes addObject:[NSNumber numberWithInt:number]];
			}
		}
	}
	
	return YES;
}

- (BOOL)setupAsyncIO:(NSError **)outError {
	CFRunLoopSourceRef source = NULL;
	IOReturn result;
	
	result = (*_interface)->CreateInterfaceAsyncEventSource(_interface, &source);
	
	if (result != kIOReturnSuccess) {
		[self close];
		
		if (outError)
			*outError = [NSError IOKitErrorWithReturnCode:result];
		
		return NO;
	}
	
	CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
	
	return YES;
}

- (void)setupInterestNotification {
	if (!_notificationPort) {
		_notificationPort = IONotificationPortCreate(kIOMasterPortDefault);
		CFRunLoopSourceRef source = IONotificationPortGetRunLoopSource(_notificationPort);
		
		CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
	}
	
	IOServiceAddInterestNotification(_notificationPort, _entry.service, kIOGeneralInterest,
									 &DeviceNotification, (__bridge void *)self, &_registeredNotification);
}

#pragma mark - Core Transport

- (BOOL)open:(NSError **)outError {
	if (![self setupDevice:outError])
		return NO;
	
	if (![self setupInterfaces:outError])
		return NO;
	
	if (![self openInterface:outError])
		return NO;
	
	if (![self openPipes:outError])
		return NO;
	
	if (![self setupAsyncIO:outError])
		return NO;
	
	[self setupInterestNotification];
	[self opened];
	
	return YES;
}

- (void)close {
	if (_interface) {
		(*_interface)->USBInterfaceClose(_interface);
		(*_interface)->Release(_interface);
		_interface = NULL;
	}
	
	if (_device) {
		(*_device)->USBDeviceClose(_device);
		(*_device)->Release(_device);
		_device = NULL;
	}
	
	if (_registeredNotification) {
		IOObjectRelease(_registeredNotification);
		_registeredNotification = 0;
	}
	
	for (NSMutableArray *array in [_pipes allValues]) {
		[array removeAllObjects];
	}
	
	if (self.isOpen)
		[self closed];
}

- (BOOL)writeData:(NSData *)data error:(NSError **)outError {
	if (!self.open)
		return NO;
	
	IOReturn result;
	NSArray *outPipes = [self pipesForDirection:MRUSBTransferDirectionOut];
	
	if (![outPipes count]) {
		if (outError)
			*outError = [NSError IOKitErrorWithReturnCode:kIOReturnNotWritable];
		
		return NO;
	}
	
	UInt8 outNum = [[outPipes objectAtIndex:0] intValue]; // write to first out pipe for now
	
	result = (*_interface)->WritePipeAsync(_interface, outNum, (void *) [data bytes], [data length],
										   &WriteCompletion, (__bridge void *)self);
	
	if (result != kIOReturnSuccess) {
		if (outError)
			*outError = [NSError IOKitErrorWithReturnCode:result];
		
		return NO;
	}
	
	return YES;
}

- (BOOL)scheduleRead:(NSError **)outError {
	if (!self.open)
		return NO;
	
	IOReturn result;
	NSArray *inPipes = [self pipesForDirection:MRUSBTransferDirectionIn];
	
	if (![inPipes count]) {
		if (outError)
			*outError = [NSError IOKitErrorWithReturnCode:kIOReturnNotReadable];
		
		return NO;
	}
	
	UInt8 inNum = [[inPipes objectAtIndex:0] intValue]; // read from the first in pipe for now
	
	bzero(readBuffer, sizeof(readBuffer));
	
	result = (*_interface)->ReadPipeAsync(_interface, inNum, readBuffer,
										  READ_BUFFER_LEN, &ReadCompletion, (__bridge void *)self);
	
	if (result != kIOReturnSuccess) {
		if (outError)
			*outError = [NSError IOKitErrorWithReturnCode:result];
		
		return NO;
	}
	
	return YES;
}

#pragma mark - Utility

- (NSArray *)pipesForDirection:(MRUSBTransferDirection)direction {
	return [_pipes objectForKey:[NSNumber numberWithInt:direction]];
}

- (void)didReadBytesWithResult:(IOReturn)result number:(UInt32)number {
	if (result != kIOReturnSuccess)
		return;
	
	[self receivedData:[NSData dataWithBytes:readBuffer length:number]];
}

- (void)didWriteDataWithResult:(IOReturn)result {
	if (result == kIOReturnSuccess)
		[self wroteData];
}

static void ReadCompletion (void *refCon, IOReturn result, void *arg0) {
	MRUSBDeviceTransport *self = (__bridge MRUSBDeviceTransport *) refCon;
	size_t bytesRead = (size_t) arg0;
	
	[self didReadBytesWithResult:result number:bytesRead];
}

static void WriteCompletion (void *refCon, IOReturn result, void *arg0) {
	MRUSBDeviceTransport *self = (__bridge MRUSBDeviceTransport *) refCon;
	[self didWriteDataWithResult:result];
}

static void DeviceNotification (void *refCon, io_service_t service, natural_t messageType, void *messageArgument) {
	MRUSBDeviceTransport *self = (__bridge MRUSBDeviceTransport *) refCon;
	
	if (messageType == kIOMessageServiceIsTerminated) {
		[self close];
	}
}

#pragma mark -

@end
