//
//  MRNXTDevice.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTDevice.h"

#import "MRNXTCommand.h"
#import "MRNXTResponse.h"
#import "MRUSBDeviceTransport.h"
#import "NSMutableArray+Queue.h"

#import <objc/runtime.h>

@interface MRNXTDevice ()

- (void)processQueue;
- (void)sendCurrentCommand;

@end


@implementation MRNXTDevice {
	NSMutableArray *_queue;
	MRNXTCommand *_currentCommand;
}

- (id)initWithTransport:(MRDeviceTransport *)aTransport {
	self = [super initWithTransport:aTransport];
	if (self) {
		_queue = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)enqueueCommand:(MRNXTCommand *)aCommand responseBlock:(MRNXTResponseBlock)block {
	NSParameterAssert(aCommand != nil);
	
	aCommand.responseBlock = block;
	
	[_queue mr_push:aCommand];
	
	[self processQueue];
}

- (void)processQueue {
	if ([_queue count] > 0 && !_currentCommand) {
		_currentCommand = [_queue mr_pop];
		
		[self sendCurrentCommand];
	}
}

- (void)sendCurrentCommand {
	NSData *data = [_currentCommand data];
	uint16_t length = OSSwapHostToLittleInt16(2 + [data length]);
	uint8_t type = [_currentCommand telegramType];
	uint8_t identifier = [_currentCommand identifier];
	
	NSMutableData *packet = [[NSMutableData alloc] init];
	
	if (![self.transport isKindOfClass:[MRUSBDeviceTransport class]]) {
		[packet appendBytes:&length length:sizeof(length)];
	}
	
	[packet appendBytes:&type length:sizeof(type)];
	[packet appendBytes:&identifier length:sizeof(identifier)];
	[packet appendData:data];
	
	NSError *error = nil;
	
	if (![self.transport writeData:packet error:&error]) {
		NSLog(@"Cannot write packet data: %@", error);
	}
}

- (void)wroteData {
	MRDeviceTransport *transport = self.transport;
	
	if ([transport isKindOfClass:[MRUSBDeviceTransport class]]) {
		MRUSBDeviceTransport *usbTransport = (MRUSBDeviceTransport *) transport;
		NSError *error = nil;
		
		if (![usbTransport scheduleRead:&error]) {
			NSLog(@"Cannot schedule read: %@", error);
		}
	}
}

- (void)receivedData:(NSData *)data {
	MRNXTResponseBlock block = _currentCommand.responseBlock;
	
	if (block) {
		NSData *fullData = nil;
		
		if ([self.transport isKindOfClass:[MRUSBDeviceTransport class]]) {
			fullData = [NSMutableData data];
			
			UInt8 bytesRead = [data length];
			UInt8 empty = 0;
			
			[(NSMutableData *) fullData appendBytes:&bytesRead length:sizeof(bytesRead)];
			[(NSMutableData *) fullData appendBytes:&empty length:sizeof(empty)];
			[(NSMutableData *) fullData appendData:data];
		}
		else {
			fullData = data;
		}
		
		MRNXTResponse *resp = [[[_currentCommand responseClass] alloc] initWithData:fullData];
		block(resp);
	}

	_currentCommand = nil;
	
	[self processQueue];
}

@end
