//
//  MRNXTDeleteCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTDeleteCommand.h"

@implementation MRNXTDeleteCommand

- (NXTCommandType)type {
	return NXTCommandTypeSystem;
}

- (uint8_t)identifier {
	return 0x85;
}

- (NSData *)data {
	return [NSMutableData dataWithNXTFilename:_filename];
}

@end
