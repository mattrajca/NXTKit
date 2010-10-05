//
//  MRNXTDevice.m
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTDevice.h"

#import "MRNXTCommand.h"
#import "NSMutableArray+Queue.h"

#import <objc/runtime.h>

@interface MRNXTDevice ()

- (void)processQueue;
- (void)sendCurrentCommand;

@end


@implementation MRNXTDevice

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
		_currentCommand = [[_queue mr_pop] retain];
		
		[self sendCurrentCommand];
	}
}

- (void)sendCurrentCommand {
	NSData *data = [_currentCommand data];
	uint16_t length = OSSwapHostToLittleInt16(2 + [data length]);
	uint8_t type = [_currentCommand telegramType];
	uint8_t identifier = [_currentCommand identifier];
	
	NSMutableData *packet = [[NSMutableData alloc] init];
	[packet appendBytes:&length length:sizeof(length)];
	[packet appendBytes:&type length:sizeof(type)];
	[packet appendBytes:&identifier length:sizeof(identifier)];
	[packet appendData:data];
	
	NSError *error = nil;
	
	if (![self.transport writeData:packet error:&error]) {
		NSLog(@"Cannot write packet data: %@", error);
	}
	
	[packet release];
}

- (void)receivedData:(NSData *)data {
	MRNXTResponseBlock block = _currentCommand.responseBlock;
	
	if (block) {
		MRNXTResponse *resp = [[[_currentCommand responseClass] alloc] initWithData:data];
		block(resp);
		
		[resp release];
	}
	
	[_currentCommand release];
	_currentCommand = nil;
	
	[self processQueue];
}

- (void)dealloc {
	[_queue release];
	[_currentCommand release];
	
	[super dealloc];
}

@end
