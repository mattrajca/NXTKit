//
//  MRNXTOpenReadCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTOpenReadCommand.h"

#import "MRNXTHandleSizeResponse.h"

@implementation MRNXTOpenReadCommand

- (Class)responseClass {
	return [MRNXTHandleSizeResponse class];
}

- (NXTCommandType)type {
	return NXTCommandTypeSystem;
}

- (uint8_t)identifier {
	return 0x80;
}

- (NSData *)data {
	return [NSMutableData dataWithNXTFilename:_filename];
}

@end
