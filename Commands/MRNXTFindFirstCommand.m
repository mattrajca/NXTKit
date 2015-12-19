//
//  MRNXTFindFirstCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTFindFirstCommand.h"

#import "MRNXTFileResponse.h"

@implementation MRNXTFindFirstCommand

- (Class)responseClass {
	return [MRNXTFileResponse class];
}

- (NXTCommandType)type {
	return NXTCommandTypeSystem;
}

- (uint8_t)identifier {
	return 0x86;
}

- (NSData *)data {
	return [NSMutableData dataWithNXTFilename:_filename];
}

@end
