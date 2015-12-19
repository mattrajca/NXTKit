//
//  MRNXTCloseCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTCloseCommand.h"

@implementation MRNXTCloseCommand

- (NXTCommandType)type {
	return NXTCommandTypeSystem;
}

- (uint8_t)identifier {
	return 0x84;
}

- (NSData *)data {
	return [NSData dataWithBytes:&_handle length:sizeof(_handle)];
}

@end
