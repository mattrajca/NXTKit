//
//  MRNXTCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTCommand.h"

#import "MRNXTResponse.h"

@implementation MRNXTCommand

- (Class)responseClass {
	return [MRNXTResponse class];
}

- (NXTCommandType)type {
	return NXTCommandTypeDirect;
}

- (uint8_t)telegramType {
	if (self.type == NXTCommandTypeDirect) {
		return 0x0;
	}
	
	return 0x01;
}

- (uint8_t)identifier {
	@throw [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:@"'identifier' must be overriden"
								 userInfo:nil];
	
	return 0;
}

- (NSData *)data {
	return [NSData data];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"MRNXTCommand [type=%d, identifier=%d]",
			self.type, self.identifier];
}

@end
